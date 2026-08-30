# VELTRIX SPORTS
## Reconciled Project Proposal — Stakeholder Approval

---

**Document Version**: 2.0
**Date**: August 29, 2026
**Classification**: Confidential — For Internal Review
**Prepared For**: Project Stakeholder
**Prepared By**: Veltrix Sports Development Team

---

# Executive Summary

**Veltrix Sports** is a sports platform connecting athletes, coaches, event organizers, and spectators through three verticals: **Training Plans**, **Events**, and **Ticketing**.

This document reconciles the **Product Feature List** (4-page PDF) with the **Project Proposal** (22-page DOCX) and classifies all features into prioritized phases.

### Key Finding

The Product Feature List contains **significantly more functionality** than the original 2-week MVP proposal. The full feature set requires **3-6 months** of development, not 2 weeks.

### Recommended Approach

| Phase | Timeline | Scope | Budget |
|-------|----------|-------|--------|
| **Phase 1: MVP** | 2 weeks | Core features only | ₹91,800 |
| **Phase 2: Launch** | Weeks 3-8 | Complete product | ₹155,000 |
| **Phase 3: Scale** | Month 3+ | Enterprise features | ₹210,000 |
| **Total** | 6 months | Full platform | ₹456,800 |

### Decision Required

**Stakeholder must confirm**: Phase 1 only (₹91,800) or Phase 1+2 (₹246,800)?

---

# 1. Scope Reconciliation Summary

## 1.1 Feature Count Comparison

| Source | Features | Estimated Screens |
|--------|----------|-------------------|
| Product Feature List PDF | 80+ | 60-80 |
| Project Proposal DOCX | 28 | 28 |
| **Difference** | **52+ features** | **32-52 screens** |

## 1.2 Major Gaps Identified

### Training Plan Vertical

| Feature | In Proposal? | In Feature List? | Priority |
|---------|--------------|------------------|----------|
| AI plan generation | No | Yes | P2 |
| Wearable integration | No | Yes | P1 |
| Terrain integration | No | Yes | P1 |
| Weather integration | No | Yes | P1 |
| Zoom/Google Meet | No | Yes | P1 |
| In-app messaging | No | Yes | P1 |
| Subscription billing | No | Yes | P1 |
| Referral program | No | Yes | P1 |

### Events Vertical

| Feature | In Proposal? | In Feature List? | Priority |
|---------|--------------|------------------|----------|
| Organizer management | No | Yes | P1 |
| Bib allocation | No | Yes | P1 |
| Volunteer management | No | Yes | P1 |
| Route maps | No | Yes | P1 |
| Live tracking | No | Yes | P1 |
| Results/e-certificates | No | Yes | P1 |
| Sponsor management | No | Yes | P1 |
| Merchandise sales | No | Yes | P1 |

### Ticketing Vertical

| Feature | In Proposal? | In Feature List? | Priority |
|---------|--------------|------------------|----------|
| Self-serve organizer dashboard | No | Yes | P1 |
| Multi-event marketplace | No | Yes | P1 |
| Custom registration forms | No | Yes | P1 |
| Commission/payout system | No | Yes | P1 |

---

# 2. Feature Prioritization

## 2.1 P0 — Must-Have MVP (2-Week Scope)

### Training Plan (B2B & B2C)

| Feature | Description |
|---------|-------------|
| UI/UX design | App design |
| User database | User management |
| Server, hosting, maintenance | Infrastructure |
| Domain | veltrixsports.com |
| Coach and athlete dashboards | Basic dashboards |
| Landing pages | Basic pages |
| Registration flow | User signup |
| Welcome kit | Digital welcome |
| Payment gateway | Razorpay integration |
| Email/account setup | Authentication |
| Running plans | Core content |
| Triathlon plans | Core content |
| Biking plans | Core content |
| Nutrition plan | Core content |
| Hydration plan | Core content |
| Strength & conditioning | Core content |
| API integration | Backend connectivity |
| User journey tracking | Basic analytics |
| Analytics | Basic reporting |

### Events

| Feature | Description |
|---------|-------------|
| Event listing | Browse events |
| Event registration | Register for events |
| Tickets | Purchase tickets |
| Payment gateway | Razorpay integration |
| API integration | Backend connectivity |
| Analytics | Basic reporting |

### Ticketing

| Feature | Description |
|---------|-------------|
| Ticketing functionality | Core marketplace |
| QR code check-in | Venue check-in |
| Event reviews | Basic ratings |

### Cross-Cutting

| Feature | Description |
|---------|-------------|
| Shared infrastructure | Server, hosting |
| API integrations | Backend connectivity |
| Analytics | Basic reporting |

---

## 2.2 P1 — Launch/Phase 2 (Weeks 3-8)

### Training Plan

| Feature | Description |
|---------|-------------|
| Fitness/medical intake | Onboarding assessment |
| Subscription billing | Recurring payments |
| Content library | Videos, articles |
| Device integration | Wearables (Garmin, Apple Watch) |
| Terrain integration | Route data |
| Weather integration | Training context |
| Zoom/Google Meet | Live coaching |
| Performance tracking | Progress over time |
| In-app messaging | Coach-athlete communication |
| Push notifications | Retention |
| Referral program | Growth |
| Customer support | Helpdesk |

### Events

| Feature | Description |
|---------|-------------|
| Coaching plan add-on | Cross-sell |
| Team/relay registration | Group events |
| Waitlist management | Capacity management |
| Promo/discount codes | Marketing |
| Refund/cancellation rules | Policy management |
| Device integration | Race tracking |
| Terrain integration | Route data |
| Weather integration | Event context |
| Organizer tools | Event creation |
| Bib allocation | Race operations |
| Volunteer management | Event operations |
| Route maps | Race info |
| Live tracking | Real-time |
| Results processing | Post-event |
| e-certificates | Post-event |
| Race photo marketplace | Revenue |
| Sponsor management | Revenue |
| Merchandise sales | Revenue |
| Post-event feedback | Improvement |

### Ticketing

| Feature | Description |
|---------|-------------|
| Organizer dashboard | Self-serve |
| Multi-event marketplace | Discovery |
| Custom registration forms | Flexibility |
| Multiple ticket tiers | Revenue optimization |
| Commission structure | Revenue model |
| Automated payouts | Operations |
| SEO-optimized pages | Discovery |

---

## 2.3 P2 — Future/Advanced (Month 3+)

### Training Plan

| Feature | Description |
|---------|-------------|
| AI plan generation | ML/AI powered |
| Advanced analytics | Business intelligence |
| White-label solutions | B2B scaling |

### Events

| Feature | Description |
|---------|-------------|
| Advanced live tracking | GPS infrastructure |
| Advanced results | Complex logic |
| Advanced sponsor management | CRM integration |

### Ticketing

| Feature | Description |
|---------|-------------|
| Advanced marketplace | Scaling |
| Dynamic pricing | Algorithm |
| Advanced SEO | Marketing |

### Cross-Cutting

| Feature | Description |
|---------|-------------|
| Admin/CMS panel | Internal tools |
| GDPR/DPDP compliance | Legal requirements |
| Marketing tools | Email/SMS campaigns |
| Business dashboard | Intelligence |
| Customer support | Operations |

---

# 3. Revised Technical Architecture

## 3.1 Architecture Layers

| Layer | Technology | Purpose |
|-------|------------|---------|
| Frontend | Flutter 3.41.9 | Cross-platform mobile |
| Language | Dart 3.11.5 | Application logic |
| State Management | BLoC | Application state |
| Navigation | GoRouter | Screen navigation |
| HTTP Client | Dio | API communication |
| Local Storage | Hive | Local persistence |
| Backend | [REQUIRES CONFIRMATION] | Backend services |
| Database | [REQUIRES CONFIRMATION] | Data persistence |
| Payment | Razorpay | Payment processing |

## 3.2 Backend Options

**[BACKEND ARCHITECTURE REQUIRES CONFIRMATION]**

| Option | Services | Best For |
|--------|----------|----------|
| Firebase-Primary | Firebase Auth, Firestore, Storage | Quick MVP |
| AWS-Primary | Cognito, RDS, S3 | Scalability |
| Hybrid | Firebase Auth, PostgreSQL, S3 | Balance |

---

# 4. Revised Timeline

## 4.1 Phase 1: MVP (2 Weeks)

| Day | Focus | Deliverables |
|-----|-------|--------------|
| 1 | Backend Setup | Database, Auth APIs, Scaffolding |
| 2 | Flutter Setup | Structure, Theme, Navigation |
| 3 | Authentication | Login, Signup, OTP |
| 4 | Home Dashboard | Home, Quick actions |
| 5 | Training Module | Plans, Details, Sessions |
| 6 | Events Module | Events, Details, Registration |
| 7 | Ticketing Module | Tickets, Seat selection |
| 8 | Payments | Razorpay, Cart, Checkout |
| 9 | Testing | Bug fixes, Polish |
| 10 | Deployment | Build, Upload |

## 4.2 Phase 2: Launch (Weeks 3-8)

| Week | Focus | Deliverables |
|------|-------|--------------|
| 3-4 | Wearables + Integrations | Device sync, Terrain, Weather |
| 5-6 | Events Operations | Organizer tools, Bibs, Live tracking |
| 7-8 | Marketplace | Self-serve dashboard, Commission system |

## 4.3 Phase 3: Scale (Month 3+)

| Month | Focus | Deliverables |
|-------|-------|--------------|
| 3 | AI + Advanced | AI plans, Advanced analytics |
| 4 | Compliance + Marketing | GDPR, Marketing tools |
| 5-6 | Enterprise | Admin CMS, Business dashboard |

---

# 5. Revised Cost Breakdown

## 5.1 Phase 1: MVP

| Category | Amount (₹) |
|----------|------------|
| Development | 65,000 |
| Infrastructure | 800 |
| Services | 500 |
| App Stores | 25,500 |
| **Phase 1 Total** | **91,800** |

## 5.2 Phase 2: Launch

| Category | Amount (₹) |
|----------|------------|
| Flutter Development | 80,000 |
| Backend Development | 40,000 |
| UI/UX Design | 20,000 |
| Infrastructure | 5,000 |
| Services | 10,000 |
| **Phase 2 Total** | **155,000** |

## 5.3 Phase 3: Scale

| Category | Amount (₹) |
|----------|------------|
| AI/ML Development | 100,000 |
| Backend Development | 60,000 |
| Infrastructure | 20,000 |
| Services | 30,000 |
| **Phase 3 Total** | **210,000** |

## 5.4 Total Investment

| Phase | Amount (₹) |
|-------|------------|
| Phase 1: MVP | 91,800 |
| Phase 2: Launch | 155,000 |
| Phase 3: Scale | 210,000 |
| **Grand Total** | **456,800** |

---

# 6. Platform Scope

| Platform | Phase 1 | Phase 2 | Phase 3 |
|----------|---------|---------|---------|
| Android | Primary | Primary | Primary |
| iOS | [REQUIRES CONFIRMATION] | Secondary | Secondary |
| Web | No | [REQUIRES CONFIRMATION] | [REQUIRES CONFIRMATION] |

---

# 7. Team Requirements

## 7.1 Phase 1 Team

| Role | Count |
|------|-------|
| Flutter Developer | 2 |
| Backend Developer | 1 |
| UI/UX Designer | 1 |
| QA Tester | 1 |

## 7.2 Phase 2 Team (Additional)

| Role | Count |
|------|-------|
| Flutter Developer | +1 |
| Backend Developer | +1 |
| DevOps Engineer | 1 |

## 7.3 Phase 3 Team (Additional)

| Role | Count |
|------|-------|
| AI/ML Engineer | 1 |
| Data Engineer | 1 |

---

# 8. Acceptance Criteria

## 8.1 Phase 1 MVP Criteria

| ID | Criterion |
|----|-----------|
| AC-01 | All 28 screens implemented |
| AC-02 | Authentication works (email, Google, Apple) |
| AC-03 | Training plans browsable and purchasable |
| AC-04 | Events browsable and registrable |
| AC-05 | Tickets purchasable with QR codes |
| AC-06 | Razorpay integration functional |
| AC-07 | Profile management works |
| AC-08 | All critical defects resolved |
| AC-09 | Release build passes QA |
| AC-10 | App store submission complete |

## 8.2 Phase 2 Launch Criteria

| ID | Criterion |
|----|-----------|
| AC-11 | Wearable integration functional |
| AC-12 | Organizer tools available |
| AC-13 | Live tracking working |
| AC-14 | Marketplace operational |
| AC-15 | Commission system functional |

---

# 9. Risks & Mitigation

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| Scope creep | High | High | Strict phase adherence |
| Backend delays | Medium | High | Early API provisioning |
| Payment issues | Medium | High | Early sandbox testing |
| Timeline overrun | Medium | High | Daily standups |
| Feature list expansion | High | Medium | Change request process |

---

# 10. Immediate Next Steps

| # | Action | Owner |
|---|--------|-------|
| 1 | Review this reconciled document | Stakeholder |
| 2 | Confirm MVP scope (P0 only) | Stakeholder |
| 3 | Confirm budget (₹91,800 or ₹246,800) | Stakeholder |
| 4 | Confirm platform scope (Android/iOS) | Stakeholder |
| 5 | Confirm backend architecture | Stakeholder + Tech |
| 6 | Begin Phase 1 development | Team |

---

# 11. Conclusion

| Item | Status |
|------|--------|
| Scope Reconciliation | Complete |
| Feature Prioritization | Complete |
| Timeline | Defined (3 phases) |
| Budget | Defined (3 phases) |
| Team | Defined |
| Backend Architecture | **[REQUIRES CONFIRMATION]** |
| Platform Scope | **[REQUIRES CONFIRMATION]** |

**Decision Required**: Approve Phase 1 only (₹91,800) or Phase 1+2 (₹246,800)?

---

# Appendix: Change Summary

## Critical Changes Made

1. **Scope reconciliation**: Aligned Feature List PDF with Project Proposal
2. **Feature prioritization**: Classified all features as P0/P1/P2
3. **Timeline revision**: Expanded from 2 weeks to 3 phases (6 months)
4. **Budget revision**: Expanded from ₹91,800 to ₹456,800 (3 phases)
5. **Platform scope**: Marked iOS and Web as requiring confirmation
6. **Backend architecture**: Marked as requiring confirmation

## Items Requiring Stakeholder Confirmation

1. **MVP Scope**: P0 only or P0+P1?
2. **Budget**: ₹91,800 (Phase 1) or ₹246,800 (Phase 1+2)?
3. **Platform**: Android only or Android+iOS?
4. **Backend**: Firebase, AWS, or Hybrid?
5. **Ticketing**: Basic or Marketplace?

## Risks Identified

1. **Scope creep** — High probability, high impact
2. **Feature list expansion** — High probability, medium impact
3. **Backend delays** — Medium probability, high impact
4. **Timeline overrun** — Medium probability, high impact

---

**Document End**
