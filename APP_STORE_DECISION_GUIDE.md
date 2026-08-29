# VELTRIX SPORTS
## App Store Decision & Publishing Guide

---

# 1. DO YOU NEED BOTH STORES?

## Quick Answer

| Platform | Store Required |
|----------|----------------|
| Android Users | Google Play Store |
| iOS Users | Apple App Store |
| Web Users | None (direct URL) |

---

# 2. YOUR OPTIONS

## Option A: Android Only (RECOMMENDED FOR MVP)

| Item | Details |
|------|---------|
| Cost | ₹18,000 (one-time) |
| Time | 3-10 days |
| Users | 95% Android in India |
| **Best For** | MVP, Startups |

## Option B: iOS Only

| Item | Details |
|------|---------|
| Cost | ₹7,500/year |
| Time | 10-20 days |
| Users | Premium users |
| **Best For** | Premium market |

## Option C: Both Stores

| Item | Details |
|------|---------|
| Cost | ₹25,500 first year |
| Time | 10-20 days |
| Users | All users |
| **Best For** | Full launch |

---

# 3. RECOMMENDATION

### For 2-Week MVP: Start with Android Only

| Why | Reason |
|-----|--------|
| ✅ Faster | 3-10 days vs 10-20 days |
| ✅ Cheaper | ₹18,000 vs ₹25,500 |
| ✅ More Users | 95% Android in India |
| ✅ Easier | Simpler process |

### Add iOS Later When:
- Product-market fit achieved
- Users request iOS app
- Revenue supports cost

---

# 4. GOOGLE PLAY STORE - STEP BY STEP

## Step 1: Create Developer Account (Day 1)

| # | Action |
|---|--------|
| 1 | Go to https://play.google.com/console |
| 2 | Sign in with Gmail |
| 3 | Click "Create Developer Account" |
| 4 | Pay ₹18,000 (one-time) |
| 5 | Fill developer name: "Veltrix Sports" |
| 6 | Fill email: your@email.com |
| 7 | Fill phone: +91XXXXXXXXXX |
| 8 | Verify email |
| 9 | Wait 24-48 hours for approval |

## Step 2: Create App (Day 2)

| # | Action |
|---|--------|
| 1 | Go to Google Play Console |
| 2 | Click "Create App" |
| 3 | App name: "Veltrix Sports" |
| 4 | Default language: English |
| 5 | App or game: App |
| 6 | Free or paid: Free |
| 7 | Accept declarations |
| 8 | Click "Create App" |

## Step 3: Complete Store Listing (Day 2-3)

| # | Action |
|---|--------|
| 1 | Go to "Store presence" → "Main store listing" |
| 2 | App name: "Veltrix Sports" (max 30 chars) |
| 3 | Short description (max 80 chars) |
| 4 | Full description (max 4000 chars) |
| 5 | Upload app icon (512x512 PNG) |
| 6 | Upload feature graphic (1024x500 PNG) |
| 7 | Upload screenshots (min 2, max 8) |

## Step 4: Content Rating (Day 3)

| # | Action |
|---|--------|
| 1 | Go to "Store presence" → "Content rating" |
| 2 | Fill questionnaire |
| 3 | Get rating (Everyone/Teen/Mature) |
| 4 | Submit for rating |

## Step 5: Pricing & Distribution (Day 3)

| # | Action |
|---|--------|
| 1 | Go to "Store presence" → "Pricing & distribution" |
| 2 | Set price: Free |
| 3 | Select countries |
| 4 | Accept terms |

## Step 6: App Content (Day 3-4)

| # | Action |
|---|--------|
| 1 | Go to "App content" |
| 2 | Add privacy policy URL |
| 3 | Complete app access |
| 4 | Complete ads declaration |
| 5 | Complete data safety |

## Step 7: Upload App (Day 4-5)

| # | Action |
|---|--------|
| 1 | Build AAB file in Android Studio |
| 2 | Go to "Production" → "Create new release" |
| 3 | Upload AAB file |
| 4 | Add release notes |
| 5 | Review and start rollout |

## Step 8: Submit for Review (Day 5)

| # | Action |
|---|--------|
| 1 | Review all sections |
| 2 | Fix any issues |
| 3 | Click "Submit for review" |
| 4 | Wait 1-7 days |
| 5 | App goes live |

---

# 5. APPLE APP STORE - STEP BY STEP

## Step 1: Create Apple ID (Day 1)

| # | Action |
|---|--------|
| 1 | Go to https://appleid.apple.com |
| 2 | Create new Apple ID |
| 3 | Fill email, password |
| 4 | Verify email |
| 5 | Apple ID ready |

## Step 2: Join Developer Program (Day 1-2)

| # | Action |
|---|--------|
| 1 | Go to https://developer.apple.com |
| 2 | Sign in with Apple ID |
| 3 | Click "Join the Apple Developer Program" |
| 4 | Pay ₹7,500/year |
| 5 | Select: Organization |
| 6 | Fill organization details |
| 7 | Wait for verification |

## Step 3: Get D-U-N-S Number (Day 2-14)

| # | Action |
|---|--------|
| 1 | Go to https://developer.apple.com/enroll/duns-lookup/ |
| 2 | Search your company name |
| 3 | If found: Use existing number |
| 4 | If not found: Request new number |
| 5 | Wait 7-14 business days |
| 6 | Get D-U-N-S number via email |

## Step 4: Create App ID (Day 14-15)

| # | Action |
|---|--------|
| 1 | Go to Apple Developer → Certificates, Identifiers & Profiles |
| 2 | Click "+" to create App ID |
| 3 | Select "App IDs" |
| 4 | Description: "Veltrix Sports" |
| 5 | Bundle ID: "com.veltrix.sports" |
| 6 | Enable capabilities |
| 7 | Click "Register" |

## Step 5: Create Certificate (Day 15)

| # | Action |
|---|--------|
| 1 | Open Keychain Access |
| 2 | Request Certificate from Authority |
| 3 | Save CSR file |
| 4 | Go to Apple Developer → Certificates |
| 5 | Click "+" |
| 6 | Select "iOS Distribution" |
| 7 | Upload CSR file |
| 8 | Download certificate |

## Step 6: Create Provisioning Profile (Day 15)

| # | Action |
|---|--------|
| 1 | Go to Apple Developer → Profiles |
| 2 | Click "+" |
| 3 | Select "App Store" |
| 4 | Select App ID |
| 5 | Select certificate |
| 6 | Name: "Veltrix Sports App Store" |
| 7 | Download profile |

## Step 7: App Store Connect Setup (Day 15-16)

| # | Action |
|---|--------|
| 1 | Go to https://appstoreconnect.apple.com |
| 2 | Click "My Apps" |
| 3 | Click "+" → "New App" |
| 4 | Platform: iOS |
| 5 | Name: "Veltrix Sports" |
| 6 | Bundle ID: "com.veltrix.sports" |
| 7 | SKU: "veltrix-sports" |

## Step 8: Complete App Information (Day 16)

| # | Action |
|---|--------|
| 1 | App name (max 30 chars) |
| 2 | Subtitle (max 30 chars) |
| 3 | Description (max 4000 chars) |
| 4 | Keywords (max 100 chars) |
| 5 | Support URL |
| 6 | Privacy Policy URL |
| 7 | Upload app icon (1024x1024) |
| 8 | Upload screenshots |

## Step 9: Pricing & Availability (Day 16)

| # | Action |
|---|--------|
| 1 | Go to "Pricing and Availability" |
| 2 | Set price: Free |
| 3 | Select territories |
| 4 | Save |

## Step 10: Build & Upload (Day 16-17)

| # | Action |
|---|--------|
| 1 | Open project in Xcode |
| 2 | Select "Any iOS Device" |
| 3 | Product → Archive |
| 4 | Validate app |
| 5 | Upload to App Store Connect |

## Step 11: Submit for Review (Day 17)

| # | Action |
|---|--------|
| 1 | Go to "App Store" tab |
| 2 | Click "Submit for Review" |
| 3 | Answer review questions |
| 4 | Submit |
| 5 | Wait 24-48 hours |

## Step 12: App Goes Live (Day 18-19)

| # | Action |
|---|--------|
| 1 | Review approved |
| 2 | App published |
| 3 | Available on App Store |
| 4 | Users can download |

---

# 6. TIMELINE COMPARISON

| Option | Google Play | Apple | Total Time |
|--------|-------------|-------|------------|
| Android Only | 3-10 days | - | 3-10 days |
| iOS Only | - | 10-20 days | 10-20 days |
| Both | 3-10 days | 10-20 days | 10-20 days |

---

# 7. COST COMPARISON

| Option | Google Play | Apple | Total Cost |
|--------|-------------|-------|------------|
| Android Only | ₹18,000 | - | ₹18,000 |
| iOS Only | - | ₹7,500/year | ₹7,500/year |
| Both | ₹18,000 | ₹7,500/year | ₹25,500 first year |

---

# 8. FINAL RECOMMENDATION

## For 2-Week MVP

| Decision | Recommendation |
|----------|----------------|
| **Store** | Google Play Only |
| **Cost** | ₹18,000 |
| **Time** | 3-10 days |
| **Why** | Faster, Cheaper, More Users |

## After MVP

| When | Action |
|------|--------|
| Month 3 | Add iOS if needed |
| Month 6 | Consider both stores |

---

# 9. CHECKLIST

## Android Only (Recommended)
- [ ] Create Google Play Developer Account (₹18,000)
- [ ] Create app listing
- [ ] Upload screenshots
- [ ] Add privacy policy
- [ ] Upload AAB file
- [ ] Submit for review
- [ ] Wait 1-7 days
- [ ] App goes live

## Both Stores
- [ ] Google Play (₹18,000)
- [ ] Apple Developer (₹7,500/year)
- [ ] Get D-U-N-S Number (7-14 days)
- [ ] Create certificates
- [ ] App Store Connect setup
- [ ] Upload via Xcode
- [ ] Submit for review
- [ ] Wait 10-20 days

---

**Document Version**: 1.0
**Date**: August 29, 2026
