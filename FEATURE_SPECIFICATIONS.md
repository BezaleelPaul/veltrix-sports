# VELTRIX SPORTS - FEATURE SPECIFICATIONS
## Complete Feature Documentation

---

# FEATURE OVERVIEW

```
Total Features: 45+
Modules: 6 (Auth, Training, Events, Tickets, Profile, Settings)
Priority Levels: P0 (Must Have), P1 (Should Have), P2 (Could Have)
```

---

# 1. AUTHENTICATION MODULE

## 1.1 User Registration

| Field | Details |
|-------|---------|
| **Feature ID** | AUTH-001 |
| **Priority** | P0 |
| **Screen** | Registration Screen |

### User Story
As a new user, I want to register with my email/phone so that I can access the app.

### Acceptance Criteria
- [ ] User can register with email + password
- [ ] User can register with phone + OTP
- [ ] User can register with Google/Apple sign-in
- [ ] Password must meet complexity requirements
- [ ] Email verification required
- [ ] Phone OTP verification required
- [ ] Terms & conditions acceptance required

### API Endpoint
```
POST /auth/register
```

### UI Components
- Name input field
- Email input field
- Phone input field with country code
- Password input with show/hide toggle
- Confirm password input
- Register button
- Social login buttons (Google, Apple)
- Terms & conditions checkbox
- Login link

---

## 1.2 User Login

| Field | Details |
|-------|---------|
| **Feature ID** | AUTH-002 |
| **Priority** | P0 |
| **Screen** | Login Screen |

### User Story
As a registered user, I want to login so that I can access my account.

### Acceptance Criteria
- [ ] User can login with email + password
- [ ] User can login with phone + OTP
- [ ] User can login with Google/Apple
- [ ] "Remember me" option available
- [ ] Forgot password link available
- [ ] Error messages for invalid credentials
- [ ] Account lockout after 5 failed attempts

### API Endpoint
```
POST /auth/login
```

### UI Components
- Email/Phone input field
- Password input field
- Login button
- Forgot password link
- Register link
- Social login buttons

---

## 1.3 OTP Verification

| Field | Details |
|-------|---------|
| **Feature ID** | AUTH-003 |
| **Priority** | P0 |
| **Screen** | OTP Verification Screen |

### User Story
As a user, I want to verify my phone number with OTP so that my account is secure.

### Acceptance Criteria
- [ ] 6-digit OTP input
- [ ] Auto-read OTP (Android)
- [ ] Resend OTP after 30 seconds
- [ ] OTP expires after 5 minutes
- [ ] Maximum 3 verification attempts
- [ ] Success/failure feedback

### API Endpoints
```
POST /auth/otp/send
POST /auth/otp/verify
```

### UI Components
- OTP input (6 boxes)
- Timer countdown
- Resend OTP button
- Verify button
- Change phone number link

---

## 1.4 Forgot Password

| Field | Details |
|-------|---------|
| **Feature ID** | AUTH-004 |
| **Priority** | P1 |
| **Screen** | Forgot Password Screen |

### User Story
As a user, I want to reset my password if I forget it.

### Acceptance Criteria
- [ ] User enters email/phone
- [ ] Reset link/OTP sent
- [ ] User enters new password
- [ ] Password updated successfully
- [ ] Session invalidated on other devices

### API Endpoints
```
POST /auth/forgot-password
POST /auth/reset-password
```

### UI Components
- Email/Phone input
- Send reset link button
- New password input
- Confirm password input
- Reset password button

---

# 2. TRAINING PLAN MODULE

## 2.1 View Training Plans

| Field | Details |
|-------|---------|
| **Feature ID** | TRAIN-001 |
| **Priority** | P0 |
| **Screen** | My Plans Screen |

### User Story
As an athlete, I want to view my training plans so that I can track my progress.

### Acceptance Criteria
- [ ] List of active plans displayed
- [ ] List of completed plans displayed
- [ ] Plan progress shown
- [ ] Current week/session highlighted
- [ ] Pull-to-refresh enabled
- [ ] Empty state for no plans

### API Endpoint
```
GET /plans
```

### UI Components
- Tab bar (Active/Completed)
- Plan cards with:
  - Plan title
  - Sport icon
  - Progress bar
  - Current week
  - Start/end dates
- FAB to create new plan
- Empty state illustration

---

## 2.2 Plan Detail View

| Field | Details |
|-------|---------|
| **Feature ID** | TRAIN-002 |
| **Priority** | P0 |
| **Screen** | Plan Detail Screen |

### User Story
As an athlete, I want to view plan details so that I can see my weekly schedule.

### Acceptance Criteria
- [ ] Weekly schedule displayed
- [ ] Sessions listed for each week
- [ ] Session types color-coded
- [ ] Progress statistics shown
- [ ] Edit plan option (if owner)
- [ ] Share plan option

### API Endpoint
```
GET /plans/{planId}
```

### UI Components
- Plan header with:
  - Title
  - Progress ring
  - Stats (distance, duration, sessions)
- Week selector (horizontal scroll)
- Session list for selected week
- Each session shows:
  - Type icon
  - Title
  - Duration/Distance
  - Target pace/HR
  - Status (completed/pending/skipped)
- Bottom action buttons

---

## 2.3 Create Training Plan

| Field | Details |
|-------|---------|
| **Feature ID** | TRAIN-003 |
| **Priority** | P0 |
| **Screen** | Create Plan Screen |

### User Story
As an athlete, I want to create a training plan so that I can follow a structured program.

### Acceptance Criteria
- [ ] Select sport type
- [ ] Select goal (5K, 10K, Marathon, etc.)
- [ ] Select start date
- [ ] Select training days per week
- [ ] AI-generated plan option
- [ ] Manual plan creation option
- [ ] Preview before saving

### API Endpoint
```
POST /plans/generate
```

### UI Components
- Sport selection cards
- Goal selection dropdown
- Date picker
- Week availability selector
- AI/Manual toggle
- Generate button
- Plan preview
- Save/Cancel buttons

---

## 2.4 Session Detail View

| Field | Details |
|-------|---------|
| **Feature ID** | TRAIN-004 |
| **Priority** | P0 |
| **Screen** | Session Detail Screen |

### User Story
As an athlete, I want to view session details so that I know what workout to do.

### Acceptance Criteria
- [ ] Session type displayed
- [ ] Warm-up instructions shown
- [ ] Main workout structure shown
- [ ] Cool-down instructions shown
- [ ] Target metrics displayed
- [ ] Start session button
- [ ] Skip session option

### API Endpoint
```
GET /sessions/{sessionId}
```

### UI Components
- Session header:
  - Type badge
  - Title
  - Duration/Distance
- Instructions section:
  - Warm-up card
  - Main workout card
  - Cool-down card
- Target metrics:
  - Pace
  - Heart rate zones
  - TSS
- Action buttons:
  - Start Session
  - Skip Session
  - Notes

---

## 2.5 Complete Session

| Field | Details |
|-------|---------|
| **Feature ID** | TRAIN-005 |
| **Priority** | P0 |
| **Screen** | Complete Session Screen |

### User Story
As an athlete, I want to log my completed session so that my progress is tracked.

### Acceptance Criteria
- [ ] Enter actual duration
- [ ] Enter actual distance
- [ ] Enter average pace
- [ ] Enter average heart rate
- [ ] Rate session (1-5)
- [ ] Add notes
- [ ] Add weather info
- [ ] Save session

### API Endpoint
```
POST /sessions/{sessionId}/complete
```

### UI Components
- Timer (if started from app)
- Input fields:
  - Duration picker
  - Distance input
  - Pace calculator
  - Heart rate input
- Session rating (1-5 stars)
- Notes text area
- Weather selector
- Save button

---

## 2.6 Progress Dashboard

| Field | Details |
|-------|---------|
| **Feature ID** | TRAIN-006 |
| **Priority** | P1 |
| **Screen** | Progress Screen |

### User Story
As an athlete, I want to view my progress so that I can see my improvement.

### Acceptance Criteria
- [ ] Weekly distance chart
- [ ] Monthly distance chart
- [ ] Total statistics displayed
- [ ] Personal bests highlighted
- [ ] Training load graph
- [ ] Fitness/fatigue/form indicators

### API Endpoint
```
GET /progress
```

### UI Components
- Period selector (Week/Month/Year)
- Charts:
  - Line chart (distance over time)
  - Bar chart (sessions per week)
  - Donut chart (training zones)
- Stats cards:
  - Total distance
  - Total duration
  - Total sessions
  - Avg pace
- Personal bests list
- Training load gauge

---

# 3. EVENTS MODULE

## 3.1 Event Listing

| Field | Details |
|-------|---------|
| **Feature ID** | EVENT-001 |
| **Priority** | P0 |
| **Screen** | Events Screen |

### User Story
As a user, I want to browse events so that I can find races to join.

### Acceptance Criteria
- [ ] List of upcoming events
- [ ] Filter by sport
- [ ] Filter by city
- [ ] Filter by date range
- [ ] Search events
- [ ] Featured events highlighted
- [ ] Pull-to-refresh

### API Endpoint
```
GET /events
```

### UI Components
- Search bar
- Filter chips:
  - Sport type
  - City
  - Date
- Event cards:
  - Banner image
  - Event title
  - Date & location
  - Categories & prices
  - Registration status
- Featured section (horizontal scroll)
- Empty state

---

## 3.2 Event Detail View

| Field | Details |
|-------|---------|
| **Feature ID** | EVENT-002 |
| **Priority** | P0 |
| **Screen** | Event Detail Screen |

### User Story
As a user, I want to view event details so that I can decide to register.

### Acceptance Criteria
- [ ] Event banner displayed
- [ ] Event description shown
- [ ] Date, time, venue displayed
- [ ] Categories & prices listed
- [ ] What's included shown
- [ ] Organizer info displayed
- [ ] Register button
- [ ] Share event option

### API Endpoint
```
GET /events/{eventId}
```

### UI Components
- Hero image
- Event title & badges
- Tab bar:
  - About (description, includes)
  - Categories (list with prices)
  - Route (map)
  - Reviews
- Sticky register button
- Share button
- Organizer card

---

## 3.3 Event Registration

| Field | Details |
|-------|---------|
| **Feature ID** | EVENT-003 |
| **Priority** | P0 |
| **Screen** | Registration Screen |

### User Story
As a user, I want to register for an event so that I can participate.

### Acceptance Criteria
- [ ] Select category
- [ ] Enter personal information
- [ ] Enter emergency contact
- [ ] Enter medical information
- [ ] Select t-shirt size
- [ ] Accept terms & conditions
- [ ] Proceed to payment

### API Endpoint
```
POST /events/{eventId}/register
```

### UI Components
- Category selection cards
- Form fields:
  - Full name
  - Email
  - Phone
  - Date of birth
  - Gender
- Emergency contact section
- Medical info section
- T-shirt size selector
- Terms checkbox
- Continue button

---

## 3.4 My Registrations

| Field | Details |
|-------|---------|
| **Feature ID** | EVENT-004 |
| **Priority** | P1 |
| **Screen** | My Registrations Screen |

### User Story
As a user, I want to view my event registrations so that I can manage them.

### Acceptance Criteria
- [ ] List of registered events
- [ ] Registration status shown
- [ ] Ticket/BIB number displayed
- [ ] Event date highlighted
- [ ] Cancel registration option
- [ ] View ticket option

### API Endpoint
```
GET /events/registrations
```

### UI Components
- Tab bar (Upcoming/Past)
- Registration cards:
  - Event banner
  - Event title
  - Date
  - Category
  - BIB number
  - Status badge
- Cancel button (if allowed)
- View ticket button

---

# 4. TICKETING MODULE

## 4.1 Marketplace Listing

| Field | Details |
|-------|---------|
| **Feature ID** | TICKET-001 |
| **Priority** | P1 |
| **Screen** | Marketplace Screen |

### User Story
As a user, I want to browse the marketplace so that I can find events to attend.

### Acceptance Criteria
- [ ] List of available tickets
- [ ] Filter by city/sport
- [ ] Sort by price/date
- [ ] Search functionality
- [ ] Ticket availability shown
- [ ] Price displayed

### API Endpoint
```
GET /marketplace/events
```

### UI Components
- Search bar
- Filter options
- Event cards:
  - Image
  - Event name
  - Date
  - Starting price
  - Availability
- Sort dropdown

---

## 4.2 Ticket Purchase

| Field | Details |
|-------|---------|
| **Feature ID** | TICKET-002 |
| **Priority** | P1 |
| **Screen** | Checkout Screen |

### User Story
As a user, I want to purchase tickets so that I can attend events.

### Acceptance Criteria
- [ ] Select quantity
- [ ] Apply promo code
- [ ] View order summary
- [ ] Select payment method
- [ ] Complete payment
- [ ] Receive confirmation

### API Endpoints
```
POST /tickets/purchase
POST /payments/create
POST /payments/verify
```

### UI Components
- Quantity selector
- Promo code input
- Order summary:
  - Event name
  - Category
  - Quantity
  - Subtotal
  - Discount
  - Total
- Payment method selection
- Pay button

---

## 4.3 My Tickets

| Field | Details |
|-------|---------|
| **Feature ID** | TICKET-003 |
| **Priority** | P1 |
| **Screen** | My Tickets Screen |

### User Story
As a user, I want to view my tickets so that I can use them at events.

### Acceptance Criteria
- [ ] List of purchased tickets
- [ ] Ticket details shown
- [ ] QR code displayed
- [ ] Ticket status shown
- [ ] Download ticket option

### API Endpoint
```
GET /tickets
```

### UI Components
- Ticket cards:
  - Event name
  - Date
  - Category
  - QR code
  - Status badge
- Download button
- Share button

---

## 4.4 QR Check-in

| Field | Details |
|-------|---------|
| **Feature ID** | TICKET-004 |
| **Priority** | P2 |
| **Screen** | Check-in Screen |

### User Story
As an organizer, I want to scan QR codes so that I can check in participants.

### Acceptance Criteria
- [ ] Camera access
- [ ] QR code scanning
- [ ] Ticket validation
- [ ] Success/failure feedback
- [ ] Check-in count displayed

### API Endpoint
```
POST /checkin/{ticketId}
```

### UI Components
- Camera viewfinder
- Scan button
- Manual entry option
- Validation result overlay
- Check-in counter

---

# 5. PROFILE MODULE

## 5.1 View Profile

| Field | Details |
|-------|---------|
| **Feature ID** | PROF-001 |
| **Priority** | P1 |
| **Screen** | Profile Screen |

### User Story
As a user, I want to view my profile so that I can see my information.

### Acceptance Criteria
- [ ] Profile picture displayed
- [ ] Name & email shown
- [ ] Stats displayed
- [ ] Edit profile option
- [ ] Settings option
- [ ] Logout option

### API Endpoint
```
GET /users/profile
```

### UI Components
- Profile header:
  - Avatar
  - Name
  - Email
  - Member since
- Stats cards:
  - Total distance
  - Total events
  - Total plans
- Menu items:
  - Edit profile
  - My devices
  - Notifications
  - Settings
  - Help
  - Logout

---

## 5.2 Edit Profile

| Field | Details |
|-------|---------|
| **Feature ID** | PROF-002 |
| **Priority** | P1 |
| **Screen** | Edit Profile Screen |

### User Story
As a user, I want to edit my profile so that my information is up to date.

### Acceptance Criteria
- [ ] Edit name
- [ ] Edit phone
- [ ] Edit date of birth
- [ ] Edit gender
- [ ] Edit height/weight
- [ ] Edit fitness level
- [ ] Edit goals
- [ ] Upload new avatar

### API Endpoint
```
PUT /users/profile
POST /users/avatar
```

### UI Components
- Avatar with edit overlay
- Form fields:
  - Name
  - Phone
  - Date of birth
  - Gender
  - Height
  - Weight
- Dropdowns:
  - Fitness level
  - Goals (multi-select)
- Save button

---

## 5.3 Connected Devices

| Field | Details |
|-------|---------|
| **Feature ID** | PROF-003 |
| **Priority** | P1 |
| **Screen** | Devices Screen |

### User Story
As a user, I want to manage my connected devices so that I can sync data.

### Acceptance Criteria
- [ ] List of connected devices
- [ ] Device status shown
- [ ] Last sync time displayed
- [ ] Sync data option
- [ ] Disconnect option
- [ ] Connect new device option

### API Endpoint
```
GET /devices
POST /devices/connect
DELETE /devices/{deviceId}
```

### UI Components
- Device cards:
  - Device name
  - Provider icon
  - Status badge
  - Last sync time
  - Synced activities count
- Actions:
  - Sync now button
  - Disconnect button
- Connect new device button

---

## 5.4 Connect Device

| Field | Details |
|-------|---------|
| **Feature ID** | PROF-004 |
| **Priority** | P1 |
| **Screen** | Connect Device Screen |

### User Story
As a user, I want to connect my fitness device so that I can sync my data.

### Acceptance Criteria
- [ ] List of supported devices
- [ ] OAuth flow for each provider
- [ ] Permission request
- [ ] Success/failure feedback
- [ ] Sync initial data

### API Endpoint
```
POST /devices/connect
```

### UI Components
- Device provider cards:
  - Garmin
  - Apple Health
  - Strava
  - Google Fit
- Connect button for each
- Permission screen
- Loading indicator
- Success/error message

---

# 6. SETTINGS MODULE

## 6.1 App Settings

| Field | Details |
|-------|---------|
| **Feature ID** | SET-001 |
| **Priority** | P2 |
| **Screen** | Settings Screen |

### User Story
As a user, I want to configure app settings so that the app works as I prefer.

### Acceptance Criteria
- [ ] Notification preferences
- [ ] Privacy settings
- [ ] Units preference (metric/imperial)
- [ ] Language selection
- [ ] Theme selection
- [ ] Data usage settings

### UI Components
- Settings sections:
  - Notifications
  - Privacy
  - Display
  - Data & Storage
  - About
- Toggle switches
- Selection lists
- Info dialogs

---

## 6.2 Notifications Settings

| Field | Details |
|-------|---------|
| **Feature ID** | SET-002 |
| **Priority** | P2 |
| **Screen** | Notification Settings Screen |

### User Story
As a user, I want to configure notifications so that I receive relevant alerts.

### Acceptance Criteria
- [ ] Toggle workout reminders
- [ ] Toggle event updates
- [ ] Toggle promotional emails
- [ ] Set reminder time
- [ ] Quiet hours setting

### UI Components
- Toggle switches for each type
- Time picker for reminders
- Quiet hours start/end

---

# 7. FEATURE SUMMARY

| Module | Features | P0 | P1 | P2 |
|--------|----------|----|----|----|
| Authentication | 4 | 3 | 1 | 0 |
| Training Plan | 6 | 4 | 2 | 0 |
| Events | 4 | 3 | 1 | 0 |
| Ticketing | 4 | 0 | 3 | 1 |
| Profile | 4 | 0 | 4 | 0 |
| Settings | 2 | 0 | 0 | 2 |
| **Total** | **24** | **10** | **11** | **3** |

---

**Document Version**: 1.0
**Last Updated**: August 29, 2026
