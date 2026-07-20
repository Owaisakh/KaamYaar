-- KaamYaar Backend Schema (v1)

-- Enable required extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ==========================================
-- 1. USERS
-- ==========================================
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    phone TEXT UNIQUE NOT NULL,
    full_name TEXT NOT NULL,
    email TEXT NULL,
    profile_image TEXT NULL,
    role TEXT NOT NULL CHECK (role IN ('customer', 'worker', 'admin')),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

-- ==========================================
-- 2. SERVICES
-- ==========================================
CREATE TABLE services (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL,
    slug TEXT UNIQUE NOT NULL,
    icon TEXT NULL,
    description TEXT NULL,
    base_price DECIMAL NOT NULL DEFAULT 0.0,
    is_active BOOLEAN DEFAULT TRUE,
    sort_order INT DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

-- ==========================================
-- 3. WORKERS
-- ==========================================
CREATE TABLE workers (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    service_id UUID NOT NULL REFERENCES services(id) ON DELETE RESTRICT,
    bio TEXT NULL,
    experience_years INT DEFAULT 0,
    hourly_rate DECIMAL DEFAULT 0.0,
    rating DECIMAL DEFAULT 0.0,
    total_reviews INT DEFAULT 0,
    completed_jobs INT DEFAULT 0,
    verification_status TEXT DEFAULT 'pending' CHECK (verification_status IN ('pending', 'approved', 'rejected')),
    online_status BOOLEAN DEFAULT FALSE,
    response_rate DECIMAL DEFAULT 100.0,
    service_radius_km INT DEFAULT 10,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);
CREATE INDEX idx_workers_user_id ON workers(user_id);
CREATE INDEX idx_workers_service_id ON workers(service_id);

-- ==========================================
-- 4. WORKER_DOCUMENTS
-- ==========================================
CREATE TABLE worker_documents (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    worker_id UUID NOT NULL REFERENCES workers(id) ON DELETE CASCADE,
    document_type TEXT NOT NULL CHECK (document_type IN ('cnic', 'selfie', 'certificate')),
    file_url TEXT NOT NULL,
    status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'approved', 'rejected')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);
CREATE INDEX idx_worker_docs_worker_id ON worker_documents(worker_id);

-- ==========================================
-- 5. ADDRESSES
-- ==========================================
CREATE TABLE addresses (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    label TEXT NOT NULL,
    address TEXT NOT NULL,
    latitude DECIMAL NOT NULL,
    longitude DECIMAL NOT NULL,
    is_default BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);
CREATE INDEX idx_addresses_user_id ON addresses(user_id);

-- ==========================================
-- 6. BOOKINGS
-- ==========================================
CREATE TABLE bookings (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    customer_id UUID NOT NULL REFERENCES users(id),
    worker_id UUID NULL REFERENCES workers(id),
    service_id UUID NOT NULL REFERENCES services(id),
    address_id UUID NOT NULL REFERENCES addresses(id),
    problem_description TEXT NOT NULL,
    scheduled_time TIMESTAMP WITH TIME ZONE NOT NULL,
    estimated_price DECIMAL NULL,
    final_price DECIMAL NULL,
    status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'assigned', 'accepted', 'on_the_way', 'arrived', 'in_progress', 'completed', 'cancelled')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);
CREATE INDEX idx_bookings_customer_id ON bookings(customer_id);
CREATE INDEX idx_bookings_worker_id ON bookings(worker_id);

-- ==========================================
-- 7. BOOKING_PHOTOS
-- ==========================================
CREATE TABLE booking_photos (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    booking_id UUID NOT NULL REFERENCES bookings(id) ON DELETE CASCADE,
    image_url TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);
CREATE INDEX idx_booking_photos_booking_id ON booking_photos(booking_id);

-- ==========================================
-- 8. WORKER_LOCATION
-- ==========================================
CREATE TABLE worker_location (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    worker_id UUID NOT NULL REFERENCES workers(id) ON DELETE CASCADE,
    booking_id UUID NULL REFERENCES bookings(id) ON DELETE CASCADE,
    latitude DECIMAL NOT NULL,
    longitude DECIMAL NOT NULL,
    accuracy DECIMAL NULL,
    recorded_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);
CREATE INDEX idx_worker_loc_worker_id ON worker_location(worker_id);
CREATE INDEX idx_worker_loc_booking_id ON worker_location(booking_id);

-- ==========================================
-- 9. PAYMENTS
-- ==========================================
CREATE TABLE payments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    booking_id UUID NOT NULL REFERENCES bookings(id),
    amount DECIMAL NOT NULL,
    method TEXT NOT NULL CHECK (method IN ('cash', 'easypaisa', 'jazzcash')),
    status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'success', 'failed')),
    transaction_reference TEXT NULL,
    paid_at TIMESTAMP WITH TIME ZONE NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);
CREATE INDEX idx_payments_booking_id ON payments(booking_id);

-- ==========================================
-- 10. REVIEWS
-- ==========================================
CREATE TABLE reviews (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    booking_id UUID UNIQUE NOT NULL REFERENCES bookings(id),
    customer_id UUID NOT NULL REFERENCES users(id),
    worker_id UUID NOT NULL REFERENCES workers(id),
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    review TEXT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

-- ==========================================
-- 11. NOTIFICATIONS
-- ==========================================
CREATE TABLE notifications (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    type TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    sent_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);
CREATE INDEX idx_notif_user_id ON notifications(user_id);

-- ==========================================
-- 12. BOOKING_STATUS_HISTORY
-- ==========================================
CREATE TABLE booking_status_history (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    booking_id UUID NOT NULL REFERENCES bookings(id) ON DELETE CASCADE,
    old_status TEXT NULL,
    new_status TEXT NOT NULL,
    changed_by UUID NOT NULL REFERENCES users(id),
    changed_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

-- ==========================================
-- 13. WORKER_AVAILABILITY
-- ==========================================
CREATE TABLE worker_availability (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    worker_id UUID NOT NULL REFERENCES workers(id) ON DELETE CASCADE,
    day_of_week INT NOT NULL CHECK (day_of_week >= 0 AND day_of_week <= 6),
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    enabled BOOLEAN DEFAULT TRUE
);

-- ==========================================
-- 14. ADMIN_ACTIONS
-- ==========================================
CREATE TABLE admin_actions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    admin_id UUID NOT NULL REFERENCES users(id),
    action TEXT NOT NULL,
    target_type TEXT NOT NULL,
    target_id UUID NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

-- ==========================================
-- STORAGE BUCKETS
-- ==========================================
-- (This uses Supabase's internal storage schema)
INSERT INTO storage.buckets (id, name, public) VALUES ('profile-images', 'profile-images', true) ON CONFLICT DO NOTHING;
INSERT INTO storage.buckets (id, name, public) VALUES ('worker-documents', 'worker-documents', false) ON CONFLICT DO NOTHING;
INSERT INTO storage.buckets (id, name, public) VALUES ('booking-photos', 'booking-photos', true) ON CONFLICT DO NOTHING;

-- ==========================================
-- ROW LEVEL SECURITY (RLS)
-- ==========================================

-- Enable RLS on all tables
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE addresses ENABLE ROW LEVEL SECURITY;
ALTER TABLE bookings ENABLE ROW LEVEL SECURITY;
ALTER TABLE payments ENABLE ROW LEVEL SECURITY;
ALTER TABLE notifications ENABLE ROW LEVEL SECURITY;

-- Note: In a production Supabase app, we link users.id to auth.users.id
-- For brevity, here are basic policies assuming user.id matches auth.uid()

-- Users can read their own data
CREATE POLICY "Users can read own data" ON users FOR SELECT USING (auth.uid() = id);
-- Users can update their own data
CREATE POLICY "Users can update own data" ON users FOR UPDATE USING (auth.uid() = id);

-- Addresses: users manage their own
CREATE POLICY "Users can manage their addresses" ON addresses FOR ALL USING (auth.uid() = user_id);

-- Bookings: Customers can read their bookings. Workers can read assigned bookings.
CREATE POLICY "Customers view own bookings" ON bookings FOR SELECT USING (auth.uid() = customer_id);
CREATE POLICY "Workers view assigned bookings" ON bookings FOR SELECT USING (auth.uid() IN (SELECT user_id FROM workers WHERE id = bookings.worker_id));

-- (Add more fine-grained RLS as needed for full production safety)

-- ==========================================
-- REALTIME EVENTS ENABLEMENT
-- ==========================================
-- Add relevant tables to the supabase_realtime publication
BEGIN;
  DROP PUBLICATION IF EXISTS supabase_realtime;
  CREATE PUBLICATION supabase_realtime;
COMMIT;
ALTER PUBLICATION supabase_realtime ADD TABLE bookings;
ALTER PUBLICATION supabase_realtime ADD TABLE worker_location;
ALTER PUBLICATION supabase_realtime ADD TABLE payments;
ALTER PUBLICATION supabase_realtime ADD TABLE reviews;
ALTER PUBLICATION supabase_realtime ADD TABLE notifications;

