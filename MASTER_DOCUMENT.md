# KaamYaar — Master Product Document (V1)

## 1. Product Overview

**Product Name:** KaamYaar

**Tagline:** Trusted Help, On Demand.

KaamYaar is a mobile marketplace that connects customers with local service professionals such as electricians, plumbers, AC technicians, carpenters, cleaners, painters, and appliance repair experts.

KaamYaar acts as the middleman between workers and customers, similar to Uber and Careem, but for home services.

---

## 2. Mission

Build the most trusted home-services platform in Pakistan.

Goals:

- Fast booking
- Verified workers
- Live tracking
- Transparent pricing
- Smooth experience

---

## 3. User Roles

### Customer

- Sign up with phone OTP
- Browse services
- Create bookings
- Upload photos
- Track workers
- Chat with workers
- Pay
- Review workers

### Worker

- Register
- Upload documents
- Select categories
- Go online/offline
- Accept bookings
- Navigate to customers
- Chat
- Track earnings

### Admin

- Approve workers
- Manage users
- View analytics
- Handle disputes
- Manage services

---

## 4. Categories

### Launch Categories

- Electrician
- Plumber
- AC Repair
- Carpenter
- Cleaner
- Painter
- Appliance Repair

### Future Categories

- Movers
- Pest Control
- Solar
- CCTV
- Internet Technician

---

## 5. App Flow

### Customer Flow

Open App → Login → Home → Select Service → Describe Issue → Upload Images → Select Address → Confirm Booking → Worker Assigned → Live Tracking → Payment → Review

### Worker Flow

Open App → Login → Verification → Dashboard → Go Online → Receive Booking → Accept → Navigate → Complete Job → Receive Payment

---

## 6. Core Features

### Authentication

- Phone OTP
- Session persistence
- Secure login

### Booking

- Create booking
- Upload images
- Schedule jobs
- Add notes

### Worker Matching

Rules:

- Worker must be online
- Worker must be verified
- Worker must match service category
- Worker must be nearby

### Tracking

- Google Maps integration
- Realtime location
- ETA

### Payments

Version 1:

- Cash only

Version 2:

- Easypaisa
- JazzCash
- Bank cards

### Reviews

- Rating system
- Written reviews
- Worker reputation

---

## 7. Pricing Model

KaamYaar uses a hybrid pricing model.

Customer creates booking → KaamYaar suggests price range → Worker checks problem → Worker confirms final price → Customer approves.

### Example Prices

- Fan installation: Rs. 800–1200
- Pipe repair: Rs. 1000–2500
- AC service: Rs. 1500–3000

---

## 8. Monetization

Version 1:

- Zero commission

Version 2:

- 5–10% commission

Future:

- Featured workers
- Premium subscriptions
- Emergency booking fees

---

## 9. UI / UX

Theme:

- Premium
- Modern
- Minimal

Colors:

- Primary: Purple → Blue gradient
- Accent: Green
- Error: Red
- Background: White

Font:

- Inter

Rules:

- One primary action per screen
- Large buttons
- Clear navigation
- Minimal clutter

---

## 10. Technical Stack

Frontend:

- Flutter

Backend:

- Supabase

Database:

- PostgreSQL

State Management:

- Riverpod

Navigation:

- GoRouter

Maps:

- Google Maps

Notifications:

- Firebase Cloud Messaging

---

## 11. Architecture

UI → Presentation Layer → Use Cases → Repositories → Supabase → Database

Rules:

- UI never accesses database directly
- Business logic stays in the domain layer

---

## 12. Database Tables

- users
- workers
- services
- addresses
- bookings
- booking_photos
- payments
- reviews
- worker_locations
- notifications
- booking_status_history
- worker_documents

Each table includes:

- UUID
- created_at
- updated_at
- Row-level security

---

## 13. Security

- JWT authentication
- Supabase RLS
- OTP expiry
- Rate limiting
- Secure uploads
- Input validation
- No secret keys inside app

---

## 14. Notifications

### Customer

- Booking created
- Worker assigned
- Worker arrived
- Payment complete

### Worker

- New booking
- Booking cancelled
- Payment received

---

## 15. Analytics

Track:

- Signups
- Active users
- Bookings
- Revenue
- Worker acceptance rate
- Cancellation rate

---

## 16. Future Features

- Chat
- Voice notes
- Referral program
- Wallet
- Coupons
- AI pricing
- Favorites
- Multi-language support

---

## 17. Folder Structure

kaamyaar/

- docs/
- mobile/
- backend/
- assets/
- lib/
- core/
- features/
- auth/
- booking/
- tracking/
- worker/
- profile/
- admin/

---

## 18. Development Rules

- Build mobile first
- Keep screens simple
- Optimize performance
- Test after every feature
- Do not add unnecessary features
- Every button must have a purpose
