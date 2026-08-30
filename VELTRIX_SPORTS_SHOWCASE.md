# VELTRIX SPORTS
## Project Showcase Document

---

# EXECUTIVE SUMMARY

| Item | Details |
|------|---------|
| **Project** | Veltrix Sports |
| **Type** | Sports Platform (Coaching, Events, Ticketing) |
| **Platforms** | Android, iOS, Web |
| **Timeline** | 2 Weeks MVP |
| **Total Budget** | ₹99,800 |
| **Team** | 2 Flutter + 1 Backend |

---

# 1. WHAT WE'RE BUILDING

## 1.1 Three Core Modules

```
┌─────────────────────────────────────────────────────────────┐
│                    VELTRIX SPORTS                            │
├──────────────────┬──────────────────┬───────────────────────┤
│  TRAINING PLANS  │     EVENTS       │     TICKETING         │
├──────────────────┼──────────────────┼───────────────────────┤
│ • Coach profiles │ • Event listing  │ • Seat selection      │
│ • Video sessions │ • Registration   │ • QR tickets          │
│ • Progress track │ • QR check-in    │ • Payment gateway     │
│ • B2B & B2C      │ • Calendar sync  │ • Transfer tickets    │
└──────────────────┴──────────────────┴───────────────────────┘
```

---

# 2. APP SCREENS (28 Total)

## 2.1 Navigation Structure

```
Bottom Navigation:
┌─────────┬─────────┬─────────┬─────────┐
│  HOME   │ TRAINING│ EVENTS  │ PROFILE │
│   🏠    │   📚    │   🎫    │   👤    │
└─────────┴─────────┴─────────┴─────────┘
```

## 2.2 Screen Flow

```
Onboarding → Login → Home
                        ↓
          ┌─────────────┼─────────────┐
          ↓             ↓             ↓
      Training       Events       Tickets
          ↓             ↓             ↓
      Details        Details      Details
          ↓             ↓             ↓
      Book/Start    Register      Book
          ↓             ↓             ↓
      Payment       Payment      Payment
          ↓             ↓             ↓
      Success       Success      Success
```

---

# 3. DETAILED SCREENS

## 3.1 Onboarding (4 Screens)

| Screen | Elements |
|--------|----------|
| **Splash** | Logo, Tagline "Train. Compete. Win." |
| **Welcome 1** | Image, "Find Expert Coaches", Next button |
| **Welcome 2** | Image, "Discover Events", Next button |
| **Welcome 3** | Image, "Book Tickets", Get Started button |

## 3.2 Authentication (4 Screens)

| Screen | Elements |
|--------|----------|
| **Login** | Email, Password, Remember Me, Google/Apple login, Forgot Password |
| **Sign Up** | Name, Email, Phone, Password, User Type (Coach/Athlete) |
| **Forgot Password** | Email input, Send Reset Link button |
| **OTP Verify** | 6-digit code, Resend OTP, Timer |

## 3.3 Home Screen (1 Screen)

| Section | Elements |
|---------|----------|
| **Header** | Profile picture, Greeting, Search, Notifications, Cart |
| **Quick Actions** | Training Plans, Events, Tickets, Progress (4 cards) |
| **Featured** | Featured Events, Popular Coaches, Trending Plans |
| **Upcoming** | Event cards with Book Now button |
| **Recommended** | Training plan cards with Start Plan button |

## 3.4 Training Plans (4 Screens)

| Screen | Elements |
|--------|----------|
| **Plans List** | Search, Filter (sport, level, price), Sort, Plan cards |
| **Plan Details** | Hero image, Coach info, Duration, Level, Price, Schedule, Reviews, Start Plan button |
| **Session** | Video player, Timer, Exercises list, Complete/Skip buttons |
| **Progress** | Total sessions, Streak, Hours trained, Charts, History |

## 3.5 Events (4 Screens)

| Screen | Elements |
|--------|----------|
| **Events List** | Search, Filter (sport, location, date), Sort, Event cards |
| **Event Details** | Hero image, Date/Time, Location map, Organizer, Rules, Prize pool, Register button |
| **Registration** | Event summary, Fee breakdown, Participant details, Emergency contact, Pay Now button |
| **Check-in** | QR code, Event info, Check-in status |

## 3.6 Tickets (4 Screens)

| Screen | Elements |
|--------|----------|
| **Tickets List** | Search, Filter, Sort, Ticket cards |
| **Ticket Details** | Event image, Venue, Seat selection, Ticket type, Quantity +/-, Total, Buy Tickets button |
| **Seat Selection** | Interactive seat map, Legend, Selected seats list, Price summary |
| **Confirmation** | Booking ID, Event details, Seat details, QR code, Download/Add to Wallet buttons |

## 3.7 Cart & Payment (4 Screens)

| Screen | Elements |
|--------|----------|
| **Cart** | Cart items, Remove button, Quantity +/-, Promo code, Total, Checkout button |
| **Checkout** | Order summary, Payment methods (Razorpay, UPI, Card, Net Banking), Pay Now button |
| **Success** | Success icon, Amount paid, Transaction ID, Booking ID, View Tickets button |
| **Failed** | Error icon, Error message, Retry button |

## 3.8 Profile (4 Screens)

| Screen | Elements |
|--------|----------|
| **Profile** | Avatar, Name, Email, Phone, Member since, Edit Profile, My Bookings/Tickets/Training, Settings, Logout |
| **Edit Profile** | Change avatar, Name, Email, Phone, DOB, Gender, Bio, Sport, Save button |
| **My Bookings** | Tabs (Upcoming/Past), Booking cards, View Details/Cancel buttons |
| **My Tickets** | Tabs (Upcoming/Past), Ticket cards, QR Code/Download buttons |

## 3.9 Coaches (3 Screens)

| Screen | Elements |
|--------|----------|
| **Coach List** | Search, Filter (sport, rating, price), Coach cards |
| **Coach Profile** | Avatar, Name, Sport, Rating, Reviews, Experience, Bio, Plans, Events, Book Session button |
| **Book Session** | Coach info, Session type (1-on-1/Group), Date/Time picker, Duration, Location, Price, Confirm button |

## 3.10 Common Elements

| Element | Types |
|---------|-------|
| **Buttons** | Primary (Blue), Secondary (Outline), Icon buttons |
| **Toast Messages** | Success (Green), Error (Red), Warning (Yellow) |
| **Loading** | Skeleton screens, Circular progress, Linear progress |
| **Empty States** | Illustration + Title + Description + Action button |
| **Errors** | No internet, Server error with Retry button |

---

# 4. TECHNICAL ARCHITECTURE

## 4.1 Tech Stack

| Layer | Technology |
|-------|------------|
| **Frontend** | Flutter 3.41.9, Dart 3.11.5 |
| **State Management** | BLoC |
| **Navigation** | GoRouter |
| **HTTP Client** | Dio |
| **Local Storage** | Hive |
| **Backend** | Firebase / AWS |
| **Database** | PostgreSQL / Firestore |
| **Payment** | Razorpay |
| **Auth** | Firebase Auth |

## 4.2 Project Structure

```
veltrix_sports/
├── lib/
│   ├── core/           # Theme, Utils, Network
│   ├── features/       # Auth, Home, Training, Events, Tickets, Profile
│   └── main.dart
├── assets/             # Images, Icons, Fonts
├── android/
├── ios/
├── web/
└── tests/
```

---

# 5. DEVELOPMENT TIMELINE

## 2-Week Sprint Plan

| Day | Focus | Deliverables |
|-----|-------|--------------|
| **1** | Backend Setup | Database, Auth APIs, Basic structure |
| **2** | Flutter Setup | Project structure, Theme, Navigation |
| **3** | Auth Screens | Login, Signup, OTP, Forgot Password |
| **4** | Home Dashboard | Home screen, Quick actions, Featured |
| **5** | Training Plans | Plans list, Plan details, Sessions |
| **6** | Events | Events list, Event details, Registration |
| **7** | Ticketing | Tickets list, Seat selection, Booking |
| **8** | Payments | Razorpay integration, Cart, Checkout |
| **9** | Testing | Bug fixes, Performance, Polish |
| **10** | Deployment | Build, Upload, Submit for review |

---

# 6. COST BREAKDOWN

## 6.1 Development Cost

| Item | Cost |
|------|------|
| 2 Flutter Developers (10 days) | ₹40,000 |
| 1 Backend Developer (5 days) | ₹15,000 |
| UI/UX Design | ₹10,000 |
| **Total Development** | **₹65,000** |

## 6.2 Infrastructure Cost

| Item | Cost |
|------|------|
| AWS (Free Tier) | ₹0 |
| Domain | ₹800 |
| **Total Infrastructure** | **₹800** |

## 6.3 Third-Party Services

| Item | Cost |
|------|------|
| Firebase | ₹0 (Free Tier) |
| Razorpay | 2% per transaction |
| Twilio (OTP) | ₹500 |
| **Total Services** | **₹500** |

## 6.4 App Store Fees

| Item | Cost |
|------|------|
| Google Play Store | ₹18,000 (one-time) |
| Apple Developer | ₹7,500/year |
| **Total Stores** | **₹25,500** |

## 6.5 Total Investment

| Category | Amount |
|----------|--------|
| Development | ₹65,000 |
| Infrastructure | ₹800 |
| Services | ₹500 |
| App Stores | ₹25,500 |
| **GRAND TOTAL** | **₹91,800** |

---

# 7. TEAM REQUIREMENTS

## 7.1 Team Structure

| Role | Count | Skills |
|------|-------|--------|
| Flutter Developer | 2 | Flutter, Dart, BLoC |
| Backend Developer | 1 | Node.js/Firebase, PostgreSQL |
| UI/UX Designer | 1 | Figma, Design systems |
| QA Tester | 1 | Manual/Automation testing |

## 7.2 User's Role

| Responsibility | Details |
|----------------|---------|
| **App Development** | Flutter app development |
| **Planning** | Project planning & coordination |
| **UI/UX Team** | Handles design |

---

# 8. APP STORE PUBLISHING

## 8.1 Google Play Store

| Step | Time |
|------|------|
| Create Account | 1-2 days |
| App Listing | 1 day |
| Review | 1-7 days |
| **Total** | **3-10 days** |

**Cost**: ₹18,000 (one-time)

## 8.2 Apple App Store

| Step | Time |
|------|------|
| Create Account | 1-2 days |
| Get D-U-N-S Number | 7-14 days |
| App Listing | 1 day |
| Review | 1-2 days |
| **Total** | **10-20 days** |

**Cost**: ₹7,500/year

## 8.3 Recommendation

| Option | Cost | Time | Recommendation |
|--------|------|------|----------------|
| Android Only | ₹18,000 | 3-10 days | ✅ **Start here** |
| Both Stores | ₹25,500 | 10-20 days | Add later |

---

# 9. DOCUMENTATION PROVIDED

## 9.1 Word Documents (10 files)

| Document | Purpose |
|----------|---------|
| `VELTRIX_SPORTS_COMPLETE.docx` | Full documentation with diagrams |
| `VELTRIX_SPORTS_REQUIREMENTS.docx` | Requirements & cost |
| `VELTRIX_SPORTS_SPRINT_PLAN.docx` | 2-week sprint plan |
| `VELTRIX_SPORTS_PRICING_PLAN.docx` | Pricing details |
| `VELTRIX_SPORTS_PRODUCT_COSTS.docx` | Production costs |
| `VELTRIX_SPORTS_2_WEEK_PLAN.docx` | 2-week MVP plan |
| `VELTRIX_SPORTS_APP_STORE_GUIDE.docx` | Publishing guide |
| `VELTRIX_SPORTS_APP_STORE_DECISION.docx` | Decision guide |
| `VELTRIX_SPORTS_UI_SPECIFICATION.docx` | UI/UX screens |
| `VELTRIX_SPORTS_SHOWCASE.docx` | **This document** |

## 9.2 Diagrams (12 files)

| Diagram | Description |
|---------|-------------|
| System Architecture | Overall system design |
| Database ER | Database relationships |
| Authentication Flow | Login/signup flow |
| Training Plan Flow | Training workflow |
| Event Registration Flow | Event workflow |
| Payment Flow | Payment workflow |
| Device Sync Flow | Device integration |
| Feature Modules | Module breakdown |
| API Endpoints | API structure |
| Screen Navigation | Navigation flow |
| Data Flow | Data movement |
| Deployment Architecture | Deployment design |

---

# 10. NEXT STEPS

## 10.1 Immediate Actions

| # | Action | Owner |
|---|--------|-------|
| 1 | Review this document | Stakeholder |
| 2 | Approve budget | Stakeholder |
| 3 | Finalize team | Stakeholder |
| 4 | Create GitHub repo | Developer |
| 5 | Start Day 1 | Team |

## 10.2 Week 1 Focus

| Day | Focus |
|-----|-------|
| 1-2 | Backend setup |
| 3-4 | Auth screens |
| 5-7 | Core features |

## 10.3 Week 2 Focus

| Day | Focus |
|-----|-------|
| 8-9 | Payments & testing |
| 10 | Deployment |

---

# 11. RISKS & MITIGATION

| Risk | Impact | Mitigation |
|------|--------|------------|
| Scope creep | High | Stick to MVP features |
| Technical debt | Medium | Code reviews |
| Timeline delays | High | Daily standups |
| Budget overrun | Medium | Track expenses |

---

# 12. SUCCESS METRICS

| Metric | Target |
|--------|--------|
| App crashes | < 1% |
| Load time | < 3 seconds |
| User registration | 100+ in first week |
| Event bookings | 50+ in first week |
| App store rating | 4+ stars |

---

# 13. CONCLUSION

| Item | Status |
|------|--------|
| Documentation | ✅ Complete |
| UI/UX Specification | ✅ Complete |
| Cost Estimation | ✅ Complete |
| Timeline | ✅ 2 weeks |
| Team | ⏳ To be finalized |
| Development | ⏳ Ready to start |

---

**Document Version**: 1.0
**Date**: August 29, 2026
**Prepared by**: Veltrix Sports Team
