# VELTRIX SPORTS
## Requirements & Cost Summary

---

**Date**: August 29, 2026
**For**: Stakeholder Review

---

# 1. PROJECT REQUIREMENTS

## 1.1 What We're Building

A sports platform with 3 core modules:

| Module | Description |
|--------|-------------|
| **Training Plans** | Create, manage, and follow workout plans (Running, Cycling, Triathlon) |
| **Events** | Browse, register, and manage sports events |
| **Ticketing** | Buy, sell, and manage event tickets |

## 1.2 Platform Requirements

| Platform | Required |
|----------|----------|
| Android | ✅ Yes |
| iOS | ✅ Yes |
| Web | ✅ Yes |

## 1.3 Feature Requirements

### Training Plans (Must Have)
- [ ] User registration & login
- [ ] Create training plans
- [ ] AI-generated plans
- [ ] Track workout sessions
- [ ] View progress charts
- [ ] Connect fitness devices (Garmin, Apple Watch, Strava)

### Events (Must Have)
- [ ] Browse events
- [ ] Filter by sport/city/date
- [ ] Register for events
- [ ] View my registrations
- [ ] Event details with route map

### Ticketing (Should Have)
- [ ] Buy tickets
- [ ] View purchased tickets
- [ ] QR code for check-in
- [ ] Promo code support

### Payments (Must Have)
- [ ] Razorpay integration
- [ ] UPI, Cards, Net Banking
- [ ] Payment receipts
- [ ] Refund support

### Profile (Should Have)
- [ ] Edit profile
- [ ] View stats
- [ ] Connected devices
- [ ] Notification settings

---

# 2. TOOLS & TECHNOLOGY

## 2.1 Development Tools (FREE)

| Tool | Cost | Purpose |
|------|------|---------|
| Flutter SDK | ₹0 | Mobile app development |
| Dart SDK | ₹0 | Programming language |
| VS Code | ₹0 | Code editor |
| Git | ₹0 | Version control |
| Node.js | ₹0 | Backend runtime |
| PostgreSQL | ₹0 | Database |
| **Total** | **₹0** | |

## 2.2 Cloud Services (AWS)

| Service | Free Tier | After Free Tier |
|---------|-----------|-----------------|
| EC2 (Compute) | 750 hrs/month | ₹1,400/month |
| RDS (Database) | 750 hrs/month | ₹2,800/month |
| S3 (Storage) | 5GB | ₹200/month |
| CloudFront (CDN) | 1TB transfer | ₹800/month |
| Cognito (Auth) | 50K users | ₹1,400/month |
| **Total** | **₹0 (12 months)** | **₹6,600/month** |

## 2.3 Third-Party Services

| Service | Cost | Purpose |
|---------|------|---------|
| Razorpay | 2% per transaction | Payments |
| Firebase | Free (basic) | Push notifications |
| Garmin API | Free | Device integration |
| Strava API | Free | Device integration |
| **Total** | **~₹500/month** | |

---

# 3. COST BREAKDOWN

## 3.1 Option A: MVP Only (2 Weeks)

### What You Get
- Basic login/register
- Dashboard
- View training plans
- View events
- Basic payment

### Cost

| Item | Cost |
|------|------|
| **Development** | |
| Flutter Developer (2) | ₹20,000 |
| Backend Developer (1) | ₹10,000 |
| UI/UX Designer (1) | ₹7,500 |
| QA Engineer (1) | ₹6,250 |
| **Subtotal** | **₹43,750** |
| | |
| **Infrastructure** | |
| AWS (Free Tier) | ₹0 |
| Third-party services | ₹1,000 |
| **Subtotal** | **₹1,000** |
| | |
| **TOTAL** | **₹44,750** |

---

## 3.2 Option B: Full Product (3 Months)

### What You Get
- Complete training plan module
- Complete events module
- Complete ticketing module
- Payment integration
- Device integration
- Admin panel

### Cost

| Item | Cost |
|------|------|
| **Development** | |
| Flutter Developer (3) | ₹1,80,000 |
| Backend Developer (2) | ₹1,20,000 |
| UI/UX Designer (1) | ₹45,000 |
| QA Engineer (2) | ₹75,000 |
| DevOps (1) | ₹75,000 |
| **Subtotal** | **₹4,95,000** |
| | |
| **Infrastructure** | |
| AWS (3 months) | ₹19,800 |
| Third-party services | ₹1,500 |
| **Subtotal** | **₹21,300** |
| | |
| **TOTAL** | **₹5,16,300** |

---

## 3.3 Option C: Enterprise (6 Months)

### What You Get
- Everything in Full Product
- AI plan generation
- Live event tracking
- Advanced analytics
- Multi-language support
- White-label options

### Cost

| Item | Cost |
|------|------|
| **Development** | |
| Flutter Developer (4) | ₹4,80,000 |
| Backend Developer (3) | ₹3,60,000 |
| UI/UX Designer (2) | ₹1,20,000 |
| QA Engineer (2) | ₹1,50,000 |
| DevOps (1) | ₹1,20,000 |
| Project Manager (1) | ₹60,000 |
| **Subtotal** | **₹12,90,000** |
| | |
| **Infrastructure** | |
| AWS (6 months) | ₹39,600 |
| Third-party services | ₹3,000 |
| **Subtotal** | **₹42,600** |
| | |
| **TOTAL** | **₹13,32,600** |

---

# 4. COMPARISON TABLE

| Feature | MVP (₹44K) | Full (₹5.1L) | Enterprise (₹13.3L) |
|---------|------------|--------------|---------------------|
| Login/Register | ✅ | ✅ | ✅ |
| Dashboard | ✅ | ✅ | ✅ |
| Training Plans | Basic | Full | Full + AI |
| Events | Basic | Full | Full + Live |
| Ticketing | ❌ | ✅ | ✅ |
| Payments | Basic | Full | Full |
| Device Sync | ❌ | ✅ | ✅ |
| Admin Panel | ❌ | ✅ | ✅ |
| Analytics | ❌ | Basic | Advanced |
| Multi-language | ❌ | ❌ | ✅ |
| Timeline | 2 weeks | 3 months | 6 months |

---

# 5. RECOMMENDATION

## For Startup/MVP
**Choose Option A (₹44,750)**
- Get basic product running
- Test with users
- Iterate based on feedback

## For Business
**Choose Option B (₹5,16,300)**
- Complete product
- All features working
- Ready for market

## For Enterprise
**Choose Option C (₹13,32,600)**
- Full-featured platform
- Scalable architecture
- Advanced capabilities

---

# 6. TIMELINE

## MVP (2 Weeks)

```
Week 1:
├── Day 1-2: Setup + Auth
├── Day 3-5: Dashboard + Plans
└── Day 6-7: Events + Basic UI

Week 2:
├── Day 8-9: Integration + Testing
└── Day 10: Deploy
```

## Full Product (3 Months)

```
Month 1: Foundation
├── Auth System
├── Dashboard
└── Core Infrastructure

Month 2: Features
├── Training Plans
├── Events
└── Ticketing

Month 3: Polish
├── Payments
├── Device Sync
└── Testing + Deploy
```

---

# 7. NEXT STEPS

| Step | Action | Timeline |
|------|--------|----------|
| 1 | Approve requirements | Today |
| 2 | Select option (A/B/C) | Today |
| 3 | Finalize team | Day 1 |
| 4 | Start development | Day 2 |
| 5 | MVP delivery | Week 2 |
| 6 | Full product delivery | Month 3 |

---

# 8. CONTACT

| Role | Responsibility |
|------|----------------|
| Project Manager | Requirements, Timeline |
| Tech Lead | Architecture, Development |
| QA Lead | Testing, Quality |

---

**Document Version**: 1.0
**Date**: August 29, 2026
**Status**: Ready for Review
