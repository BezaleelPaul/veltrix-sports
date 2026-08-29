# VELTRIX SPORTS - 2 WEEK SPRINT PLAN
## MVP Delivery Plan

---

## SPRINT OVERVIEW

| Item | Details |
|------|---------|
| **Duration** | 2 weeks (10 working days) |
| **Goal** | Working MVP with Login, Dashboard, Plans, Events |
| **Team** | 2 Flutter + 1 Backend |
| **Budget** | ₹30,000 |

---

## DELIVERABLES

### Must Have (P0)
- [ ] User registration (email + phone)
- [ ] User login (email + password)
- [ ] OTP verification
- [ ] Dashboard with stats
- [ ] Training plans list
- [ ] Plan detail view
- [ ] Events list
- [ ] Event detail view
- [ ] Event registration
- [ ] Basic payment (Razorpay)

### Nice to Have (P1) - If Time Permits
- [ ] Profile screen
- [ ] Settings screen
- [ ] Push notifications

### Skip (P2)
- ❌ AI plan generation
- ❌ Device sync
- ❌ Ticketing marketplace
- ❌ Admin panel
- ❌ Analytics

---

# WEEK 1: FOUNDATION

## Day 1 (Monday) - Backend Setup

### Morning (9 AM - 1 PM)
| Task | Owner | Status |
|------|-------|--------|
| Create Node.js project | Backend | ☐ |
| Setup Express + middleware | Backend | ☐ |
| Setup PostgreSQL connection | Backend | ☐ |
| Create database schema | Backend | ☐ |
| Run migrations | Backend | ☐ |

### Afternoon (2 PM - 6 PM)
| Task | Owner | Status |
|------|-------|--------|
| Create User model | Backend | ☐ |
| Create Auth routes | Backend | ☐ |
| Implement register API | Backend | ☐ |
| Implement login API | Backend | ☐ |
| Test APIs with Postman | Backend | ☐ |

### Day 1 Deliverables
- ✅ Backend project running
- ✅ Database connected
- ✅ Register/Login APIs working

---

## Day 2 (Tuesday) - Auth APIs + Flutter Setup

### Morning (9 AM - 1 PM)
| Task | Owner | Status |
|------|-------|--------|
| Implement OTP generation | Backend | ☐ |
| Implement OTP verification | Backend | ☐ |
| Implement JWT token refresh | Backend | ☐ |
| Create Flutter project | Flutter | ☐ |
| Setup project structure | Flutter | ☐ |

### Afternoon (2 PM - 6 PM)
| Task | Owner | Status |
|------|-------|--------|
| Add dependencies (dio, bloc, go_router) | Flutter | ☐ |
| Create API client | Flutter | ☐ |
| Create Auth repository | Flutter | ☐ |
| Create Auth BLoC | Flutter | ☐ |
| Test API connection | Flutter + Backend | ☐ |

### Day 2 Deliverables
- ✅ All auth APIs complete
- ✅ Flutter project initialized
- ✅ API connection working

---

## Day 3 (Wednesday) - Auth Screens

### Morning (9 AM - 1 PM)
| Task | Owner | Status |
|------|-------|--------|
| Create Login screen UI | Flutter | ☐ |
| Create Register screen UI | Flutter | ☐ |
| Create OTP verification screen | Flutter | ☐ |
| Add form validation | Flutter | ☐ |
| Connect to Auth BLoC | Flutter | ☐ |

### Afternoon (2 PM - 6 PM)
| Task | Owner | Status |
|------|-------|--------|
| Implement login flow | Flutter | ☐ |
| Implement register flow | Flutter | ☐ |
| Implement OTP flow | Flutter | ☐ |
| Store JWT token | Flutter | ☐ |
| Test complete auth flow | Flutter | ☐ |

### Day 3 Deliverables
- ✅ Login screen working
- ✅ Register screen working
- ✅ OTP verification working
- ✅ User can login and get token

---

## Day 4 (Thursday) - Dashboard API + Screen

### Morning (9 AM - 1 PM)
| Task | Owner | Status |
|------|-------|--------|
| Create Dashboard API | Backend | ☐ |
| Create User profile API | Backend | ☐ |
| Create Plans list API | Backend | ☐ |
| Create Events list API | Backend | ☐ |
| Test all APIs | Backend | ☐ |

### Afternoon (2 PM - 6 PM)
| Task | Owner | Status |
|------|-------|--------|
| Create Dashboard screen UI | Flutter | ☐ |
| Create stats cards | Flutter | ☐ |
| Create quick actions | Flutter | ☐ |
| Connect to APIs | Flutter | ☐ |
| Test dashboard | Flutter | ☐ |

### Day 4 Deliverables
- ✅ Dashboard APIs complete
- ✅ Dashboard screen working
- ✅ User stats displayed

---

## Day 5 (Friday) - Training Plans

### Morning (9 AM - 1 PM)
| Task | Owner | Status |
|------|-------|--------|
| Create Plans list screen | Flutter | ☐ |
| Create Plan card widget | Flutter | ☐ |
| Create Plan detail screen | Flutter | ☐ |
| Create Session list widget | Flutter | ☐ |
| Connect to Plans API | Flutter | ☐ |

### Afternoon (2 PM - 6 PM)
| Task | Owner | Status |
|------|-------|--------|
| Create Session detail screen | Flutter | ☐ |
| Implement pull-to-refresh | Flutter | ☐ |
| Add loading states | Flutter | ☐ |
| Add error handling | Flutter | ☐ |
| Test complete flow | Flutter | ☐ |

### Day 5 Deliverables
- ✅ Plans list working
- ✅ Plan detail working
- ✅ Session detail working
- ✅ Week 1 complete

---

# WEEK 2: FEATURES + POLISH

## Day 6 (Monday) - Events

### Morning (9 AM - 1 PM)
| Task | Owner | Status |
|------|-------|--------|
| Create Events list screen | Flutter | ☐ |
| Create Event card widget | Flutter | ☐ |
| Create Event detail screen | Flutter | ☐ |
| Create filter/search UI | Flutter | ☐ |
| Connect to Events API | Flutter | ☐ |

### Afternoon (2 PM - 6 PM)
| Task | Owner | Status |
|------|-------|--------|
| Implement event filters | Flutter | ☐ |
| Implement search | Flutter | ☐ |
| Add event images | Flutter | ☐ |
| Create registration form | Flutter | ☐ |
| Test events flow | Flutter | ☐ |

### Day 6 Deliverables
- ✅ Events list working
- ✅ Event detail working
- ✅ Filters working

---

## Day 7 (Tuesday) - Event Registration

### Morning (9 AM - 1 PM)
| Task | Owner | Status |
|------|-------|--------|
| Create Registration API | Backend | ☐ |
| Create Categories API | Backend | ☐ |
| Create My Registrations API | Backend | ☐ |
| Implement registration logic | Backend | ☐ |
| Test APIs | Backend | ☐ |

### Afternoon (2 PM - 6 PM)
| Task | Owner | Status |
|------|-------|--------|
| Complete registration form | Flutter | ☐ |
| Add category selection | Flutter | ☐ |
| Add form validation | Flutter | ☐ |
| Create My Registrations screen | Flutter | ☐ |
| Test registration flow | Flutter | ☐ |

### Day 7 Deliverables
- ✅ Registration API working
- ✅ Registration form working
- ✅ User can register for events

---

## Day 8 (Wednesday) - Payments

### Morning (9 AM - 1 PM)
| Task | Owner | Status |
|------|-------|--------|
| Create Razorpay account | Backend | ☐ |
| Setup Razorpay keys | Backend | ☐ |
| Create Payment API | Backend | ☐ |
| Implement order creation | Backend | ☐ |
| Implement payment verification | Backend | ☐ |

### Afternoon (2 PM - 6 PM)
| Task | Owner | Status |
|------|-------|--------|
| Add razorpay_flutter package | Flutter | ☐ |
| Create Payment service | Flutter | ☐ |
| Implement checkout flow | Flutter | ☐ |
| Add payment success/failure handling | Flutter | ☐ |
| Test payment flow | Flutter + Backend | ☐ |

### Day 8 Deliverables
- ✅ Razorpay integrated
- ✅ Payment flow working
- ✅ Payment verification working

---

## Day 9 (Thursday) - Testing + Bug Fixes

### Morning (9 AM - 1 PM)
| Task | Owner | Status |
|------|-------|--------|
| Test complete user flow | QA | ☐ |
| Test edge cases | QA | ☐ |
| Fix critical bugs | Flutter + Backend | ☐ |
| Fix UI issues | Flutter | ☐ |
| Performance testing | QA | ☐ |

### Afternoon (2 PM - 6 PM)
| Task | Owner | Status |
|------|-------|--------|
| Fix remaining bugs | Flutter + Backend | ☐ |
| Add loading indicators | Flutter | ☐ |
| Add error messages | Flutter | ☐ |
| Add empty states | Flutter | ☐ |
| Final testing | QA | ☐ |

### Day 9 Deliverables
- ✅ All critical bugs fixed
- ✅ UI polished
- ✅ Ready for deployment

---

## Day 10 (Friday) - Deploy + Handover

### Morning (9 AM - 1 PM)
| Task | Owner | Status |
|------|-------|--------|
| Setup AWS EC2 instance | Backend | ☐ |
| Deploy backend API | Backend | ☐ |
| Setup PostgreSQL on RDS | Backend | ☐ |
| Configure environment vars | Backend | ☐ |
| Test deployed API | Backend | ☐ |

### Afternoon (2 PM - 6 PM)
| Task | Owner | Status |
|------|-------|--------|
| Build Flutter APK/IPA | Flutter | ☐ |
| Test on real devices | Flutter | ☐ |
| Create release notes | All | ☐ |
| Handover documentation | All | ☐ |
| Sprint review meeting | All | ☐ |

### Day 10 Deliverables
- ✅ Backend deployed
- ✅ App built and tested
- ✅ Documentation complete
- ✅ Handover done

---

# DAILY STANDUP TEMPLATE

**Time**: 9:30 AM Daily

```
1. What did I do yesterday?
2. What will I do today?
3. Any blockers?
```

---

# API ENDPOINTS (Week 1)

## Auth APIs
```
POST /api/auth/register
POST /api/auth/login
POST /api/auth/otp/send
POST /api/auth/otp/verify
POST /api/auth/refresh
```

## User APIs
```
GET /api/user/profile
PUT /api/user/profile
```

## Training APIs
```
GET /api/plans
GET /api/plans/:id
GET /api/plans/:id/sessions
GET /api/sessions/:id
```

## Event APIs
```
GET /api/events
GET /api/events/:id
POST /api/events/:id/register
GET /api/events/registrations
```

## Payment APIs
```
POST /api/payments/create
POST /api/payments/verify
```

---

# FLUTTER SCREENS

## Auth Flow
1. Splash Screen
2. Login Screen
3. Register Screen
4. OTP Screen

## Main Flow
5. Dashboard Screen
6. Training Plans Screen
7. Plan Detail Screen
8. Session Detail Screen
9. Events Screen
10. Event Detail Screen
11. Registration Screen
12. My Registrations Screen
13. Profile Screen

---

# TECHNICAL STACK

## Backend
- Node.js + Express
- PostgreSQL
- JWT Authentication
- Razorpay SDK

## Frontend
- Flutter 3.41.9
- BLoC (State Management)
- GoRouter (Navigation)
- Dio (HTTP Client)

## Infrastructure
- AWS EC2 (Hosting)
- AWS RDS (Database)
- Razorpay (Payments)

---

# RISK MITIGATION

| Risk | Mitigation |
|------|------------|
| API delays | Mock data fallback |
| Payment issues | Test Razorpay early |
| Deployment issues | Use simple hosting |
| Time crunch | Cut P1 features |

---

# SUCCESS CRITERIA

- [ ] User can register and login
- [ ] User can view dashboard
- [ ] User can browse training plans
- [ ] User can browse events
- [ ] User can register for events
- [ ] User can make payment
- [ ] App deployed and working

---

**Sprint Start**: ____________
**Sprint End**: ____________
**Approved By**: ____________
