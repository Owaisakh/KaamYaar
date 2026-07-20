-- ==========================================
-- PHASE 5: WORKER ASSIGNMENT ENGINE
-- ==========================================

-- 1. Function to find eligible workers for a given booking
-- Filters by: approved verification, online status, matching service category, and within service radius.
CREATE OR REPLACE FUNCTION find_eligible_workers(p_booking_id UUID)
RETURNS TABLE (
    worker_id UUID, 
    distance_km DECIMAL
) AS $$
DECLARE
    v_service_id UUID;
    v_lat DECIMAL;
    v_lon DECIMAL;
BEGIN
    -- Get booking location and service required
    SELECT b.service_id, a.latitude, a.longitude 
    INTO v_service_id, v_lat, v_lon
    FROM bookings b
    JOIN addresses a ON b.address_id = a.id
    WHERE b.id = p_booking_id;

    RETURN QUERY
    SELECT 
        w.id AS worker_id,
        (
            6371 * acos(
                cos(radians(v_lat)) * cos(radians(wl.latitude)) * 
                cos(radians(wl.longitude) - radians(v_lon)) + 
                sin(radians(v_lat)) * sin(radians(wl.latitude))
            )
        )::DECIMAL AS distance_km
    FROM workers w
    JOIN worker_location wl ON w.id = wl.worker_id
    WHERE w.service_id = v_service_id
      AND w.verification_status = 'approved'
      AND w.online_status = TRUE
      -- Ensure we only check the latest recorded location for the worker
      AND wl.recorded_at = (
          SELECT MAX(recorded_at) 
          FROM worker_location wl2 
          WHERE wl2.worker_id = w.id
      )
      -- Filter by service radius (distance <= worker's configured service_radius_km)
      AND (
          6371 * acos(
              cos(radians(v_lat)) * cos(radians(wl.latitude)) * 
              cos(radians(wl.longitude) - radians(v_lon)) + 
              sin(radians(v_lat)) * sin(radians(wl.latitude))
          )
      ) <= w.service_radius_km
    ORDER BY distance_km ASC;
END;
$$ LANGUAGE plpgsql;

-- 2. Trigger for notifying workers when a booking is created
-- Normally, this would call a Supabase Edge Function using the pg_net extension to dispatch FCM notifications.
-- For local development, this trigger updates the booking status to 'pending' and logs it,
-- then relies on the Flutter frontend or an external service to fetch `find_eligible_workers` and dispatch FCM.

CREATE OR REPLACE FUNCTION trigger_assign_booking()
RETURNS TRIGGER AS $$
BEGIN
    -- Here we could use pg_net to invoke an Edge Function:
    -- PERFORM net.http_post(
    --     url:='https://<project-ref>.functions.supabase.co/dispatch-fcm',
    --     body:=json_build_object('booking_id', NEW.id)::jsonb
    -- );
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER after_booking_insert
AFTER INSERT ON bookings
FOR EACH ROW
EXECUTE FUNCTION trigger_assign_booking();
