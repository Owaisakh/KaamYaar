-- KaamYaar Phase 7 Backend Schema Updates

-- The `bookings` table has a `status` column with a CHECK constraint.
-- We need to update this constraint to allow the new job execution statuses.

BEGIN;

-- Drop the existing check constraint on the status column
ALTER TABLE bookings DROP CONSTRAINT IF EXISTS bookings_status_check;

-- Add the new check constraint with the expanded statuses
ALTER TABLE bookings ADD CONSTRAINT bookings_status_check 
  CHECK (status IN (
    'pending', 
    'assigned', 
    'accepted', 
    'on_the_way', 
    'arrived', 
    'inspect_problem', 
    'quote_final_price', 
    'customer_approves', 
    'in_progress', 
    'completed', 
    'cancelled'
  ));

COMMIT;

-- Note: In Supabase, if you already have existing rows with statuses not in this list, 
-- the alter table command might fail. But since we are adding new statuses and keeping the old ones, it should succeed.
