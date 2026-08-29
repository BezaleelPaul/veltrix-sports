# VELTRIX SPORTS - API DOCUMENTATION
## Complete API Reference

---

# BASE CONFIGURATION

```
Base URL: https://api.veltrixsports.com/v1
Protocol: HTTPS
Format: JSON
Authentication: Bearer Token (JWT)
Timeout: 30 seconds
Rate Limit: 100 requests/minute
```

---

# AUTHENTICATION

## Headers

```json
{
  "Content-Type": "application/json",
  "Accept": "application/json",
  "Authorization": "Bearer <token>",
  "X-Device-Id": "<device_id>",
  "X-App-Version": "<version>",
  "X-Platform": "<android|ios|web>"
}
```

---

# ENDPOINTS

## 1. AUTHENTICATION

### 1.1 Register User

```
POST /auth/register
```

**Request:**
```json
{
  "email": "user@email.com",
  "password": "SecurePass123!",
  "name": "John Doe",
  "phone": "+919876543210",
  "role": "athlete"
}
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "user": {
      "id": "uuid-123",
      "email": "user@email.com",
      "name": "John Doe",
      "phone": "+919876543210",
      "role": "athlete",
      "createdAt": "2024-01-15T10:00:00Z"
    },
    "token": "eyJhbGciOiJIUzI1NiIs...",
    "refreshToken": "eyJhbGciOiJIUzI1NiIs..."
  }
}
```

**Error (400):**
```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Email already exists"
  }
}
```

---

### 1.2 Login

```
POST /auth/login
```

**Request:**
```json
{
  "email": "user@email.com",
  "password": "SecurePass123!"
}
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "user": {
      "id": "uuid-123",
      "email": "user@email.com",
      "name": "John Doe",
      "role": "athlete"
    },
    "token": "eyJhbGciOiJIUzI1NiIs...",
    "refreshToken": "eyJhbGciOiJIUzI1NiIs..."
  }
}
```

---

### 1.3 Send OTP

```
POST /auth/otp/send
```

**Request:**
```json
{
  "phone": "+919876543210"
}
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "expiresIn": 300,
    "message": "OTP sent successfully"
  }
}
```

---

### 1.4 Verify OTP

```
POST /auth/otp/verify
```

**Request:**
```json
{
  "phone": "+919876543210",
  "otp": "123456"
}
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "verified": true,
    "token": "eyJhbGciOiJIUzI1NiIs..."
  }
}
```

---

### 1.5 Refresh Token

```
POST /auth/refresh
```

**Request:**
```json
{
  "refreshToken": "eyJhbGciOiJIUzI1NiIs..."
}
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "token": "eyJhbGciOiJIUzI1NiIs...",
    "refreshToken": "eyJhbGciOiJIUzI1NiIs..."
  }
}
```

---

### 1.6 Forgot Password

```
POST /auth/forgot-password
```

**Request:**
```json
{
  "email": "user@email.com"
}
```

**Response (200):**
```json
{
  "success": true,
  "message": "Password reset email sent"
}
```

---

### 1.7 Logout

```
POST /auth/logout
```

**Headers:** `Authorization: Bearer <token>`

**Response (200):**
```json
{
  "success": true,
  "message": "Logged out successfully"
}
```

---

## 2. USER PROFILE

### 2.1 Get Profile

```
GET /users/profile
```

**Headers:** `Authorization: Bearer <token>`

**Response (200):**
```json
{
  "success": true,
  "data": {
    "id": "uuid-123",
    "email": "user@email.com",
    "name": "John Doe",
    "phone": "+919876543210",
    "role": "athlete",
    "avatar": "https://cdn.veltrix.com/avatars/123.jpg",
    "dateOfBirth": "1995-06-15",
    "gender": "male",
    "height": 175,
    "weight": 70,
    "fitnessLevel": "intermediate",
    "goals": ["marathon", "weight_loss"],
    "createdAt": "2024-01-15T10:00:00Z"
  }
}
```

---

### 2.2 Update Profile

```
PUT /users/profile
```

**Headers:** `Authorization: Bearer <token>`

**Request:**
```json
{
  "name": "John Doe",
  "phone": "+919876543210",
  "dateOfBirth": "1995-06-15",
  "gender": "male",
  "height": 175,
  "weight": 70,
  "fitnessLevel": "intermediate",
  "goals": ["marathon", "weight_loss"]
}
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "id": "uuid-123",
    "name": "John Doe",
    "updatedAt": "2024-01-20T10:00:00Z"
  }
}
```

---

### 2.3 Upload Avatar

```
POST /users/avatar
```

**Headers:**
- `Authorization: Bearer <token>`
- `Content-Type: multipart/form-data`

**Request:**
```
file: <image_file>
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "avatar": "https://cdn.veltrix.com/avatars/123.jpg"
  }
}
```

---

## 3. TRAINING PLANS

### 3.1 Get Plans

```
GET /plans
```

**Headers:** `Authorization: Bearer <token>`

**Query Parameters:**
- `status` - active, completed, all
- `sport` - running, cycling, triathlon
- `page` - Page number
- `limit` - Items per page

**Response (200):**
```json
{
  "success": true,
  "data": {
    "plans": [
      {
        "id": "plan-123",
        "title": "Marathon Training Plan",
        "sport": "running",
        "duration": 12,
        "distance": 42.2,
        "startDate": "2024-01-15",
        "endDate": "2024-04-08",
        "progress": 75,
        "status": "active",
        "currentWeek": 9,
        "totalWeeks": 12
      }
    ],
    "pagination": {
      "page": 1,
      "limit": 10,
      "total": 3,
      "totalPages": 1
    }
  }
}
```

---

### 3.2 Get Plan Detail

```
GET /plans/{planId}
```

**Headers:** `Authorization: Bearer <token>`

**Response (200):**
```json
{
  "success": true,
  "data": {
    "id": "plan-123",
    "title": "Marathon Training Plan",
    "description": "12-week marathon training program",
    "sport": "running",
    "level": "intermediate",
    "duration": 12,
    "distance": 42.2,
    "startDate": "2024-01-15",
    "endDate": "2024-04-08",
    "progress": 75,
    "status": "active",
    "weeklySchedule": [
      {
        "week": 1,
        "title": "Base Building",
        "sessions": [
          {
            "id": "session-1",
            "day": "monday",
            "type": "easy_run",
            "title": "Easy Run",
            "duration": 30,
            "distance": 5,
            "targetPace": "6:00",
            "targetHR": 140,
            "tss": 40
          }
        ]
      }
    ],
    "stats": {
      "totalDistance": 285,
      "totalDuration": 42,
      "avgPace": "5:45",
      "avgHR": 155,
      "completedSessions": 45,
      "totalSessions": 60
    }
  }
}
```

---

### 3.3 Create Plan (AI Generation)

```
POST /plans/generate
```

**Headers:** `Authorization: Bearer <token>`

**Request:**
```json
{
  "sport": "running",
  "goal": "marathon",
  "distance": 42.2,
  "targetTime": "3:30:00",
  "currentFitness": "intermediate",
  "weeklyAvailability": 5,
  "startDate": "2024-02-01",
  "preferences": {
    "includeSpeedWork": true,
    "includeLongRuns": true,
    "restDay": "wednesday"
  }
}
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "plan": {
      "id": "plan-456",
      "title": "Custom Marathon Plan",
      "duration": 16,
      "weeks": [...]
    },
    "message": "Plan generated successfully"
  }
}
```

---

### 3.4 Update Plan

```
PUT /plans/{planId}
```

**Headers:** `Authorization: Bearer <token>`

**Request:**
```json
{
  "startDate": "2024-02-15",
  "weeklySchedule": [
    {
      "week": 1,
      "sessions": [...]
    }
  ]
}
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "id": "plan-123",
    "updatedAt": "2024-01-20T10:00:00Z"
  }
}
```

---

### 3.5 Delete Plan

```
DELETE /plans/{planId}
```

**Headers:** `Authorization: Bearer <token>`

**Response (200):**
```json
{
  "success": true,
  "message": "Plan deleted successfully"
}
```

---

## 4. SESSIONS

### 4.1 Get Sessions

```
GET /plans/{planId}/sessions
```

**Headers:** `Authorization: Bearer <token>`

**Query Parameters:**
- `week` - Week number
- `status` - planned, completed, skipped

**Response (200):**
```json
{
  "success": true,
  "data": {
    "sessions": [
      {
        "id": "session-123",
        "planId": "plan-123",
        "title": "Tempo Run",
        "type": "tempo",
        "day": "thursday",
        "date": "2024-01-18",
        "duration": 45,
        "distance": 8,
        "targetPace": "5:30",
        "targetHR": 165,
        "tss": 80,
        "status": "planned",
        "instructions": "Warm up 10 min, then 30 min at tempo pace, cool down 5 min"
      }
    ]
  }
}
```

---

### 4.2 Get Session Detail

```
GET /sessions/{sessionId}
```

**Headers:** `Authorization: Bearer <token>`

**Response (200):**
```json
{
  "success": true,
  "data": {
    "id": "session-123",
    "title": "Tempo Run",
    "type": "tempo",
    "date": "2024-01-18",
    "duration": 45,
    "distance": 8,
    "targetPace": "5:30",
    "targetHR": 165,
    "tss": 80,
    "instructions": "Warm up 10 min, then 30 min at tempo pace, cool down 5 min",
    "warmup": {
      "duration": 10,
      "instructions": "Easy pace, gradually increase effort"
    },
    "main": {
      "duration": 30,
      "instructions": "Maintain 5:30/km pace",
      "intervals": []
    },
    "cooldown": {
      "duration": 5,
      "instructions": "Easy pace, stretch after"
    }
  }
}
```

---

### 4.3 Complete Session

```
POST /sessions/{sessionId}/complete
```

**Headers:** `Authorization: Bearer <token>`

**Request:**
```json
{
  "actualDuration": 42,
  "actualDistance": 8.2,
  "actualPace": "5:07",
  "avgHR": 168,
  "maxHR": 182,
  "notes": "Felt strong today, negative split",
  "rating": 4,
  "weather": {
    "temperature": 22,
    "condition": "sunny",
    "wind": 10
  },
  "gpsData": {
    "points": [
      {"lat": 19.0760, "lng": 72.8777, "time": 0},
      {"lat": 19.0770, "lng": 72.8787, "time": 60}
    ]
  }
}
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "id": "session-123",
    "status": "completed",
    "completedAt": "2024-01-18T07:30:00Z",
    "tss": 85,
    "trainingEffect": {
      "aerobic": 3.8,
      "anaerobic": 2.1
    }
  }
}
```

---

### 4.4 Skip Session

```
POST /sessions/{sessionId}/skip
```

**Headers:** `Authorization: Bearer <token>`

**Request:**
```json
{
  "reason": "injury",
  "notes": "Knee pain, taking rest"
}
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "id": "session-123",
    "status": "skipped",
    "skippedAt": "2024-01-18T10:00:00Z"
  }
}
```

---

## 5. PROGRESS

### 5.1 Get Progress Overview

```
GET /progress
```

**Headers:** `Authorization: Bearer <token>`

**Query Parameters:**
- `period` - week, month, year, all

**Response (200):**
```json
{
  "success": true,
  "data": {
    "summary": {
      "totalDistance": 285,
      "totalDuration": 42,
      "totalSessions": 45,
      "avgPace": "5:45",
      "avgHR": 155,
      "caloriesBurned": 18500,
      "personalBests": {
        "5K": {"time": "22:30", "date": "2024-01-10"},
        "10K": {"time": "47:15", "date": "2024-01-20"},
        "halfMarathon": {"time": "1:45:00", "date": "2024-01-25"}
      }
    },
    "weeklyData": [
      {
        "week": "2024-W03",
        "distance": 45,
        "duration": 6.5,
        "sessions": 5,
        "tss": 350
      }
    ],
    "trainingLoad": {
      "ctl": 75,
      "atl": 85,
      "tsb": -10,
      "fitness": "good",
      "fatigue": "high",
      "form": "overloaded"
    }
  }
}
```

---

### 5.2 Log Progress

```
POST /progress/log
```

**Headers:** `Authorization: Bearer <token>`

**Request:**
```json
{
  "type": "weight",
  "value": 69.5,
  "unit": "kg",
  "date": "2024-01-20",
  "notes": "Morning weigh-in"
}
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "id": "progress-123",
    "type": "weight",
    "value": 69.5,
    "loggedAt": "2024-01-20T07:00:00Z"
  }
}
```

---

### 5.3 Get Analytics

```
GET /progress/analytics
```

**Headers:** `Authorization: Bearer <token>`

**Query Parameters:**
- `metric` - distance, duration, pace, hr, tss
- `period` - week, month, year
- `sport` - running, cycling, all

**Response (200):**
```json
{
  "success": true,
  "data": {
    "metric": "distance",
    "period": "month",
    "data": [
      {"date": "2024-01-01", "value": 10},
      {"date": "2024-01-08", "value": 15},
      {"date": "2024-01-15", "value": 12},
      {"date": "2024-01-22", "value": 18}
    ],
    "statistics": {
      "total": 55,
      "average": 13.75,
      "max": 18,
      "min": 10,
      "trend": "increasing"
    }
  }
}
```

---

## 6. EVENTS

### 6.1 Get Events

```
GET /events
```

**Headers:** `Authorization: Bearer <token>` (optional)

**Query Parameters:**
- `sport` - running, cycling, triathlon
- `city` - Mumbai, Pune, etc.
- `date` - upcoming, past, specific date
- `distance` - 5k, 10k, half, full, century
- `page` - Page number
- `limit` - Items per page
- `search` - Search term

**Response (200):**
```json
{
  "success": true,
  "data": {
    "events": [
      {
        "id": "event-123",
        "title": "Mumbai Marathon 2024",
        "sport": "running",
        "date": "2024-02-15",
        "city": "Mumbai",
        "state": "Maharashtra",
        "country": "India",
        "image": "https://cdn.veltrix.com/events/123.jpg",
        "categories": [
          {
            "id": "cat-1",
            "name": "Full Marathon",
            "distance": 42.2,
            "price": 1500,
            "spotsLeft": 500
          }
        ],
        "totalRegistrations": 9500,
        "isFeatured": true
      }
    ],
    "pagination": {
      "page": 1,
      "limit": 10,
      "total": 50,
      "totalPages": 5
    }
  }
}
```

---

### 6.2 Get Event Detail

```
GET /events/{eventId}
```

**Headers:** `Authorization: Bearer <token>` (optional)

**Response (200):**
```json
{
  "success": true,
  "data": {
    "id": "event-123",
    "title": "Mumbai Marathon 2024",
    "description": "India's largest marathon...",
    "sport": "running",
    "date": "2024-02-15",
    "time": "05:00",
    "city": "Mumbai",
    "state": "Maharashtra",
    "country": "India",
    "venue": {
      "name": "Marine Drive",
      "address": "Marine Drive, Mumbai",
      "lat": 19.0760,
      "lng": 72.8777
    },
    "images": [
      "https://cdn.veltrix.com/events/123-1.jpg",
      "https://cdn.veltrix.com/events/123-2.jpg"
    ],
    "categories": [...],
    "includes": [
      "BIB Number",
      "Timing Chip",
      "Finisher Medal",
      "T-Shirt",
      "Hydration Stations",
      "Medical Support",
      "E-Certificate"
    ],
    "sponsors": [...],
    "organizer": {
      "id": "org-123",
      "name": "Mumbai Road Runners",
      "logo": "https://cdn.veltrix.com/organizers/123.jpg"
    },
    "rules": [...],
    "faq": [...],
    "contact": {
      "email": "info@mumbaimarathon.com",
      "phone": "+912212345678"
    }
  }
}
```

---

### 6.3 Create Event (Organizer)

```
POST /events
```

**Headers:** `Authorization: Bearer <token>` (organizer role required)

**Request:**
```json
{
  "title": "Pune 10K Run",
  "description": "Annual 10K run in Pune",
  "sport": "running",
  "date": "2024-03-01",
  "time": "06:00",
  "city": "Pune",
  "state": "Maharashtra",
  "venue": {
    "name": "Shivaji Nagar Ground",
    "address": "Shivaji Nagar, Pune",
    "lat": 18.5362,
    "lng": 73.8530
  },
  "categories": [
    {
      "name": "10K",
      "distance": 10,
      "price": 800,
      "maxParticipants": 2000
    }
  ],
  "registrationDeadline": "2024-02-25"
}
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "id": "event-456",
    "message": "Event created successfully"
  }
}
```

---

### 6.4 Register for Event

```
POST /events/{eventId}/register
```

**Headers:** `Authorization: Bearer <token>`

**Request:**
```json
{
  "categoryId": "cat-1",
  "personalInfo": {
    "fullName": "John Doe",
    "email": "john@email.com",
    "phone": "+919876543210",
    "dateOfBirth": "1995-06-15",
    "gender": "male"
  },
  "emergencyContact": {
    "name": "Jane Doe",
    "phone": "+919876543211",
    "relation": "spouse"
  },
  "medicalInfo": {
    "bloodGroup": "O+",
    "conditions": [],
    "medications": []
  },
  "tshirtSize": "L"
}
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "registrationId": "reg-123",
    "bibNumber": "MUM42-1234",
    "status": "confirmed",
    "amount": 1500
  }
}
```

---

### 6.5 Get My Registrations

```
GET /events/registrations
```

**Headers:** `Authorization: Bearer <token>`

**Response (200):**
```json
{
  "success": true,
  "data": {
    "registrations": [
      {
        "id": "reg-123",
        "eventId": "event-123",
        "eventTitle": "Mumbai Marathon 2024",
        "eventDate": "2024-02-15",
        "category": "Full Marathon",
        "bibNumber": "MUM42-1234",
        "status": "confirmed",
        "amount": 1500,
        "paidAt": "2024-01-20T10:00:00Z"
      }
    ]
  }
}
```

---

## 7. TICKETING

### 7.1 Get Marketplace Events

```
GET /marketplace/events
```

**Query Parameters:**
- `city` - Filter by city
- `sport` - Filter by sport
- `date` - Filter by date range
- `price` - Filter by price range
- `search` - Search term
- `sort` - date, price, popularity
- `page` - Page number
- `limit` - Items per page

**Response (200):**
```json
{
  "success": true,
  "data": {
    "events": [...],
    "filters": {
      "cities": ["Mumbai", "Pune", "Bangalore"],
      "sports": ["running", "cycling"],
      "priceRange": {"min": 500, "max": 5000}
    },
    "pagination": {...}
  }
}
```

---

### 7.2 Purchase Ticket

```
POST /tickets/purchase
```

**Headers:** `Authorization: Bearer <token>`

**Request:**
```json
{
  "eventId": "event-123",
  "categoryId": "cat-1",
  "quantity": 1,
  "promoCode": "EARLYBIRD",
  "paymentMethod": "razorpay",
  "paymentId": "pay_1234567890"
}
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "ticketId": "ticket-123",
    "orderId": "order-123",
    "status": "confirmed",
    "qrCode": "https://cdn.veltrix.com/qr/ticket-123.png",
    "amount": 1350,
    "discount": 150
  }
}
```

---

### 7.3 Get Ticket

```
GET /tickets/{ticketId}
```

**Headers:** `Authorization: Bearer <token>`

**Response (200):**
```json
{
  "success": true,
  "data": {
    "id": "ticket-123",
    "eventTitle": "Mumbai Marathon 2024",
    "eventDate": "2024-02-15",
    "category": "Full Marathon",
    "bibNumber": "MUM42-1234",
    "qrCode": "https://cdn.veltrix.com/qr/ticket-123.png",
    "status": "confirmed",
    "holder": {
      "name": "John Doe",
      "email": "john@email.com"
    }
  }
}
```

---

### 7.4 Check-in

```
POST /checkin/{ticketId}
```

**Headers:** `Authorization: Bearer <token>` (organizer role required)

**Request:**
```json
{
  "checkedInBy": "org-user-123",
  "location": {
    "lat": 19.0760,
    "lng": 72.8777
  }
}
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "checkedIn": true,
    "checkedInAt": "2024-02-15T04:30:00Z"
  }
}
```

---

### 7.5 Add Review

```
POST /reviews
```

**Headers:** `Authorization: Bearer <token>`

**Request:**
```json
{
  "eventId": "event-123",
  "rating": 5,
  "title": "Great event!",
  "comment": "Well organized, great route, amazing atmosphere",
  "images": ["https://cdn.veltrix.com/reviews/123-1.jpg"]
}
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "reviewId": "review-123",
    "rating": 5,
    "createdAt": "2024-02-16T10:00:00Z"
  }
}
```

---

## 8. DEVICES

### 8.1 Connect Device

```
POST /devices/connect
```

**Headers:** `Authorization: Bearer <token>`

**Request:**
```json
{
  "provider": "garmin",
  "accessToken": "garmin_access_token_123",
  "refreshToken": "garmin_refresh_token_123"
}
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "deviceId": "device-123",
    "provider": "garmin",
    "status": "connected",
    "connectedAt": "2024-01-20T10:00:00Z"
  }
}
```

---

### 8.2 Get Connected Devices

```
GET /devices
```

**Headers:** `Authorization: Bearer <token>`

**Response (200):**
```json
{
  "success": true,
  "data": {
    "devices": [
      {
        "id": "device-123",
        "provider": "garmin",
        "name": "Garmin Forerunner 245",
        "status": "connected",
        "lastSync": "2024-01-20T09:30:00Z",
        "syncedActivities": 150
      }
    ]
  }
}
```

---

### 8.3 Sync Device

```
POST /devices/{deviceId}/sync
```

**Headers:** `Authorization: Bearer <token>`

**Response (200):**
```json
{
  "success": true,
  "data": {
    "synced": true,
    "activitiesSynced": 5,
    "lastSync": "2024-01-20T10:00:00Z"
  }
}
```

---

### 8.4 Disconnect Device

```
DELETE /devices/{deviceId}
```

**Headers:** `Authorization: Bearer <token>`

**Response (200):**
```json
{
  "success": true,
  "message": "Device disconnected"
}
```

---

## 9. WEATHER & TERRAIN

### 9.1 Get Weather

```
GET /weather/{location}
```

**Query Parameters:**
- `lat` - Latitude
- `lng` - Longitude
- `date` - Date (optional, default today)

**Response (200):**
```json
{
  "success": true,
  "data": {
    "location": "Mumbai",
    "date": "2024-01-20",
    "current": {
      "temperature": 24,
      "feelsLike": 26,
      "humidity": 65,
      "windSpeed": 10,
      "windDirection": "NW",
      "condition": "Partly Cloudy",
      "uvIndex": 6
    },
    "forecast": [...]
  }
}
```

---

### 9.2 Get Terrain

```
GET /terrain/{location}
```

**Query Parameters:**
- `lat` - Latitude
- `lng` - Longitude
- `radius` - Radius in km (default 10)

**Response (200):**
```json
{
  "success": true,
  "data": {
    "location": "Mumbai",
    "terrain": {
      "elevation": 14,
      "elevationGain": 50,
      "elevationLoss": 45,
      "surface": "road",
      "difficulty": "easy",
      "popularRoutes": [
        {
          "name": "Marine Drive Loop",
          "distance": 5.2,
          "elevationGain": 10,
          "difficulty": "easy",
          "rating": 4.5
        }
      ]
    }
  }
}
```

---

## 10. PAYMENTS

### 10.1 Create Payment Order

```
POST /payments/create
```

**Headers:** `Authorization: Bearer <token>`

**Request:**
```json
{
  "amount": 1500,
  "currency": "INR",
  "eventId": "event-123",
  "categoryId": "cat-1"
}
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "orderId": "order_1234567890",
    "amount": 1500,
    "currency": "INR",
    "razorpayKeyId": "rzp_test_1234567890"
  }
}
```

---

### 10.2 Verify Payment

```
POST /payments/verify
```

**Headers:** `Authorization: Bearer <token>`

**Request:**
```json
{
  "orderId": "order_1234567890",
  "paymentId": "pay_1234567890",
  "signature": "signature_1234567890"
}
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "verified": true,
    "status": "captured",
    "amount": 1500
  }
}
```

---

### 10.3 Get Payment History

```
GET /payments
```

**Headers:** `Authorization: Bearer <token>`

**Query Parameters:**
- `type` - event, subscription, refund
- `status` - success, pending, failed
- `page` - Page number
- `limit` - Items per page

**Response (200):**
```json
{
  "success": true,
  "data": {
    "payments": [
      {
        "id": "pay-123",
        "orderId": "order-123",
        "amount": 1500,
        "currency": "INR",
        "status": "captured",
        "description": "Mumbai Marathon 2024",
        "createdAt": "2024-01-20T10:00:00Z"
      }
    ],
    "pagination": {...}
  }
}
```

---

## 11. NOTIFICATIONS

### 11.1 Get Notifications

```
GET /notifications
```

**Headers:** `Authorization: Bearer <token>`

**Query Parameters:**
- `unreadOnly` - true/false
- `page` - Page number
- `limit` - Items per page

**Response (200):**
```json
{
  "success": true,
  "data": {
    "notifications": [
      {
        "id": "notif-123",
        "type": "workout_reminder",
        "title": "Upcoming Workout",
        "message": "You have a Tempo Run scheduled for tomorrow",
        "data": {
          "sessionId": "session-123",
          "date": "2024-01-21"
        },
        "read": false,
        "createdAt": "2024-01-20T18:00:00Z"
      }
    ],
    "unreadCount": 5,
    "pagination": {...}
  }
}
```

---

### 11.2 Mark Notification Read

```
PUT /notifications/{notificationId}/read
```

**Headers:** `Authorization: Bearer <token>`

**Response (200):**
```json
{
  "success": true,
  "data": {
    "read": true
  }
}
```

---

### 11.3 Update FCM Token

```
PUT /notifications/fcm-token
```

**Headers:** `Authorization: Bearer <token>`

**Request:**
```json
{
  "fcmToken": "fcm_token_1234567890",
  "platform": "android"
}
```

**Response (200):**
```json
{
  "success": true,
  "message": "FCM token updated"
}
```

---

## 12. ADMIN

### 12.1 Get Users

```
GET /admin/users
```

**Headers:** `Authorization: Bearer <token>` (admin role required)

**Query Parameters:**
- `role` - athlete, coach, organizer, admin
- `search` - Search term
- `page` - Page number
- `limit` - Items per page

**Response (200):**
```json
{
  "success": true,
  "data": {
    "users": [...],
    "pagination": {...}
  }
}
```

---

### 12.2 Get Analytics

```
GET /admin/analytics
```

**Headers:** `Authorization: Bearer <token>` (admin role required)

**Response (200):**
```json
{
  "success": true,
  "data": {
    "users": {
      "total": 15000,
      "active": 8000,
      "newThisMonth": 1200
    },
    "events": {
      "total": 50,
      "upcoming": 15,
      "registrations": 25000
    },
    "revenue": {
      "total": 5000000,
      "thisMonth": 800000
    }
  }
}
```

---

# ERROR RESPONSES

## Standard Error Format

```json
{
  "success": false,
  "error": {
    "code": "ERROR_CODE",
    "message": "Human readable message",
    "details": {}
  }
}
```

## Error Codes

| Code | HTTP Status | Description |
|------|-------------|-------------|
| VALIDATION_ERROR | 400 | Invalid input |
| UNAUTHORIZED | 401 | Not authenticated |
| FORBIDDEN | 403 | Not authorized |
| NOT_FOUND | 404 | Resource not found |
| CONFLICT | 409 | Resource already exists |
| RATE_LIMITED | 429 | Too many requests |
| SERVER_ERROR | 500 | Internal server error |
| NETWORK_ERROR | 503 | Service unavailable |

---

**Document Version**: 1.0
**Last Updated**: August 29, 2026
