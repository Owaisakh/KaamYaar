-- Phase 1 to 5 Retrofits: Aligning with MASTER_DOCUMENT.md

-- We need to add the new statuses for the hybrid pricing model to the bookings table.
-- The current constraint checks for ('pending', 'assigned', 'accepted', 'on_the_way', 'arrived', 'in_progress', 'completed', 'cancelled')
-- We need to add: 'inspect_problem', 'quote_final_price', 'customer_approves'

BEGIN;

-- Drop the existing constraint (assuming it was named bookings_status_check by default, but it's safer to recreate or alter the table)
-- Supabase/PostgreSQL usually names the constraint `bookings_status_check`. 
-- If it fails, we might need to find the exact constraint name.
ALTER TABLE bookings DROP CONSTRAINT IF EXISTS bookings_status_check;

-- Add the new constraint with all required statuses
ALTER TABLE bookings ADD CONSTRAINT bookings_status_check CHECK (status IN (
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
