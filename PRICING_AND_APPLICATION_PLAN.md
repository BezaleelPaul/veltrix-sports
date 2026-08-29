# VELTRIX SPORTS
## Pricing & Application Plan

---

**Date**: August 29, 2026
**Status**: Ready for Review

---

# 1. PRICING BREAKDOWN

## 1.1 Development Cost

### Option A: MVP (2 Weeks) - RECOMMENDED

| Role | Count | Rate/Day | Days | Total |
|------|-------|----------|------|-------|
| Flutter Developer | 2 | ₹2,000 | 10 | ₹40,000 |
| Backend Developer | 1 | ₹2,500 | 10 | ₹25,000 |
| **Subtotal** | | | | **₹65,000** |

| Additional | Cost |
|------------|------|
| UI/UX Design | ₹0 (In-house) |
| AWS (Free Tier) | ₹0 |
| Razorpay | 2% per transaction |
| Firebase | ₹0 |
| **Total** | **₹65,000** |

### Option B: Full Product (1 Month)

| Role | Count | Rate/Day | Days | Total |
|------|-------|----------|------|-------|
| Flutter Developer | 2 | ₹2,000 | 22 | ₹88,000 |
| Backend Developer | 1 | ₹2,500 | 22 | ₹55,000 |
| QA Engineer | 1 | ₹1,500 | 15 | ₹22,500 |
| **Subtotal** | | | | **₹1,65,500** |

| Additional | Cost |
|------------|------|
| UI/UX Design | ₹0 (In-house) |
| AWS (1 month) | ₹5,000 |
| Razorpay | 2% per transaction |
| **Total** | **₹1,70,500** |

### Option C: Complete Product (3 Months)

| Role | Count | Rate/Day | Days | Total |
|------|-------|----------|------|-------|
| Flutter Developer | 3 | ₹2,000 | 66 | ₹3,96,000 |
| Backend Developer | 2 | ₹2,500 | 66 | ₹3,30,000 |
| QA Engineer | 1 | ₹1,500 | 44 | ₹66,000 |
| DevOps | 1 | ₹2,000 | 22 | ₹44,000 |
| **Subtotal** | | | | **₹8,36,000** |

| Additional | Cost |
|------------|------|
| UI/UX Design | ₹0 (In-house) |
| AWS (3 months) | ₹15,000 |
| Razorpay | 2% per transaction |
| **Total** | **₹8,51,000** |

---

## 1.2 Monthly Running Cost (After Development)

| Service | Cost/Month |
|---------|------------|
| AWS EC2 | ₹1,400 |
| AWS RDS | ₹2,800 |
| AWS S3 | ₹200 |
| AWS CloudFront | ₹800 |
| Domain | ₹100 |
| **Total** | **₹5,300/month** |

---

## 1.3 Third-Party Service Costs

| Service | Pricing |
|---------|---------|
| Razorpay | 2% per transaction |
| Firebase | Free (1K notifications/day) |
| Garmin API | Free |
| Strava API | Free |
| Apple Developer | ₹7,500/year |
| Google Play | ₹25,000 (one-time) |

---

# 2. UI/UX DELIVERABLES

## 2.1 What UI/UX Team Must Deliver

### Design System
- [ ] Color palette (Primary, Secondary, Accent)
- [ ] Typography (Font family, sizes, weights)
- [ ] Spacing system (Margins, padding)
- [ ] Border radius
- [ ] Shadows
- [ ] Icons style
- [ ] Button styles
- [ ] Input field styles
- [ ] Card styles

### Screens (Total: 15+)

#### Auth Screens
- [ ] Splash Screen
- [ ] Login Screen
- [ ] Register Screen
- [ ] OTP Verification Screen
- [ ] Forgot Password Screen

#### Main Screens
- [ ] Dashboard Screen
- [ ] Training Plans List Screen
- [ ] Plan Detail Screen
- [ ] Session Detail Screen
- [ ] Events List Screen
- [ ] Event Detail Screen
- [ ] Registration Form Screen
- [ ] My Registrations Screen
- [ ] Profile Screen
- [ ] Settings Screen

#### Additional Screens
- [ ] Payment Checkout Screen
- [ ] Payment Success Screen
- [ ] Payment Failure Screen
- [ ] Error States (404, 500)
- [ ] Empty States
- [ ] Loading States

### Components
- [ ] App Bar
- [ ] Bottom Navigation
- [ ] Side Drawer
- [ ] Cards (Event, Plan, Session)
- [ ] Buttons (Primary, Secondary, Text)
- [ ] Input Fields
- [ ] Dropdowns
- [ ] Checkboxes
- [ ] Radio Buttons
- [ ] Switches
- [ ] Badges
- [ ] Avatars
- [ ] Progress Indicators
- [ ] Modals/Bottom Sheets
- [ ] Toast/Snackbar

### Prototypes
- [ ] Login flow prototype
- [ ] Registration flow prototype
- [ ] Dashboard flow prototype
- [ ] Training plan flow prototype
- [ ] Event registration flow prototype
- [ ] Payment flow prototype

---

## 2.2 UI/UX Deliverable Format

| Deliverable | Format | Tool |
|-------------|--------|------|
| Design System | Figma | Figma |
| Screen Designs | Figma | Figma |
| Prototypes | Figma | Figma |
| Icons | SVG/PNG | Figma/Illustrator |
| Images | PNG/JPG | Figma/Photoshop |
| Export Assets | PNG | Figma |

---

## 2.3 Screen Specifications

### Splash Screen
- App logo (centered)
- App name
- Loading indicator
- Duration: 2-3 seconds

### Login Screen
- App logo (top)
- Email/Phone input
- Password input
- Login button
- Forgot password link
- Register link
- Social login (Google, Apple)

### Register Screen
- Name input
- Email input
- Phone input (with country code)
- Password input
- Confirm password input
- Terms checkbox
- Register button
- Login link

### Dashboard Screen
- Welcome message
- Stats cards (Total distance, Sessions, Events)
- Quick actions (Start workout, Browse events)
- Recent activity list
- Bottom navigation

### Training Plans Screen
- Tab bar (Active, Completed)
- Plan cards (Title, Progress, Duration)
- Create plan FAB
- Empty state

### Plan Detail Screen
- Plan header (Title, Progress ring)
- Week selector (Horizontal scroll)
- Session list
- Each session: Type, Duration, Status
- Start session button

### Events Screen
- Search bar
- Filter chips (Sport, City, Date)
- Event cards (Image, Title, Date, Price)
- Featured section
- Empty state

### Event Detail Screen
- Hero image
- Event title & info
- Tab bar (About, Categories, Route)
- Categories list with prices
- Register button
- Share button

### Registration Form Screen
- Category selection
- Personal info form
- Emergency contact
- Medical info
- T-shirt size
- Terms checkbox
- Continue to payment button

### Profile Screen
- Avatar
- Name & email
- Stats cards
- Menu items (Edit, Devices, Settings, Logout)

---

# 3. APPLICATION PLAN

## 3.1 Application Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    FLUTTER APP                           │
├─────────────────────────────────────────────────────────┤
│  Presentation Layer                                      │
│  ├── Screens (UI)                                        │
│  ├── Widgets (Reusable Components)                       │
│  └── BLoC (State Management)                             │
├─────────────────────────────────────────────────────────┤
│  Domain Layer                                            │
│  ├── Entities (Data Models)                              │
│  ├── Repositories (Abstract)                             │
│  └── Use Cases (Business Logic)                          │
├─────────────────────────────────────────────────────────┤
│  Data Layer                                              │
│  ├── Repositories (Implementation)                       │
│  ├── Data Sources (Remote/Local)                         │
│  └── Models (API Response)                               │
└─────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────┐
│                    BACKEND API                           │
├─────────────────────────────────────────────────────────┤
│  Routes                                                  │
│  ├── /auth/* (Authentication)                            │
│  ├── /user/* (User Profile)                              │
│  ├── /plans/* (Training Plans)                           │
│  ├── /events/* (Events)                                  │
│  └── /payments/* (Payments)                              │
├─────────────────────────────────────────────────────────┤
│  Controllers                                             │
│  ├── AuthController                                      │
│  ├── UserController                                      │
│  ├── PlanController                                      │
│  ├── EventController                                     │
│  └── PaymentController                                   │
├─────────────────────────────────────────────────────────┤
│  Services                                                │
│  ├── AuthService                                         │
│  ├── UserService                                         │
│  ├── PlanService                                         │
│  ├── EventService                                        │
│  ├── PaymentService                                      │
│  └── NotificationService                                 │
└─────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────┐
│                    DATABASE                              │
├─────────────────────────────────────────────────────────┤
│  Tables                                                   │
│  ├── users                                               │
│  ├── training_plans                                      │
│  ├── plan_sessions                                       │
│  ├── session_logs                                        │
│  ├── events                                              │
│  ├── event_categories                                    │
│  ├── event_registrations                                 │
│  ├── tickets                                             │
│  ├── devices                                             │
│  └── payments                                            │
└─────────────────────────────────────────────────────────┘
```

---

## 3.2 Feature List (From PDF)

### Module 1: Authentication
| Feature | Priority | Status |
|---------|----------|--------|
| User Registration (Email) | P0 | ☐ |
| User Registration (Phone) | P0 | ☐ |
| User Login | P0 | ☐ |
| OTP Verification | P0 | ☐ |
| Forgot Password | P1 | ☐ |
| Social Login (Google) | P1 | ☐ |
| Social Login (Apple) | P1 | ☐ |
| Remember Me | P2 | ☐ |

### Module 2: Training Plans
| Feature | Priority | Status |
|---------|----------|--------|
| View Training Plans | P0 | ☐ |
| Plan Detail View | P0 | ☐ |
| Session Detail View | P0 | ☐ |
| Complete Session | P0 | ☐ |
| Create Training Plan | P1 | ☐ |
| AI Plan Generation | P2 | ☐ |
| Progress Dashboard | P1 | ☐ |
| Training Calendar | P2 | ☐ |

### Module 3: Events
| Feature | Priority | Status |
|---------|----------|--------|
| Browse Events | P0 | ☐ |
| Event Detail View | P0 | ☐ |
| Filter Events | P0 | ☐ |
| Search Events | P1 | ☐ |
| Event Registration | P0 | ☐ |
| My Registrations | P1 | ☐ |
| Event Reviews | P2 | ☐ |
| Event Sharing | P2 | ☐ |

### Module 4: Ticketing
| Feature | Priority | Status |
|---------|----------|--------|
| Browse Marketplace | P1 | ☐ |
| Buy Tickets | P1 | ☐ |
| View My Tickets | P1 | ☐ |
| QR Code Display | P1 | ☐ |
| QR Check-in | P2 | ☐ |
| Promo Codes | P2 | ☐ |
| Refund Request | P2 | ☐ |

### Module 5: Payments
| Feature | Priority | Status |
|---------|----------|--------|
| Razorpay Integration | P0 | ☐ |
| UPI Payment | P0 | ☐ |
| Card Payment | P0 | ☐ |
| Net Banking | P1 | ☐ |
| Payment History | P1 | ☐ |
| Refund Processing | P2 | ☐ |

### Module 6: Profile
| Feature | Priority | Status |
|---------|----------|--------|
| View Profile | P1 | ☐ |
| Edit Profile | P1 | ☐ |
| Upload Avatar | P1 | ☐ |
| Change Password | P1 | ☐ |
| Connected Devices | P2 | ☐ |
| Activity History | P2 | ☐ |

### Module 7: Device Sync
| Feature | Priority | Status |
|---------|----------|--------|
| Connect Garmin | P2 | ☐ |
| Connect Apple Health | P2 | ☐ |
| Connect Strava | P2 | ☐ |
| Sync Activities | P2 | ☐ |
| View Synced Data | P2 | ☐ |

### Module 8: Notifications
| Feature | Priority | Status |
|---------|----------|--------|
| Push Notifications | P1 | ☐ |
| Email Notifications | P2 | ☐ |
| SMS Notifications | P2 | ☐ |
| Notification Preferences | P2 | ☐ |

---

## 3.3 MVP Scope (2 Weeks)

### Must Build (P0)
1. ✅ User Registration
2. ✅ User Login
3. ✅ OTP Verification
4. ✅ Dashboard
5. ✅ Training Plans List
6. ✅ Plan Detail
7. ✅ Events List
8. ✅ Event Detail
9. ✅ Event Registration
10. ✅ Basic Payment

### Skip for MVP
- ❌ AI Plan Generation
- ❌ Device Sync
- ❌ Ticketing Marketplace
- ❌ Admin Panel
- ❌ Analytics

---

# 4. DEVELOPMENT TIMELINE

## Week 1: Foundation

| Day | Backend | Frontend |
|-----|---------|----------|
| Day 1 | Setup Node.js, PostgreSQL, Auth APIs | Flutter project setup |
| Day 2 | OTP, JWT, User APIs | API client, Auth BLoC |
| Day 3 | Plan APIs | Auth screens |
| Day 4 | Event APIs | Dashboard screen |
| Day 5 | Payment APIs | Training plans screens |

## Week 2: Features

| Day | Backend | Frontend |
|-----|---------|----------|
| Day 6 | Testing, Bug fixes | Events screens |
| Day 7 | Documentation | Registration form |
| Day 8 | Deployment setup | Payment integration |
| Day 9 | AWS setup | Testing, Bug fixes |
| Day 10 | Final testing | Build, Deploy |

---

# 5. TEAM RESPONSIBILITIES

## UI/UX Team
- Design system
- All screen designs
- Prototypes
- Asset export
- Design handoff

## Backend Team
- API development
- Database setup
- Authentication
- Payment integration
- Deployment

## Frontend Team
- Flutter app development
- Screen implementation
- State management
- API integration
- Testing

---

# 6. SUCCESS CRITERIA

## MVP Must Have
- [ ] User can register with email/phone
- [ ] User can login
- [ ] User can see dashboard
- [ ] User can browse training plans
- [ ] User can view plan details
- [ ] User can browse events
- [ ] User can view event details
- [ ] User can register for events
- [ ] User can make payment
- [ ] App works on Android & iOS

---

# 7. RISKS & MITIGATION

| Risk | Impact | Mitigation |
|------|--------|------------|
| UI/UX delays | High | Use pre-built components |
| API delays | High | Mock data fallback |
| Payment issues | High | Test Razorpay early |
| Time crunch | High | Cut P2 features |

---

**Document Version**: 1.0
**Date**: August 29, 2026
**Status**: Ready for Review
