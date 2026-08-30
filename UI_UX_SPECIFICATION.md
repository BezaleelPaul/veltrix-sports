# VELTRIX SPORTS
## UI/UX Specification - Mobile App Screens & Features

---

# 1. APP NAVIGATION STRUCTURE

## 1.1 Bottom Navigation Bar

| Icon | Label | Screen |
|------|-------|--------|
| 🏠 | Home | Home Screen |
| 📚 | Training | Training Plans |
| 🎫 | Events | Events List |
| 👤 | Profile | User Profile |

## 1.2 Additional Navigation

| Location | Access |
|----------|--------|
| Drawer Menu | Settings, Help, About |
| Top Bar | Search, Notifications, Cart |
| FAB Button | Quick Actions |

---

# 2. ONBOARDING SCREENS

## 2.1 Splash Screen

| Element | Details |
|---------|---------|
| Logo | Veltrix Sports logo centered |
| Tagline | "Train. Compete. Win." |
| Duration | 2-3 seconds |
| Animation | Fade in logo |

## 2.2 Welcome Screen 1

| Element | Details |
|---------|---------|
| Image | Athlete training illustration |
| Title | "Find Expert Coaches" |
| Description | "Connect with certified coaches for personalized training plans" |
| Button | "Next" |
| Dots | Page indicator (1/3) |

## 2.3 Welcome Screen 2

| Element | Details |
|---------|---------|
| Image | Sports event illustration |
| Title | "Discover Events" |
| Description | "Find and register for sports events near you" |
| Button | "Next" |
| Dots | Page indicator (2/3) |

## 2.4 Welcome Screen 3

| Element | Details |
|---------|---------|
| Image | Ticket booking illustration |
| Title | "Book Tickets" |
| Description | "Get tickets for tournaments, matches, and workshops" |
| Button | "Get Started" |
| Dots | Page indicator (3/3) |

---

# 3. AUTHENTICATION SCREENS

## 3.1 Login Screen

| Element | Type | Details |
|---------|------|---------|
| Email | Input | Email address |
| Password | Input | Password with show/hide |
| Remember Me | Checkbox | Save credentials |
| Login | Button | Primary action |
| Forgot Password | Link | Reset password |
| OR | Divider | Social login |
| Google | Button | Sign in with Google |
| Apple | Button | Sign in with Apple |
| Create Account | Link | Navigate to signup |

## 3.2 Sign Up Screen

| Element | Type | Details |
|---------|------|---------|
| Full Name | Input | User's name |
| Email | Input | Email address |
| Phone | Input | Phone number |
| Password | Input | Create password |
| Confirm Password | Input | Re-enter password |
| I'm a: | Selection | Coach / Athlete / Both |
| Create Account | Button | Primary action |
| Terms | Link | Terms & Conditions |
| Already have account | Link | Navigate to login |

## 3.3 Forgot Password Screen

| Element | Type | Details |
|---------|------|---------|
| Email | Input | Registered email |
| Send Reset Link | Button | Primary action |
| Back to Login | Link | Navigate to login |

## 3.4 OTP Verification Screen

| Element | Type | Details |
|---------|------|---------|
| OTP Input | Input | 6-digit code |
| Resend OTP | Link | Resend after 30s |
| Verify | Button | Primary action |
| Timer | Text | Countdown |

---

# 4. HOME SCREEN

## 4.1 Header Section

| Element | Icon/Action | Function |
|---------|-------------|----------|
| Profile Picture | Avatar | Open profile menu |
| Greeting | Text | "Good Morning, [Name]" |
| Search | 🔍 | Search feature |
| Notifications | 🔔 | View notifications |
| Cart | 🛒 | View cart/bookings |

## 4.2 Quick Actions Section

| Card | Icon | Action |
|------|------|--------|
| Training Plans | 📚 | View training plans |
| Events | 🎫 | View upcoming events |
| Tickets | 🎟️ | View ticket bookings |
| Progress | 📊 | View progress dashboard |

## 4.3 Featured Section

| Element | Details |
|---------|---------|
| Featured Events | Horizontal scroll cards |
| Popular Coaches | Horizontal scroll cards |
| Trending Plans | Horizontal scroll cards |
| See All | Link to view all |

## 4.4 Upcoming Events

| Element | Details |
|---------|---------|
| Event Card | Image, name, date, location, price |
| Book Now | Button |
| View Details | Button |
| See All | Link to events list |

## 4.5 Recommended Training

| Element | Details |
|---------|---------|
| Plan Card | Image, name, coach, rating, price |
| Start Plan | Button |
| View Details | Button |
| See All | Link to training plans |

---

# 5. TRAINING PLANS SCREENS

## 5.1 Training Plans List

| Element | Function |
|---------|----------|
| Search Bar | Search training plans |
| Filter | Filter by sport, level, price |
| Sort | Sort by rating, price, popular |
| Plan Card | Image, name, coach, rating, price |
| View Details | Button |

## 5.2 Training Plan Details

| Element | Details |
|---------|---------|
| Hero Image | Plan banner image |
| Plan Name | Title |
| Coach Info | Avatar, name, rating |
| Duration | Number of weeks |
| Level | Beginner/Intermediate/Advanced |
| Price | Amount |
| Description | Plan overview |
| Schedule | Weekly breakdown |
| Reviews | User reviews |
| Start Plan | Button |
| Add to Cart | Button |

## 5.3 Training Session Screen

| Element | Details |
|---------|---------|
| Session Title | Current session name |
| Video Player | Training video |
| Timer | Workout timer |
| Exercises | List of exercises |
| Reps/Sets | Exercise details |
| Complete | Button |
| Skip | Button |
| Next | Button |

## 5.4 Progress Dashboard

| Element | Details |
|---------|---------|
| Total Sessions | Number completed |
| Streak | Days in a row |
| Hours Trained | Total time |
| Charts | Weekly progress graph |
| History | Past sessions |

---

# 6. EVENTS SCREENS

## 6.1 Events List

| Element | Function |
|---------|----------|
| Search Bar | Search events |
| Filter | Filter by sport, location, date |
| Sort | Sort by date, price, popular |
| Event Card | Image, name, date, location, price |
| View Details | Button |
| Map View | Toggle map view |

## 6.2 Event Details

| Element | Details |
|---------|---------|
| Hero Image | Event banner image |
| Event Name | Title |
| Date & Time | When event happens |
| Location | Venue with map |
| Organizer | Event organizer info |
| Description | Event details |
| Rules | Event rules |
| Prize Pool | Prize information |
| Participants | Registered count |
| Register | Button |
| Add to Calendar | Button |
| Share | Button |

## 6.3 Event Registration

| Element | Details |
|---------|---------|
| Event Summary | Name, date, location |
| Registration Fee | Amount breakdown |
| Participant Details | Name, age, gender, phone |
| Emergency Contact | Name, phone |
| Medical Info | Any health conditions |
| Terms | Accept terms checkbox |
| Pay Now | Button |
| Pay Later | Button |

## 6.4 Event Check-in

| Element | Details |
|---------|---------|
| QR Code | Unique check-in code |
| Event Info | Name, date |
| Check-in Status | Verified/Pending |
| Share QR | Button |

---

# 7. TICKET BOOKING SCREENS

## 7.1 Tickets List

| Element | Function |
|---------|----------|
| Search Bar | Search tickets |
| Filter | Filter by event type, date, price |
| Sort | Sort by date, price |
| Ticket Card | Event name, date, venue, price |
| Buy Now | Button |

## 7.2 Ticket Details

| Element | Details |
|---------|---------|
| Event Image | Event banner |
| Event Name | Title |
| Date & Time | When event happens |
| Venue | Location with map |
| Seat Selection | Interactive seat map |
| Ticket Type | VIP/General/Student |
| Price | Per ticket price |
| Quantity | +/- selector |
| Total | Total amount |
| Buy Tickets | Button |

## 7.3 Seat Selection

| Element | Details |
|---------|---------|
| Seat Map | Interactive venue map |
| Legend | Available/Selected/Sold |
| Selected Seats | List of selected |
| Price Summary | Total calculation |
| Proceed | Button |

## 7.4 Booking Confirmation

| Element | Details |
|---------|---------|
| Booking ID | Unique identifier |
| Event Details | Name, date, venue |
| Seat Details | Section, row, seat |
| QR Code | Ticket QR code |
| Download | Button |
| Add to Wallet | Button |
| Share | Button |

---

# 8. CART & PAYMENT SCREENS

## 8.1 Cart Screen

| Element | Details |
|---------|---------|
| Cart Items | List of items |
| Remove | Button per item |
| Quantity | +/- per item |
| Subtotal | Item total |
| Discount | Promo code input |
| Apply | Button |
| Total | Final amount |
| Checkout | Button |

## 8.2 Checkout Screen

| Element | Details |
|---------|---------|
| Order Summary | Items list |
| Delivery Info | Email for tickets |
| Payment Methods | Select payment |
| Razorpay | Button |
| UPI | Button |
| Card | Button |
| Net Banking | Button |
| Pay Now | Button |

## 8.3 Payment Success

| Element | Details |
|---------|---------|
| Success Icon | ✅ Green checkmark |
| Amount Paid | Total amount |
| Transaction ID | Unique ID |
| Booking ID | Unique ID |
| Email Sent | Confirmation email |
| View Tickets | Button |
| Back to Home | Button |

## 8.4 Payment Failed

| Element | Details |
|---------|---------|
| Error Icon | ❌ Red cross |
| Error Message | What went wrong |
| Retry | Button |
| Cancel | Button |
| Support | Link |

---

# 9. USER PROFILE SCREENS

## 9.1 Profile Screen

| Element | Details |
|---------|---------|
| Profile Picture | Avatar with edit |
| Name | User's name |
| Email | Email address |
| Phone | Phone number |
| Member Since | Join date |
| Edit Profile | Button |
| My Bookings | Link |
| My Tickets | Link |
| My Training | Link |
| Settings | Link |
| Help | Link |
| Logout | Button |

## 9.2 Edit Profile Screen

| Element | Details |
|---------|---------|
| Profile Picture | Change avatar |
| Full Name | Edit name |
| Email | Edit email |
| Phone | Edit phone |
| Date of Birth | Date picker |
| Gender | Male/Female/Other |
| Bio | Text area |
| Sport | Select sports |
| Save | Button |

## 9.3 My Bookings

| Element | Details |
|---------|---------|
| Tabs | Upcoming / Past |
| Booking Card | Event name, date, status |
| View Details | Button |
| Cancel | Button |
| Download | Button |

## 9.4 My Tickets

| Element | Details |
|---------|---------|
| Tabs | Upcoming / Past |
| Ticket Card | Event name, date, seat |
| QR Code | Button |
| Download | Button |
| Transfer | Button |

---

# 10. COACH PROFILE SCREENS

## 10.1 Coach List

| Element | Function |
|---------|----------|
| Search Bar | Search coaches |
| Filter | Filter by sport, rating, price |
| Coach Card | Avatar, name, sport, rating, price |
| View Profile | Button |

## 10.2 Coach Profile

| Element | Details |
|---------|---------|
| Profile Picture | Large avatar |
| Name | Coach's name |
| Sport | Specialization |
| Rating | Star rating |
| Reviews | Number of reviews |
| Experience | Years of experience |
| Bio | About coach |
| Plans | Training plans offered |
| Events | Events organized |
| Book Session | Button |
| View Plans | Button |
| Message | Button |

## 10.3 Book Session with Coach

| Element | Details |
|---------|---------|
| Coach Info | Name, photo |
| Session Type | 1-on-1 / Group |
| Date | Date picker |
| Time | Time slot selection |
| Duration | 30min / 60min / 90min |
| Location | Online / In-person |
| Price | Session cost |
| Confirm Booking | Button |

---

# 11. NOTIFICATIONS SCREEN

## 11.1 Notifications List

| Element | Details |
|---------|---------|
| Notification Card | Icon, title, message, time |
| Read/Unread | Status indicator |
| Tap | View notification |
| Clear All | Button |
| Settings | Button |

## 11.2 Notification Types

| Type | Icon | Example |
|------|------|---------|
| Booking | 🎫 | "Your booking is confirmed" |
| Reminder | ⏰ | "Event starts in 1 hour" |
| Payment | 💳 | "Payment received" |
| Training | 📚 | "New training session available" |
| System | 🔔 | "App update available" |

---

# 12. SETTINGS SCREENS

## 12.1 Settings Menu

| Item | Function |
|------|----------|
| Account | Edit account details |
| Notifications | Notification preferences |
| Privacy | Privacy settings |
| Language | Select language |
| Theme | Light/Dark mode |
| Payment Methods | Manage payment options |
| Help Center | FAQs and support |
| About | App info |
| Logout | Sign out |

## 12.2 Notification Settings

| Item | Toggle |
|------|--------|
| Push Notifications | On/Off |
| Email Notifications | On/Off |
| SMS Notifications | On/Off |
| Booking Updates | On/Off |
| Training Reminders | On/Off |
| Promotions | On/Off |

---

# 13. SEARCH SCREEN

## 13.1 Search Bar

| Element | Details |
|---------|---------|
| Input Field | Search query |
| Search Icon | Trigger search |
| Clear | Clear input |
| Voice | Voice search |

## 13.2 Search Results

| Element | Details |
|---------|---------|
| Tabs | All / Events / Training / Coaches |
| Result Card | Image, name, type, rating |
| Filter | Filter results |
| Sort | Sort results |

---

# 14. EMPTY STATES

## 14.1 No Bookings

| Element | Details |
|---------|---------|
| Illustration | Empty calendar |
| Title | "No Bookings Yet" |
| Description | "Start exploring events and training plans" |
| Button | "Browse Events" |

## 14.2 No Tickets

| Element | Details |
|---------|---------|
| Illustration | Empty ticket |
| Title | "No Tickets" |
| Description | "Buy tickets for upcoming events" |
| Button | "Browse Events" |

## 14.3 No Training Plans

| Element | Details |
|---------|---------|
| Illustration | Empty notebook |
| Title | "No Training Plans" |
| Description | "Start a training plan to improve your skills" |
| Button | "Browse Plans" |

---

# 15. ERROR STATES

## 15.1 No Internet

| Element | Details |
|---------|---------|
| Illustration | No connection |
| Title | "No Internet Connection" |
| Description | "Please check your internet settings" |
| Button | "Retry" |

## 15.2 Server Error

| Element | Details |
|---------|---------|
| Illustration | Server down |
| Title | "Something Went Wrong" |
| Description | "We're working on fixing this" |
| Button | "Try Again" |

---

# 16. BUTTONS & ACTIONS

## 16.1 Primary Buttons

| Button | Color | Usage |
|--------|-------|-------|
| Login | Blue | Login action |
| Sign Up | Blue | Create account |
| Book Now | Blue | Book event/ticket |
| Start Plan | Blue | Start training |
| Pay Now | Green | Payment action |
| Confirm | Green | Confirm action |

## 16.2 Secondary Buttons

| Button | Style | Usage |
|--------|-------|-------|
| Cancel | Outline | Cancel action |
| Skip | Text | Skip step |
| Back | Text | Go back |
| View Details | Outline | View more |

## 16.3 Icon Buttons

| Icon | Action |
|------|--------|
| ❤️ | Favorite/Like |
| 📤 | Share |
| 🔍 | Search |
| 🔔 | Notifications |
| 🛒 | Cart |
| ⚙️ | Settings |

---

# 17. SWIPE ACTIONS

## 17.1 List Items

| Swipe | Action |
|-------|--------|
| Left | Delete/Remove |
| Right | Favorite/Save |

## 17.2 Cards

| Swipe | Action |
|-------|--------|
| Left | Dismiss |
| Right | Save |

---

# 18. PULL TO REFRESH

| Screen | Refreshes |
|--------|-----------|
| Home | All sections |
| Events | Events list |
| Training | Plans list |
| Profile | User data |

---

# 19. LOADING STATES

## 19.1 Skeleton Loading

| Screen | Skeleton Type |
|--------|---------------|
| Home | Card placeholders |
| Events | List placeholders |
| Training | Grid placeholders |
| Profile | Profile placeholders |

## 19.2 Progress Indicators

| Type | Usage |
|------|-------|
| Circular | Page loading |
| Linear | Upload/download |
| Dots | Content loading |

---

# 20. TOAST MESSAGES

## 20.1 Success

| Message | Usage |
|---------|-------|
| "Booking Confirmed!" | After booking |
| "Payment Successful!" | After payment |
| "Profile Updated!" | After edit |
| "Added to Cart!" | After add to cart |

## 20.2 Error

| Message | Usage |
|---------|-------|
| "Booking Failed" | On error |
| "Payment Failed" | On error |
| "Something Went Wrong" | On error |
| "No Internet Connection" | On offline |

## 20.3 Warning

| Message | Usage |
|---------|-------|
| "Session Expired" | On timeout |
| "Item Removed" | After delete |
| "Cart Empty" | On checkout |

---

# 21. SCREEN FLOW DIAGRAM

```
Onboarding → Login/Signup → Home
                              ↓
                    ┌─────────┼─────────┐
                    ↓         ↓         ↓
                Training   Events    Tickets
                    ↓         ↓         ↓
                Details   Details   Details
                    ↓         ↓         ↓
                Book/Start Register  Book
                    ↓         ↓         ↓
                Payment   Payment   Payment
                    ↓         ↓         ↓
                Success   Success   Success
                    ↓         ↓         ↓
                    └─────────┼─────────┘
                              ↓
                           Profile
```

---

# 22. RESPONSIVE DESIGN

## 22.1 Screen Sizes

| Device | Width | Height |
|--------|-------|--------|
| iPhone SE | 375x667 | Small |
| iPhone 14 | 390x844 | Medium |
| iPhone 14 Pro Max | 430x932 | Large |
| Android Small | 360x640 | Small |
| Android Medium | 390x844 | Medium |
| Android Large | 412x915 | Large |

## 22.2 Breakpoints

| Breakpoint | Value | Usage |
|------------|-------|-------|
| Mobile | < 600px | Single column |
| Tablet | 600-900px | Two columns |
| Desktop | > 900px | Three columns |

---

**Document Version**: 1.0
**Date**: August 29, 2026
