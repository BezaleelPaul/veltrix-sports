# VELTRIX SPORTS
## Complete Development Roadmap & Technical Documentation

---

# TABLE OF CONTENTS

1. [Executive Summary](#executive-summary)
2. [Project Overview](#project-overview)
3. [Stage 1: Requirement Analysis](#stage-1-requirement-analysis)
4. [Stage 2: UI/UX Analysis](#stage-2-uiux-analysis)
5. [Stage 3: API Analysis](#stage-3-api-analysis)
6. [Stage 4: Flutter Architecture](#stage-4-flutter-architecture)
7. [Stage 5: Project Setup](#stage-5-project-setup)
8. [Stage 6: Core Infrastructure](#stage-6-core-infrastructure)
9. [Stage 7: Feature Development](#stage-7-feature-development)
10. [Cost Estimation](#cost-estimation)
11. [Timeline & Milestones](#timeline-milestones)
12. [Team Structure](#team-structure)

---

# EXECUTIVE SUMMARY

**Project**: Veltrix Sports Platform
**Type**: Coaching, Events & Ticketing Platform
**Platforms**: Android, iOS, Web
**Timeline**: 2-12 weeks (MVP to Full Product)
**Budget**: ₹11,100 - ₹56,00,000 (depending on scope)

---

# PROJECT OVERVIEW

## Three Verticals

| Vertical | Model | Primary Users |
|----------|-------|---------------|
| **Training Plan** | B2B & B2C coaching | Coaches, Athletes |
| **Events** | Event management | Organizers, Participants |
| **Ticketing** | Self-serve marketplace | Third-party organizers, Attendees |

## Core Features

### Training Plan
- Running, Triathlon, Biking plans
- AI plan generation
- Device integration (Garmin, Apple Watch)
- Weather & terrain integration
- Progress tracking

### Events
- Event listing & registration
- Ticket purchase
- Live tracking
- Results & e-certificates

### Ticketing Marketplace
- Self-serve organizer dashboard
- Public event marketplace
- QR code check-in
- Commission & payout system

---

# STAGE 1: REQUIREMENT ANALYSIS

## Functional Requirements

### Authentication
- Email/password registration
- Phone OTP verification
- Social login (Google, Apple)
- Password reset

### Training Plans
- View training plans
- Session details
- Complete/skip sessions
- Progress tracking
- AI plan generation

### Events
- Browse events
- Event details
- Registration
- Ticket purchase
- My events

### Profile
- View/edit profile
- Connected devices
- Settings
- Notifications

## Non-Functional Requirements

| Requirement | Priority |
|-------------|----------|
| Performance | High |
| Security | High |
| Accessibility | Medium |
| Responsive Design | High |
| Offline Support | Medium |
| Multi-language | Low |

---

# STAGE 2: UI/UX ANALYSIS

## Design System

### Color Palette

| Color | Hex | Usage |
|-------|-----|-------|
| Primary | #FF6B35 | Orange - CTAs |
| Secondary | #004E89 | Navy Blue - Headers |
| Accent | #00A896 | Teal - Success |
| Background | #FFFFFF | White |
| Surface | #F8F9FA | Light Gray |

### Typography

| Style | Font | Size | Weight |
|-------|------|------|--------|
| H1 | Poppins | 32px | Bold |
| H2 | Poppins | 24px | SemiBold |
| H3 | Poppins | 20px | SemiBold |
| Body | Poppins | 14px | Regular |

### Spacing

| Token | Value |
|-------|-------|
| xs | 4px |
| sm | 8px |
| md | 16px |
| lg | 24px |
| xl | 32px |

## Screen Inventory

### Authentication (6 screens)
- Splash Screen
- Onboarding (3 screens)
- Login
- Register
- OTP Verification
- Forgot Password

### Training Plan (8 screens)
- Athlete Dashboard
- Coach Dashboard
- Plan List
- Plan Detail
- Session Detail
- Session Complete
- Progress Overview
- Intake Assessment

### Events (7 screens)
- Event List
- Event Detail
- Event Registration
- My Events
- Event Dashboard
- Route Map
- Results

### Ticketing (5 screens)
- Marketplace
- Event Listing
- Ticket Selection
- Checkout
- QR Code

### Profile (5 screens)
- Profile
- Edit Profile
- Settings
- Connected Devices
- Notifications

**Total: 31 screens**

---

# STAGE 3: API ANALYSIS

## API Architecture

```
Base URL: https://api.veltrixsports.com/v1
Protocol: HTTPS
Format: JSON
Auth: Bearer Token (JWT)
```

## API Endpoints Summary

| Module | Endpoints | Count |
|--------|-----------|-------|
| Authentication | Register, Login, OTP, Refresh, Logout | 7 |
| User Profile | Get, Update, Avatar | 3 |
| Training Plans | CRUD, Generate, Sessions | 9 |
| Progress | Overview, Log, Analytics | 3 |
| Events | CRUD, Register, Registrations | 5 |
| Ticketing | Marketplace, Purchase, Ticket, Check-in, Review | 5 |
| Devices | Connect, List, Sync, Disconnect | 4 |
| Weather/Terrain | Get Weather, Get Terrain | 2 |
| Payments | Create, Verify, History | 3 |
| Notifications | Get, Mark Read, Update FCM | 3 |
| Admin | Users, Analytics | 2 |

**Total: 46 APIs**

---

# STAGE 4: FLUTTER ARCHITECTURE

## Architecture Pattern

**Clean Architecture + Feature-Based**

```
Presentation Layer → Domain Layer → Data Layer
```

## State Management

**BLoC (Business Logic Component)**

- Predictable state management
- Easy to test
- Separation of concerns
- Reactive programming

## Project Structure

```
lib/
├── main.dart
├── app.dart
├── core/
│   ├── config/
│   ├── constants/
│   ├── di/
│   ├── errors/
│   ├── network/
│   ├── routing/
│   ├── storage/
│   ├── theme/
│   ├── utils/
│   └── widgets/
├── features/
│   ├── auth/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── training/
│   ├── events/
│   ├── ticketing/
│   ├── profile/
│   ├── payments/
│   ├── devices/
│   └── notifications/
└── l10n/
```

## Key Technologies

| Technology | Purpose |
|------------|---------|
| Flutter | UI Framework |
| Dart | Programming Language |
| BLoC | State Management |
| GoRouter | Navigation |
| Dio | HTTP Client |
| GetIt | Dependency Injection |
| Firebase | Backend Services |
| Razorpay | Payments |

---

# STAGE 5: PROJECT SETUP

## Prerequisites

| Requirement | Version |
|-------------|---------|
| Flutter | 3.41.9+ |
| Dart | 3.11.5+ |
| Android SDK | 36.0.0+ |
| Java | 17+ |
| VS Code | Latest |

## Installation Commands

```bash
# Create project
flutter create veltrix_sports

# Navigate to project
cd veltrix_sports

# Get dependencies
flutter pub get

# Run app
flutter run
```

## Required Packages

### UI & Design
- flutter_svg
- lottie
- shimmer
- flutter_screenutil
- google_fonts

### State Management
- flutter_riverpod

### Navigation
- go_router

### Networking
- dio
- json_annotation

### Storage
- flutter_secure_storage
- shared_preferences

### Firebase
- firebase_core
- firebase_messaging

### Payments
- razorpay_flutter

---

# STAGE 6: CORE INFRASTRUCTURE

## Network Layer

### API Client
- Dio HTTP client
- Auth interceptor
- Error handling
- Request/response logging

### Storage Layer
- Secure storage (tokens)
- SharedPreferences (settings)
- Cache manager

### Routing
- GoRouter configuration
- Route guards
- Deep linking

## Theme

### Colors
- Primary/Secondary/Accent
- Background/Surface
- Error/Success/Warning
- Text colors

### Typography
- Font family: Poppins
- Font sizes
- Font weights

### Spacing
- Consistent spacing tokens
- Responsive sizing

---

# STAGE 7: FEATURE DEVELOPMENT

## Development Order

### Phase 1: Foundation (Week 1-2)
- [ ] Project setup
- [ ] Core infrastructure
- [ ] Authentication
- [ ] Splash/Onboarding
- [ ] Basic dashboard

### Phase 2: Training (Week 3-4)
- [ ] Plan list
- [ ] Plan detail
- [ ] Session management
- [ ] Progress tracking

### Phase 3: Events (Week 5-6)
- [ ] Event list
- [ ] Event detail
- [ ] Registration
- [ ] My events

### Phase 4: Payments (Week 7)
- [ ] Checkout flow
- [ ] Razorpay integration
- [ ] Payment history

### Phase 5: Advanced (Week 8-10)
- [ ] Device integration
- [ ] AI plan generation
- [ ] Live tracking
- [ ] Notifications

### Phase 6: Polish (Week 11-12)
- [ ] Testing
- [ ] Performance optimization
- [ ] Bug fixes
- [ ] Deployment

---

# COST ESTIMATION

## Development Cost (Excluding Salary)

| Category | 2-Month Cost |
|----------|--------------|
| Development Tools | ₹2,900 |
| AWS Services | ₹8,200 |
| **Total** | **₹11,100** |

## Development Cost (With Salary)

### Minimum Team (5 people)

| Role | 2-Week Cost |
|------|-------------|
| Flutter Developer (2) | ₹20,000-40,000 |
| Backend Developer (1) | ₹10,000-20,000 |
| UI/UX Designer (1) | ₹7,500-15,000 |
| QA Engineer (1) | ₹6,250-12,500 |
| **Total** | **₹43,750-87,500** |

### Full Team (9 people)

| Role | 2-Week Cost |
|------|-------------|
| Flutter Developer (3) | ₹30,000-60,000 |
| Backend Developer (2) | ₹20,000-40,000 |
| UI/UX Designer (1) | ₹7,500-15,000 |
| QA Engineer (2) | ₹12,500-25,000 |
| DevOps (1) | ₹12,500-25,000 |
| **Total** | **₹82,500-1,65,000** |

## Total Project Cost

| Duration | Minimum | Full Team | Enterprise |
|----------|---------|-----------|------------|
| 2 weeks | ₹55K-1L | ₹1L-1.8L | ₹1.4L-2.5L |
| 3 months | ₹2.8L-5.5L | ₹5.2L-10.1L | ₹7.2L-14L |
| 6 months | ₹5.7L-10.9L | ₹10.3L-20.2L | ₹14.4L-28L |
| 12 months | ₹11.3L-21.8L | ₹20.6L-40.4L | ₹28.9L-56.3L |

---

# TIMELINE & MILESTONES

## MVP (2-Week Sprint)

| Day | Milestone |
|-----|-----------|
| Day 1-2 | Project setup, API contract, DB schema |
| Day 3-5 | Auth, Dashboard, Plans (basic) |
| Day 6-8 | Events, Registration, Tickets |
| Day 9-10 | Integration, Testing, Deploy |

## Full Product (3-6 Months)

| Month | Milestone |
|-------|-----------|
| Month 1 | Foundation, Auth, Dashboard |
| Month 2 | Training Plans, Sessions |
| Month 3 | Events, Registration |
| Month 4 | Payments, Ticketing |
| Month 5 | Device Integration, AI |
| Month 6 | Testing, Launch |

---

# TEAM STRUCTURE

## Minimum Team (MVP)

| Role | Count | Responsibility |
|------|-------|----------------|
| Flutter Developer | 2 | App development |
| Backend Developer | 1 | APIs, database |
| UI/UX Designer | 1 | Designs |
| QA Engineer | 1 | Testing |
| **Total** | **5** | |

## Full Team (Production)

| Role | Count | Responsibility |
|------|-------|----------------|
| Flutter Developer | 3 | App development |
| Backend Developer | 2 | APIs, database |
| UI/UX Designer | 1 | Designs |
| QA Engineer | 2 | Testing |
| DevOps | 1 | Deployment |
| Project Manager | 1 | Coordination |
| **Total** | **10** | |

---

# APPENDIX

## A. API Endpoints

### Authentication
- POST /auth/register
- POST /auth/login
- POST /auth/otp/send
- POST /auth/otp/verify
- POST /auth/refresh
- POST /auth/forgot-password
- POST /auth/logout

### Training
- GET /plans
- GET /plans/{id}
- POST /plans/generate
- PUT /plans/{id}
- DELETE /plans/{id}
- GET /plans/{id}/sessions
- POST /sessions/{id}/complete
- GET /progress
- GET /progress/analytics

### Events
- GET /events
- GET /events/{id}
- POST /events
- POST /events/{id}/register
- GET /events/registrations

### Ticketing
- GET /marketplace/events
- POST /tickets/purchase
- GET /tickets/{id}
- POST /checkin/{id}
- POST /reviews

## B. Screen Specifications

See Stage 2: UI/UX Analysis for detailed screen specifications.

## C. Database Schema

```sql
-- Users
CREATE TABLE users (
  id UUID PRIMARY KEY,
  email TEXT UNIQUE,
  name TEXT,
  phone TEXT,
  role TEXT,
  created_at TIMESTAMPTZ
);

-- Training Plans
CREATE TABLE training_plans (
  id UUID PRIMARY KEY,
  user_id UUID REFERENCES users(id),
  title TEXT,
  sport TEXT,
  start_date DATE,
  end_date DATE,
  status TEXT
);

-- Sessions
CREATE TABLE sessions (
  id UUID PRIMARY KEY,
  plan_id UUID REFERENCES training_plans(id),
  title TEXT,
  scheduled_date DATE,
  duration_minutes INT,
  status TEXT
);

-- Events
CREATE TABLE events (
  id UUID PRIMARY KEY,
  title TEXT,
  sport TEXT,
  event_date TIMESTAMPTZ,
  location TEXT,
  max_participants INT
);

-- Registrations
CREATE TABLE registrations (
  id UUID PRIMARY KEY,
  event_id UUID REFERENCES events(id),
  user_id UUID REFERENCES users(id),
  status TEXT,
  registered_at TIMESTAMPTZ
);
```

---

**Document Version**: 1.0
**Last Updated**: August 29, 2026
**Author**: Veltrix Sports Development Team
