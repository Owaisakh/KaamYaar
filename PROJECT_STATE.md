# KaamYaar Project State

## 🤖 AI Agent Instructions
When you are invoked to work on this project, follow these exact steps:
1. **Read this file** carefully to understand the overall architecture and current progress.
2. **Identify the active phase** (look for `[IN PROGRESS]`). Read the specific tasks for that phase.
3. **Review existing code** related to the phase. Follow the established Clean Architecture and Design System.
4. **Implement the requirements** for the current phase.
5. **Verify your changes** by running tests or the app.
6. **Commit the code** using Git.
7. **Update this file**: Change `[❌]` to `[✅]` for completed tasks, and update the phase status if a phase is fully completed.
8. **End your turn** and summarize your work.

---

## 🏃 How to Run the Project
- **Frontend (Flutter):** 
  - Run `flutter pub get` inside the `kaamyaar` directory to install dependencies.
  - **For Web (Chrome):** Run `flutter run -d chrome` in the `kaamyaar` directory to preview on the web.
  - **For Mobile:** Ensure an emulator or physical device is running and run `flutter run` in the `kaamyaar` directory.
- **Backend (Supabase):** 
  - We are using Supabase. Most backend changes will be SQL scripts executed in the Supabase Dashboard, unless configured via the Supabase CLI locally.

---

## 💬 Prompt for Next Chat
*Copy and paste the exact text below into a new chat to kick off the next agent:*
> "Hello! Please read the `PROJECT_STATE.md` file in the root directory. Determine which phase is currently marked as `[IN PROGRESS]` or `[PENDING]` and begin executing the tasks listed for it. Update the state file changing `[❌]` to `[✅]` as you finish tasks and commit your code when done."

---

## 🏗 Project Architecture & Stack
- **Frontend:** Flutter (Mobile Only - Android first)
- **Backend/Database:** Supabase (PostgreSQL, Auth, Storage, Realtime)
- **State Management:** Riverpod
- **Routing:** GoRouter
- **Maps/Location:** Google Maps API
- **Notifications:** Firebase Cloud Messaging (FCM)
- **Design System:** Modern, premium, purple (#7C3AED) to blue (#2563EB) gradients, Inter font.
- **Architecture Pattern:** Clean Architecture (Domain, Data, Presentation layers organized by feature).

---

## 🚀 Project Phases & Progress Tracker

### Phase 1: Project Initialization & Infrastructure `[COMPLETED]`
- [✅] Initialize Flutter project (`kaamyaar`).
- [✅] Initialize Git repository.
- [✅] Setup repository structure (`lib/core`, `lib/features`, etc.).
- [✅] Initialize Supabase project and connect to Flutter.
- [✅] Implement Design System (Colors, Typography, Spacing, Theme).
- [✅] Setup core routing (GoRouter) and state management (Riverpod).

### Phase 2: Database Schema & Backend Setup `[COMPLETED]`
- [✅] Create core tables: `users`, `services`, `workers`, `addresses`, `bookings`, `booking_photos`, `worker_location`, `payments`, `reviews`, `notifications`, `booking_status_history`, `worker_documents`.
- [✅] Setup Row Level Security (RLS) policies.
- [✅] Setup Supabase Storage buckets (`profile-images`, `worker-documents`, `booking-photos`).
- [✅] Implement database triggers for realtime events.

### Phase 3: Authentication & User Profiles `[COMPLETED]`
- [✅] Implement Phone OTP authentication via Supabase.
- [✅] Build Splash and Role Selection screens (Customer vs Worker).
- [✅] Customer Profile creation & Address management.
- [✅] Worker Profile creation & Verification document upload.

### Phase 4: Customer App - Home & Booking Flow `[COMPLETED]`
- [✅] Build Home Screen (Hero, Service Grid, Emergency Card).
- [✅] Implement Service Search.
- [✅] Build Booking Flow: Step 1 (Issue description & photo), Step 2 (Location), Step 3 (Schedule & Suggested Price Range), Step 4 (Confirm).
- [✅] Save booking to backend (Status: `pending`).

### Phase 5: Worker Assignment Engine (Backend & Realtime) `[COMPLETED]`
- [✅] Implement assignment logic (filter by approved, online, category, distance).
- [✅] Dispatch notifications to eligible workers (FCM).
- [✅] Setup realtime listeners on the app side to update UI on assignment.

### Phase 6: Worker App - Dashboard & Job Acceptance `[COMPLETED]`
- [✅] Build Worker Dashboard (Earnings, Active/Pending Jobs).
- [✅] Implement Online/Offline toggle.
- [✅] Job Request UI (Accept/Reject).
- [✅] Update booking status to `accepted` upon worker acceptance.

### Phase 7: Realtime Tracking & Job Execution `[COMPLETED]`
- [✅] Implement Worker location broadcasting (GPS tracking).
- [✅] Build Live Tracking map for Customer (showing Worker ETA).
- [✅] Worker flow: `on_the_way` -> `arrived` -> `inspect_problem` -> `quote_final_price` -> `customer_approves` -> `in_progress` -> `completed`.

### Phase 8: Payments, Ratings, & History `[COMPLETED]`
- [✅] Generate payment record on job completion (Version 1: Cash only, Version 2: EasyPaisa/Cards).
- [✅] Build Payment screen for Customer.
- [✅] Build Rating & Review screen.
- [✅] Build Booking History tabs (Active, Completed, Cancelled).

### Phase 9: Admin Dashboard & Analytics (Optional/Later) `[COMPLETED]`
- [✅] View and approve worker verification requests.
- [✅] Monitor active bookings and revenue.

### Phase 10: Testing, Polish & Release `[COMPLETED]`
- [✅] Comprehensive testing (Unit, Widget, Integration).
- [✅] Empty states, Loading skeletons, Error handling.
- [✅] Performance audit (<3sec cold start, <300ms transitions).

---

**Last Updated:** Phase 10 is completed. The app has been polished with empty states, loading skeletons, and basic tests. It is now ready for release.
