# VELTRIX SPORTS - DATABASE SCHEMA
## Complete Database Design

---

# DATABASE OVERVIEW

```
Database: PostgreSQL (AWS RDS)
Version: 14.x
Charset: UTF-8
Collation: en_US.UTF-8
Max Connections: 100
```

---

# TABLES

## 1. USERS

```sql
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20) UNIQUE,
    password_hash VARCHAR(255),
    name VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL DEFAULT 'athlete',
    avatar VARCHAR(500),
    date_of_birth DATE,
    gender VARCHAR(20),
    height DECIMAL(5,2),
    weight DECIMAL(5,2),
    fitness_level VARCHAR(50),
    goals JSONB DEFAULT '[]',
    is_verified BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    last_login_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_phone ON users(phone);
CREATE INDEX idx_users_role ON users(role);
CREATE INDEX idx_users_created_at ON users(created_at);
```

---

## 2. USER_AUTH

```sql
CREATE TABLE user_auth (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    provider VARCHAR(50) NOT NULL,  -- email, phone, google, apple
    provider_user_id VARCHAR(255),
    access_token TEXT,
    refresh_token TEXT,
    expires_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(user_id, provider)
);

CREATE INDEX idx_user_auth_user_id ON user_auth(user_id);
CREATE INDEX idx_user_auth_provider ON user_auth(provider, provider_user_id);
```

---

## 3. OTP

```sql
CREATE TABLE otp (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    phone VARCHAR(20) NOT NULL,
    code VARCHAR(10) NOT NULL,
    expires_at TIMESTAMP WITH TIME ZONE NOT NULL,
    used BOOLEAN DEFAULT FALSE,
    attempts INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_otp_phone ON otp(phone, used, created_at);
```

---

## 4. TRAINING_PLANS

```sql
CREATE TABLE training_plans (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    sport VARCHAR(50) NOT NULL,
    level VARCHAR(50),
    goal VARCHAR(100),
    duration INTEGER NOT NULL,  -- in days
    distance DECIMAL(10,2),
    start_date DATE,
    end_date DATE,
    target_time VARCHAR(20),
    weekly_availability INTEGER,
    is_ai_generated BOOLEAN DEFAULT FALSE,
    template_id UUID,
    status VARCHAR(50) DEFAULT 'draft',  -- draft, active, completed, archived
    progress DECIMAL(5,2) DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_training_plans_user_id ON training_plans(user_id);
CREATE INDEX idx_training_plans_sport ON training_plans(sport);
CREATE INDEX idx_training_plans_status ON training_plans(status);
CREATE INDEX idx_training_plans_created_at ON training_plans(created_at);
```

---

## 5. PLAN_TEMPLATES

```sql
CREATE TABLE plan_templates (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title VARCHAR(255) NOT NULL,
    description TEXT,
    sport VARCHAR(50) NOT NULL,
    level VARCHAR(50) NOT NULL,
    goal VARCHAR(100),
    duration INTEGER NOT NULL,
    distance DECIMAL(10,2),
    weekly_availability INTEGER,
    structure JSONB NOT NULL,  -- weekly schedule structure
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_plan_templates_sport ON plan_templates(sport);
CREATE INDEX idx_plan_templates_level ON plan_templates(level);
CREATE INDEX idx_plan_templates_goal ON plan_templates(goal);
```

---

## 6. PLAN_WEEKS

```sql
CREATE TABLE plan_weeks (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    plan_id UUID NOT NULL REFERENCES training_plans(id) ON DELETE CASCADE,
    week_number INTEGER NOT NULL,
    title VARCHAR(255),
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(plan_id, week_number)
);

CREATE INDEX idx_plan_weeks_plan_id ON plan_weeks(plan_id);
```

---

## 7. PLAN_SESSIONS

```sql
CREATE TABLE plan_sessions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    plan_id UUID NOT NULL REFERENCES training_plans(id) ON DELETE CASCADE,
    week_id UUID NOT NULL REFERENCES plan_weeks(id) ON DELETE CASCADE,
    day VARCHAR(20) NOT NULL,
    session_type VARCHAR(50) NOT NULL,  -- easy_run, tempo, intervals, long_run, rest, cross_train
    title VARCHAR(255) NOT NULL,
    description TEXT,
    duration INTEGER,  -- in minutes
    distance DECIMAL(10,2),  -- in km
    target_pace VARCHAR(20),
    target_hr_min INTEGER,
    target_hr_max INTEGER,
    tss INTEGER,  -- Training Stress Score
    intensity VARCHAR(20),  -- easy, moderate, hard, very_hard
    instructions TEXT,
    warmup JSONB,
    main_structure JSONB,
    cooldown JSONB,
    order_index INTEGER NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_plan_sessions_plan_id ON plan_sessions(plan_id);
CREATE INDEX idx_plan_sessions_week_id ON plan_sessions(week_id);
CREATE INDEX idx_plan_sessions_day ON plan_sessions(day);
```

---

## 8. SESSION_LOGS

```sql
CREATE TABLE session_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    session_id UUID NOT NULL REFERENCES plan_sessions(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    actual_duration INTEGER,  -- in minutes
    actual_distance DECIMAL(10,2),  -- in km
    actual_pace VARCHAR(20),
    avg_hr INTEGER,
    max_hr INTEGER,
    calories_burned INTEGER,
    tss_actual INTEGER,
    elevation_gain DECIMAL(10,2),
    elevation_loss DECIMAL(10,2),
    weather JSONB,
    notes TEXT,
    rating INTEGER CHECK (rating >= 1 AND rating <= 5),
    status VARCHAR(20) DEFAULT 'completed',  -- completed, skipped, missed
    skip_reason VARCHAR(50),
    completed_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_session_logs_session_id ON session_logs(session_id);
CREATE INDEX idx_session_logs_user_id ON session_logs(user_id);
CREATE INDEX idx_session_logs_completed_at ON session_logs(completed_at);
```

---

## 9. GPS_TRACKS

```sql
CREATE TABLE gps_tracks (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    session_log_id UUID NOT NULL REFERENCES session_logs(id) ON DELETE CASCADE,
    points JSONB NOT NULL,  -- [{lat, lng, time, hr, elevation}]
    distance DECIMAL(10,2),
    duration INTEGER,  -- in seconds
    avg_pace VARCHAR(20),
    max_speed DECIMAL(10,2),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_gps_tracks_session_log_id ON gps_tracks(session_log_id);
```

---

## 10. EVENTS

```sql
CREATE TABLE events (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    organizer_id UUID NOT NULL REFERENCES users(id),
    title VARCHAR(255) NOT NULL,
    description TEXT,
    sport VARCHAR(50) NOT NULL,
    event_date DATE NOT NULL,
    event_time TIME,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100),
    country VARCHAR(100) DEFAULT 'India',
    venue_name VARCHAR(255),
    venue_address TEXT,
    venue_lat DECIMAL(10,8),
    venue_lng DECIMAL(11,8),
    images JSONB DEFAULT '[]',
    banner_url VARCHAR(500),
    website_url VARCHAR(500),
    contact_email VARCHAR(255),
    contact_phone VARCHAR(20),
    registration_deadline DATE,
    is_featured BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    status VARCHAR(50) DEFAULT 'draft',  -- draft, published, cancelled, completed
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_events_organizer_id ON events(organizer_id);
CREATE INDEX idx_events_sport ON events(sport);
CREATE INDEX idx_events_event_date ON events(event_date);
CREATE INDEX idx_events_city ON events(city);
CREATE INDEX idx_events_status ON events(status);
CREATE INDEX idx_events_is_featured ON events(is_featured);
```

---

## 11. EVENT_CATEGORIES

```sql
CREATE TABLE event_categories (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    event_id UUID NOT NULL REFERENCES events(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    distance DECIMAL(10,2),
    price DECIMAL(10,2) NOT NULL,
    max_participants INTEGER,
    current_participants INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_event_categories_event_id ON event_categories(event_id);
```

---

## 12. EVENT_REGISTRATIONS

```sql
CREATE TABLE event_registrations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    event_id UUID NOT NULL REFERENCES events(id),
    user_id UUID NOT NULL REFERENCES users(id),
    category_id UUID NOT NULL REFERENCES event_categories(id),
    bib_number VARCHAR(50),
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    date_of_birth DATE,
    gender VARCHAR(20),
    tshirt_size VARCHAR(10),
    emergency_contact_name VARCHAR(255),
    emergency_contact_phone VARCHAR(20),
    emergency_contact_relation VARCHAR(50),
    blood_group VARCHAR(10),
    medical_conditions TEXT,
    medications TEXT,
    status VARCHAR(50) DEFAULT 'pending',  -- pending, confirmed, cancelled, checked_in
    payment_status VARCHAR(50) DEFAULT 'pending',  -- pending, completed, refunded
    payment_id VARCHAR(255),
    amount DECIMAL(10,2),
    discount_amount DECIMAL(10,2) DEFAULT 0,
    promo_code VARCHAR(50),
    checked_in_at TIMESTAMP WITH TIME ZONE,
    cancelled_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_event_registrations_event_id ON event_registrations(event_id);
CREATE INDEX idx_event_registrations_user_id ON event_registrations(user_id);
CREATE INDEX idx_event_registrations_bib_number ON event_registrations(bib_number);
CREATE INDEX idx_event_registrations_status ON event_registrations(status);
```

---

## 13. TICKETS

```sql
CREATE TABLE tickets (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    event_id UUID NOT NULL REFERENCES events(id),
    registration_id UUID NOT NULL REFERENCES event_registrations(id),
    user_id UUID NOT NULL REFERENCES users(id),
    ticket_code VARCHAR(100) UNIQUE NOT NULL,
    qr_code VARCHAR(500),
    status VARCHAR(50) DEFAULT 'active',  -- active, used, cancelled, refunded
    used_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_tickets_event_id ON tickets(event_id);
CREATE INDEX idx_tickets_user_id ON tickets(user_id);
CREATE INDEX idx_tickets_ticket_code ON tickets(ticket_code);
CREATE INDEX idx_tickets_status ON tickets(status);
```

---

## 14. REVIEWS

```sql
CREATE TABLE reviews (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    event_id UUID NOT NULL REFERENCES events(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES users(id),
    rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    title VARCHAR(255),
    comment TEXT,
    images JSONB DEFAULT '[]',
    is_verified BOOLEAN DEFAULT FALSE,  -- true if user attended event
    helpful_count INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_reviews_event_id ON reviews(event_id);
CREATE INDEX idx_reviews_user_id ON reviews(user_id);
CREATE INDEX idx_reviews_rating ON reviews(rating);
CREATE INDEX idx_reviews_created_at ON reviews(created_at);
```

---

## 15. DEVICES

```sql
CREATE TABLE devices (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    provider VARCHAR(50) NOT NULL,  -- garmin, apple_health, strava, google_fit
    device_name VARCHAR(255),
    provider_user_id VARCHAR(255),
    access_token TEXT,
    refresh_token TEXT,
    token_expires_at TIMESTAMP WITH TIME ZONE,
    last_sync_at TIMESTAMP WITH TIME ZONE,
    total_synced_activities INTEGER DEFAULT 0,
    status VARCHAR(50) DEFAULT 'connected',  -- connected, disconnected, error
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_devices_user_id ON devices(user_id);
CREATE INDEX idx_devices_provider ON devices(provider);
CREATE INDEX idx_devices_status ON devices(status);
```

---

## 16. DEVICE_ACTIVITIES

```sql
CREATE TABLE device_activities (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    device_id UUID NOT NULL REFERENCES devices(id) ON DELETE CASCADE,
    provider_activity_id VARCHAR(255) NOT NULL,
    sport VARCHAR(50) NOT NULL,
    title VARCHAR(255),
    start_time TIMESTAMP WITH TIME ZONE,
    end_time TIMESTAMP WITH TIME ZONE,
    duration INTEGER,  -- in seconds
    distance DECIMAL(10,2),  -- in km
    calories INTEGER,
    avg_hr INTEGER,
    max_hr INTEGER,
    avg_pace VARCHAR(20),
    avg_speed DECIMAL(10,2),
    max_speed DECIMAL(10,2),
    elevation_gain DECIMAL(10,2),
    elevation_loss DECIMAL(10,2),
    raw_data JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_device_activities_device_id ON device_activities(device_id);
CREATE INDEX idx_device_activities_provider_activity_id ON device_activities(provider_activity_id);
CREATE INDEX idx_device_activities_start_time ON device_activities(start_time);
```

---

## 17. PROGRESS_LOGS

```sql
CREATE TABLE progress_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    type VARCHAR(50) NOT NULL,  -- weight, body_fat, resting_hr, vo2max, sleep
    value DECIMAL(10,2) NOT NULL,
    unit VARCHAR(20) NOT NULL,
    notes TEXT,
    source VARCHAR(50),  -- manual, device, app
    logged_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_progress_logs_user_id ON progress_logs(user_id);
CREATE INDEX idx_progress_logs_type ON progress_logs(type);
CREATE INDEX idx_progress_logs_logged_at ON progress_logs(logged_at);
```

---

## 18. WEATHER_LOGS

```sql
CREATE TABLE weather_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    session_log_id UUID REFERENCES session_logs(id) ON DELETE CASCADE,
    location_lat DECIMAL(10,8),
    location_lng DECIMAL(11,8),
    temperature DECIMAL(5,2),
    feels_like DECIMAL(5,2),
    humidity INTEGER,
    wind_speed DECIMAL(10,2),
    wind_direction VARCHAR(10),
    condition VARCHAR(50),
    uv_index INTEGER,
    air_quality_index INTEGER,
    fetched_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_weather_logs_session_log_id ON weather_logs(session_log_id);
CREATE INDEX idx_weather_logs_fetched_at ON weather_logs(fetched_at);
```

---

## 19. PAYMENTS

```sql
CREATE TABLE payments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id),
    order_id VARCHAR(255) UNIQUE NOT NULL,
    payment_id VARCHAR(255),
    amount DECIMAL(10,2) NOT NULL,
    currency VARCHAR(10) DEFAULT 'INR',
    status VARCHAR(50) DEFAULT 'pending',  -- pending, captured, failed, refunded
    provider VARCHAR(50) NOT NULL,  -- razorpay
    description TEXT,
    metadata JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_payments_user_id ON payments(user_id);
CREATE INDEX idx_payments_order_id ON payments(order_id);
CREATE INDEX idx_payments_status ON payments(status);
CREATE INDEX idx_payments_created_at ON payments(created_at);
```

---

## 20. NOTIFICATIONS

```sql
CREATE TABLE notifications (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    type VARCHAR(50) NOT NULL,  -- workout_reminder, event_update, payment, system
    title VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    data JSONB,
    is_read BOOLEAN DEFAULT FALSE,
    read_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_notifications_user_id ON notifications(user_id);
CREATE INDEX idx_notifications_type ON notifications(type);
CREATE INDEX idx_notifications_is_read ON notifications(is_read);
CREATE INDEX idx_notifications_created_at ON notifications(created_at);
```

---

## 21. FCM_TOKENS

```sql
CREATE TABLE fcm_tokens (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    token VARCHAR(500) NOT NULL,
    platform VARCHAR(20) NOT NULL,  -- android, ios, web
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_fcm_tokens_user_id ON fcm_tokens(user_id);
CREATE INDEX idx_fcm_tokens_token ON fcm_tokens(token);
CREATE INDEX idx_fcm_tokens_is_active ON fcm_tokens(is_active);
```

---

## 22. PROMO_CODES

```sql
CREATE TABLE promo_codes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    code VARCHAR(50) UNIQUE NOT NULL,
    description TEXT,
    discount_type VARCHAR(20) NOT NULL,  -- percentage, fixed
    discount_value DECIMAL(10,2) NOT NULL,
    min_amount DECIMAL(10,2) DEFAULT 0,
    max_uses INTEGER,
    current_uses INTEGER DEFAULT 0,
    event_id UUID REFERENCES events(id),
    is_active BOOLEAN DEFAULT TRUE,
    starts_at TIMESTAMP WITH TIME ZONE,
    expires_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_promo_codes_code ON promo_codes(code);
CREATE INDEX idx_promo_codes_is_active ON promo_codes(is_active);
CREATE INDEX idx_promo_codes_event_id ON promo_codes(event_id);
```

---

## 23. REVIEWS_HELPFUL

```sql
CREATE TABLE reviews_helpful (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    review_id UUID NOT NULL REFERENCES reviews(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES users(id),
    is_helpful BOOLEAN NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(review_id, user_id)
);

CREATE INDEX idx_reviews_helpful_review_id ON reviews_helpful(review_id);
CREATE INDEX idx_reviews_helpful_user_id ON reviews_helpful(user_id);
```

---

## 24. USER_FITNESS_STATS

```sql
CREATE TABLE user_fitness_stats (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    period VARCHAR(20) NOT NULL,  -- week, month, year
    period_start DATE NOT NULL,
    period_end DATE NOT NULL,
    total_distance DECIMAL(10,2) DEFAULT 0,
    total_duration INTEGER DEFAULT 0,  -- in minutes
    total_sessions INTEGER DEFAULT 0,
    total_calories INTEGER DEFAULT 0,
    total_tss INTEGER DEFAULT 0,
    avg_pace VARCHAR(20),
    avg_hr INTEGER,
    max_distance DECIMAL(10,2),
    max_duration INTEGER,
    max_pace VARCHAR(20),
    min_pace VARCHAR(20),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(user_id, period, period_start)
);

CREATE INDEX idx_user_fitness_stats_user_id ON user_fitness_stats(user_id);
CREATE INDEX idx_user_fitness_stats_period ON user_fitness_stats(period, period_start);
```

---

# RELATIONSHIPS

```
users ──────────┐
    │           │
    ├── user_auth
    ├── otp
    ├── training_plans ──── plan_weeks ──── plan_sessions ──── session_logs ──── gps_tracks
    ├── events ──── event_categories ──── event_registrations ──── tickets
    ├── reviews
    ├── devices ──── device_activities
    ├── progress_logs
    ├── payments
    ├── notifications
    ├── fcm_tokens
    └── user_fitness_stats
```

---

# INDEXES SUMMARY

| Table | Indexes | Purpose |
|-------|---------|---------|
| users | email, phone, role, created_at | User lookups, filtering |
| training_plans | user_id, sport, status, created_at | Plan queries |
| plan_sessions | plan_id, week_id, day | Session lookups |
| session_logs | session_id, user_id, completed_at | Log queries |
| events | organizer_id, sport, event_date, city, status | Event search |
| event_registrations | event_id, user_id, bib_number, status | Registration queries |
| tickets | event_id, user_id, ticket_code, status | Ticket validation |
| devices | user_id, provider, status | Device queries |
| payments | user_id, order_id, status, created_at | Payment queries |
| notifications | user_id, type, is_read, created_at | Notification queries |

---

# DATA TYPES

| Type | Description | Example |
|------|-------------|---------|
| UUID | Unique identifier | gen_random_uuid() |
| VARCHAR(n) | Variable length string | 'Mumbai Marathon' |
| TEXT | Unlimited text | 'Description...' |
| INTEGER | Whole number | 42 |
| DECIMAL(p,s) | Precise decimal | 42.20 |
| BOOLEAN | True/False | true |
| DATE | Date only | '2024-01-15' |
| TIME | Time only | '05:00:00' |
| TIMESTAMP | Date + Time | NOW() |
| JSONB | JSON data | '{"key": "value"}' |

---

# SEED DATA

## Default Admin User

```sql
INSERT INTO users (id, email, phone, name, role, is_verified, is_active)
VALUES (
    gen_random_uuid(),
    'admin@veltrixsports.com',
    '+919876543210',
    'Admin User',
    'admin',
    TRUE,
    TRUE
);
```

## Plan Templates

```sql
INSERT INTO plan_templates (title, description, sport, level, goal, duration, structure)
VALUES
('Beginner Marathon', '16-week marathon plan for beginners', 'running', 'beginner', 'marathon', 112, '{"weeks": 16}'),
('Intermediate Marathon', '12-week marathon plan for intermediates', 'running', 'intermediate', 'marathon', 84, '{"weeks": 12}'),
('Advanced Marathon', '12-week marathon plan for advanced runners', 'running', 'advanced', 'marathon', 84, '{"weeks": 12}'),
('5K Plan', '8-week 5K plan', 'running', 'beginner', '5k', 56, '{"weeks": 8}'),
('10K Plan', '10-week 10K plan', 'running', 'intermediate', '10k', 70, '{"weeks": 10}');
```

---

**Document Version**: 1.0
**Last Updated**: August 29, 2026
