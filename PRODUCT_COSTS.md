# VELTRIX SPORTS
## Product Launch & Scaling Costs

---

**Date**: August 29, 2026
**Purpose**: Production & Scaling Budget

---

# 1. ONE-TIME COSTS (Launch)

## 1.1 App Store Fees

| Store | Cost | Notes |
|-------|------|-------|
| Google Play Developer | ₹18,000 | One-time, lifetime |
| Apple Developer | ₹7,500 | Annual renewal |
| **Total** | **₹25,500** | |

## 1.2 Domain & SSL

| Item | Cost | Duration |
|------|------|----------|
| Domain (.com) | ₹800 | 1 year |
| SSL Certificate | ₹0 | Free (Let's Encrypt) |
| **Total** | **₹800** | |

## 1.3 Business Registration

| Item | Cost |
|------|------|
| GST Registration | ₹0 (Free) |
| MSME Registration | ₹0 (Free) |
| Trademark (Optional) | ₹5,000 |
| **Total** | **₹5,000** | |

---

# 2. MONTHLY COSTS (Production)

## 2.1 Infrastructure (AWS)

| Service | Specification | Monthly Cost |
|---------|---------------|--------------|
| EC2 (Compute) | t3.small | ₹1,400 |
| RDS (Database) | db.t3.small, 20GB | ₹2,800 |
| S3 (Storage) | 10GB | ₹200 |
| CloudFront (CDN) | 100GB transfer | ₹800 |
| Route 53 (DNS) | Hosted zone | ₹100 |
| **Total** | | **₹5,300** |

### Scaling Costs

| Users | Infrastructure | Monthly Cost |
|-------|----------------|--------------|
| 0-1,000 | t3.small | ₹5,300 |
| 1,000-5,000 | t3.medium | ₹12,000 |
| 5,000-10,000 | t3.large + Read Replica | ₹25,000 |
| 10,000-50,000 | m5.large + Multi-AZ | ₹60,000 |
| 50,000+ | Cluster setup | ₹1,50,000+ |

## 2.2 Third-Party Services

| Service | Cost/Month | Notes |
|---------|------------|-------|
| Razorpay | 2% of transactions | Pay per use |
| Firebase | ₹0 | Free tier (1K notifications/day) |
| SendGrid (Email) | ₹0 | Free tier (100 emails/day) |
| Twilio (SMS) | ₹1,500 | ~500 OTPs/month |
| **Total** | **~₹1,500 + 2%** | |

## 2.3 Monitoring & Analytics

| Service | Cost/Month |
|---------|------------|
| Firebase Analytics | ₹0 |
| Firebase Crashlytics | ₹0 |
| Sentry (Error Tracking) | ₹0 |
| Uptime Robot | ₹0 |
| **Total** | **₹0** | |

---

# 3. TOTAL MONTHLY COST

## Phase 1: Launch (0-1,000 users)

| Category | Cost |
|----------|------|
| Infrastructure | ₹5,300 |
| Third-party | ₹1,500 |
| Domain/SSL | ₹100 |
| **Total** | **₹6,900/month** |

## Phase 2: Growth (1,000-5,000 users)

| Category | Cost |
|----------|------|
| Infrastructure | ₹12,000 |
| Third-party | ₹5,000 |
| Support (1 person) | ₹15,000 |
| Marketing | ₹20,000 |
| **Total** | **₹52,000/month** |

## Phase 3: Scale (5,000-10,000 users)

| Category | Cost |
|----------|------|
| Infrastructure | ₹25,000 |
| Third-party | ₹15,000 |
| Support (2 people) | ₹30,000 |
| Marketing | ₹50,000 |
| **Total** | **₹1,20,000/month** |

## Phase 4: Enterprise (10,000+ users)

| Category | Cost |
|----------|------|
| Infrastructure | ₹60,000+ |
| Third-party | ₹30,000 |
| Support (5 people) | ₹75,000 |
| Marketing | ₹1,00,000 |
| **Total** | **₹2,65,000+/month** |

---

# 4. REVENUE MODEL

## 4.1 Revenue Streams

| Stream | Pricing | Revenue/User |
|--------|---------|--------------|
| Event Registration | 5-10% commission | ₹50-200 |
| Ticket Sales | 10-15% commission | ₹100-500 |
| Premium Plans | ₹499-999/month | ₹499-999 |
| Ads (Future) | CPM | ₹10-50 |

## 4.2 Break-Even Analysis

| Users | Revenue Needed | Users Needed |
|-------|----------------|--------------|
| Phase 1 | ₹6,900 | 50 registrations |
| Phase 2 | ₹52,000 | 400 registrations |
| Phase 3 | ₹1,20,000 | 800 registrations |
| Phase 4 | ₹2,65,000 | 1,500 registrations |

---

# 5. SCALING PLAN

## Phase 1: MVP (Month 1-2)
- Launch with basic features
- 0-1,000 users
- ₹6,900/month
- Focus: Product-market fit

## Phase 2: Growth (Month 3-6)
- Add more features
- 1,000-5,000 users
- ₹52,000/month
- Focus: User acquisition

## Phase 3: Scale (Month 7-12)
- Optimize performance
- 5,000-10,000 users
- ₹1,20,000/month
- Focus: Retention & revenue

## Phase 4: Enterprise (Year 2+)
- Enterprise features
- 10,000+ users
- ₹2,65,000+/month
- Focus: Market leadership

---

# 6. BUDGET SUMMARY

## One-Time Costs

| Item | Cost |
|------|------|
| App Store Fees | ₹25,500 |
| Domain | ₹800 |
| Business Registration | ₹5,000 |
| **Total One-Time** | **₹31,300** |

## Monthly Costs (Start)

| Item | Cost |
|------|------|
| Infrastructure | ₹5,300 |
| Third-party | ₹1,500 |
| **Total Monthly** | **₹6,900** |

## Year 1 Total

| Phase | Months | Cost |
|-------|--------|------|
| One-Time | - | ₹31,300 |
| Phase 1 | 2 | ₹13,800 |
| Phase 2 | 4 | ₹2,08,000 |
| Phase 3 | 6 | ₹7,20,000 |
| **Total Year 1** | | **₹9,73,100** |

---

# 7. COST OPTIMIZATION

## Free Tier Usage
- AWS Free Tier (12 months): Save ₹63,600
- Firebase Free Tier: Save ₹0
- Free SSL: Save ₹5,000/year

## Total Savings
- Year 1 savings: ~₹70,000
- Actual Year 1 cost: ~₹9,00,000

---

# 8. INVESTMENT REQUIRED

## Minimum Viable Product
| Item | Amount |
|------|--------|
| One-time costs | ₹31,300 |
| 3 months runway | ₹20,700 |
| **Total** | **₹52,000** |

## 12 Months Operations
| Item | Amount |
|------|--------|
| One-time costs | ₹31,300 |
| 12 months operations | ₹82,800 |
| Buffer (20%) | ₹22,800 |
| **Total** | **₹1,36,900** |

---

**Document Version**: 1.0
**Date**: August 29, 2026
