# VELTRIX SPORTS - ANALYTICS & MONITORING
## Complete Analytics Guide

---

# ANALYTICS OVERVIEW

```
Analytics Provider: Firebase Analytics + Custom Backend
Error Tracking: Firebase Crashlytics
Performance Monitoring: Firebase Performance
Real-time Monitoring: Custom Dashboard
```

---

# 1. EVENT TRACKING

## 1.1 User Events

```dart
class AnalyticsEvents {
  // Authentication Events
  static const String userRegistered = 'user_registered';
  static const String userLoggedIn = 'user_logged_in';
  static const String userLoggedOut = 'user_logged_out';
  static const String passwordReset = 'password_reset';
  
  // Training Plan Events
  static const String planCreated = 'plan_created';
  static const String planStarted = 'plan_started';
  static const String planCompleted = 'plan_completed';
  static const String sessionCompleted = 'session_completed';
  static const String sessionSkipped = 'session_skipped';
  
  // Event Registration Events
  static const String eventViewed = 'event_viewed';
  static const String eventRegistered = 'event_registered';
  static const String ticketPurchased = 'ticket_purchased';
  
  // Device Events
  static const String deviceConnected = 'device_connected';
  static const String deviceDisconnected = 'device_disconnected';
  static const String dataSynced = 'data_synced';
  
  // Payment Events
  static const String paymentInitiated = 'payment_initiated';
  static const String paymentCompleted = 'payment_completed';
  static const String paymentFailed = 'payment_failed';
  
  // Navigation Events
  static const String screenViewed = 'screen_viewed';
  static const String featureUsed = 'feature_used';
}
```

## 1.2 Event Parameters

```dart
class EventParameters {
  static Map<String, dynamic> userRegistration({
    required String method,
    required String source,
  }) {
    return {
      'method': method,  // email, phone, google, apple
      'source': source,  // organic, referral, ads
      'timestamp': DateTime.now().toIso8601String(),
    };
  }
  
  static Map<String, dynamic> planCreated({
    required String sport,
    required String level,
    required int duration,
  }) {
    return {
      'sport': sport,
      'level': level,
      'duration_days': duration,
      'timestamp': DateTime.now().toIso8601String(),
    };
  }
  
  static Map<String, dynamic> sessionCompleted({
    required String sessionId,
    required String type,
    required int duration,
    required double distance,
    required int calories,
  }) {
    return {
      'session_id': sessionId,
      'type': type,
      'duration_minutes': duration,
      'distance_km': distance,
      'calories': calories,
      'timestamp': DateTime.now().toIso8601String(),
    };
  }
  
  static Map<String, dynamic> ticketPurchased({
    required String eventId,
    required String category,
    required double amount,
    required String paymentMethod,
  }) {
    return {
      'event_id': eventId,
      'category': category,
      'amount': amount,
      'payment_method': paymentMethod,
      'timestamp': DateTime.now().toIso8601String(),
    };
  }
}
```

## 1.3 Tracking Service

```dart
class AnalyticsService {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  
  static Future<void> logEvent({
    required String name,
    Map<String, dynamic>? parameters,
  }) async {
    await _analytics.logEvent(
      name: name,
      parameters: parameters,
    );
    
    // Also send to custom backend
    await _sendToBackend(name, parameters);
  }
  
  static Future<void> logScreenView(String screenName) async {
    await _analytics.logScreenView(screenName: screenName);
  }
  
  static Future<void> setUserProperties({
    required String userId,
    String? sport,
    String? level,
  }) async {
    await _analytics.setUserId(id: userId);
    if (sport != null) await _analytics.setUserProperty(name: 'preferred_sport', value: sport);
    if (level != null) await _analytics.setUserProperty(name: 'fitness_level', value: level);
  }
  
  static Future<void> _sendToBackend(String eventName, Map<String, dynamic>? params) async {
    try {
      await ApiClient.post('/analytics/events', data: {
        'event': eventName,
        'parameters': params,
        'platform': Platform.operatingSystem,
        'appVersion': await _getAppVersion(),
      });
    } catch (e) {
      // Silently fail - don't block user experience
    }
  }
}
```

---

# 2. CUSTOM DASHBOARD

## 2.1 Dashboard Metrics

```dart
class DashboardMetrics {
  // User Metrics
  static const String totalUsers = 'total_users';
  static const String activeUsers = 'active_users';
  static const String newUsers = 'new_users';
  static const String retentionRate = 'retention_rate';
  
  // Engagement Metrics
  static const String sessionsPerUser = 'sessions_per_user';
  static const String avgSessionDuration = 'avg_session_duration';
  static const String featuresUsed = 'features_used';
  
  // Training Metrics
  static const String plansCreated = 'plans_created';
  static const String plansCompleted = 'plans_completed';
  static const String totalDistance = 'total_distance';
  static const String totalDuration = 'total_duration';
  
  // Event Metrics
  static const String eventsCreated = 'events_created';
  static const String registrations = 'registrations';
  static const String ticketsSold = 'tickets_sold';
  
  // Revenue Metrics
  static const String totalRevenue = 'total_revenue';
  static const String avgOrderValue = 'avg_order_value';
  static const String conversionRate = 'conversion_rate';
}
```

## 2.2 Real-time Dashboard API

```dart
class DashboardService {
  final Dio _dio;
  
  DashboardService(this._dio);
  
  Future<DashboardData> getDashboardData({
    required DateTime startDate,
    required DateTime endDate,
    String? sport,
    String? city,
  }) async {
    final response = await _dio.get('/analytics/dashboard', queryParameters: {
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'sport': sport,
      'city': city,
    });
    
    return DashboardData.fromJson(response.data);
  }
  
  Future<List<TimeSeriesData>> getTimeSeries({
    required String metric,
    required DateTime startDate,
    required DateTime endDate,
    String interval = 'day',
  }) async {
    final response = await _dio.get('/analytics/timeseries', queryParameters: {
      'metric': metric,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'interval': interval,
    });
    
    return (response.data as List)
        .map((e) => TimeSeriesData.fromJson(e))
        .toList();
  }
}
```

## 2.3 Dashboard Data Models

```dart
class DashboardData {
  final UserMetrics users;
  final EngagementMetrics engagement;
  final TrainingMetrics training;
  final EventMetrics events;
  final RevenueMetrics revenue;
  
  DashboardData({
    required this.users,
    required this.engagement,
    required this.training,
    required this.events,
    required this.revenue,
  });
  
  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      users: UserMetrics.fromJson(json['users']),
      engagement: EngagementMetrics.fromJson(json['engagement']),
      training: TrainingMetrics.fromJson(json['training']),
      events: EventMetrics.fromJson(json['events']),
      revenue: RevenueMetrics.fromJson(json['revenue']),
    );
  }
}

class UserMetrics {
  final int total;
  final int active;
  final int newUsers;
  final double retentionRate;
  
  UserMetrics({
    required this.total,
    required this.active,
    required this.newUsers,
    required this.retentionRate,
  });
  
  factory UserMetrics.fromJson(Map<String, dynamic> json) {
    return UserMetrics(
      total: json['total'],
      active: json['active'],
      newUsers: json['new_users'],
      retentionRate: json['retention_rate'].toDouble(),
    );
  }
}
```

---

# 3. ERROR TRACKING

## 3.1 Crashlytics Integration

```dart
class CrashlyticsService {
  static final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;
  
  static Future<void> initialize() async {
    await _crashlytics.setCrashlyticsCollectionEnabled(true);
    FlutterError.onError = _crashlytics.recordFlutterFatalError;
    
    // Pass all uncaught errors to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      _crashlytics.recordError(error, stack, fatal: true);
      return true;
    };
  }
  
  static Future<void> logError(dynamic error, StackTrace stack, {String? reason}) async {
    await _crashlytics.recordError(
      error,
      stack,
      reason: reason,
      printDetails: true,
    );
  }
  
  static Future<void> logMessage(String message, {LogLevel level = LogLevel.info}) async {
    await _crashlytics.log(message);
  }
  
  static Future<void> setUserIdentifier(String userId) async {
    await _crashlytics.setUserIdentifier(userId);
  }
  
  static Future<void> setCustomKey(String key, dynamic value) async {
    await _crashlytics.setCustomKey(key, value);
  }
}
```

## 3.2 Error Reporting

```dart
class ErrorReporter {
  static final CrashlyticsService _crashlytics = CrashlyticsService();
  static final AnalyticsService _analytics = AnalyticsService();
  
  static Future<void> reportError({
    required dynamic error,
    required StackTrace stack,
    String? context,
    Map<String, dynamic>? metadata,
  }) async {
    // Log to Crashlytics
    await _crashlytics.logError(error, stack, reason: context);
    
    // Log to Analytics
    await _analytics.logEvent(
      name: 'error_occurred',
      parameters: {
        'error_type': error.runtimeType.toString(),
        'error_message': error.toString(),
        'context': context,
        'metadata': metadata,
      },
    );
    
    // Send to backend
    await _sendToBackend(error, stack, context, metadata);
  }
  
  static Future<void> _sendToBackend(
    dynamic error,
    StackTrace stack,
    String? context,
    Map<String, dynamic>? metadata,
  ) async {
    try {
      await ApiClient.post('/errors/report', data: {
        'error': error.toString(),
        'stack_trace': stack.toString(),
        'context': context,
        'metadata': metadata,
        'platform': Platform.operatingSystem,
        'appVersion': await _getAppVersion(),
        'deviceInfo': await _getDeviceInfo(),
      });
    } catch (e) {
      // Silently fail
    }
  }
}
```

## 3.3 Error Boundaries

```dart
class ErrorBoundary extends StatefulWidget {
  final Widget child;
  final Widget Function(dynamic error)? errorBuilder;
  
  const ErrorBoundary({
    Key? key,
    required this.child,
    this.errorBuilder,
  }) : super(key: key);
  
  @override
  _ErrorBoundaryState createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  dynamic _error;
  
  @override
  void initState() {
    super.initState();
    ErrorWidget.builder = (FlutterErrorDetails details) {
      setState(() => _error = details.exception);
      return _buildErrorWidget(details.exception);
    };
  }
  
  Widget _buildErrorWidget(dynamic error) {
    if (widget.errorBuilder != null) {
      return widget.errorBuilder!(error);
    }
    
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 48),
          const SizedBox(height: 16),
          Text('Something went wrong', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => setState(() => _error = null),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return _buildErrorWidget(_error);
    }
    return widget.child;
  }
}
```

---

# 4. PERFORMANCE MONITORING

## 4.1 Firebase Performance

```dart
class PerformanceMonitoring {
  static final FirebasePerformance _performance = FirebasePerformance.instance;
  
  static Future<void> initialize() async {
    await _performance.setPerformanceCollectionEnabled(true);
  }
  
  static Trace createTrace(String name) {
    return _performance.newTrace(name);
  }
  
  static Future<void> traceAPICall({
    required String endpoint,
    required String method,
    required int statusCode,
    required Duration duration,
  }) async {
    final trace = createTrace('api_call');
    await trace.start();
    
    trace.putAttribute('endpoint', endpoint);
    trace.putAttribute('method', method);
    trace.putAttribute('status_code', statusCode.toString());
    trace.setMetric('duration_ms', duration.inMilliseconds);
    
    await trace.stop();
  }
  
  static Future<void> traceScreenLoad({
    required String screenName,
    required Duration duration,
  }) async {
    final trace = createTrace('screen_load');
    await trace.start();
    
    trace.putAttribute('screen_name', screenName);
    trace.setMetric('duration_ms', duration.inMilliseconds);
    
    await trace.stop();
  }
}
```

## 4.2 Custom Performance Metrics

```dart
class PerformanceMetrics {
  static final Map<String, List<Duration>> _metrics = {};
  
  static void recordMetric(String name, Duration duration) {
    _metrics.putIfAbsent(name, () => []).add(duration);
  }
  
  static Map<String, dynamic> getSummary() {
    final summary = <String, dynamic>{};
    
    _metrics.forEach((name, durations) {
      final avg = durations.fold<Duration>(
        Duration.zero,
        (a, b) => a + b,
      ) ~/ durations.length;
      
      final sorted = List<Duration>.from(durations)..sort();
      
      summary[name] = {
        'count': durations.length,
        'average_ms': avg.inMilliseconds,
        'min_ms': sorted.first.inMilliseconds,
        'max_ms': sorted.last.inMilliseconds,
        'p50_ms': sorted[sorted.length ~/ 2].inMilliseconds,
        'p95_ms': sorted[(sorted.length * 0.95).toInt()].inMilliseconds,
        'p99_ms': sorted[(sorted.length * 0.99).toInt()].inMilliseconds,
      };
    });
    
    return summary;
  }
  
  static Future<void> sendToBackend() async {
    final summary = getSummary();
    await ApiClient.post('/analytics/performance', data: summary);
  }
}
```

## 4.3 Network Monitoring

```dart
class NetworkMetrics {
  final Dio _dio;
  
  NetworkMetrics(this._dio) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.extra['startTime'] = DateTime.now();
        handler.next(options);
      },
      onResponse: (response, handler) {
        final startTime = response.requestOptions.extra['startTime'] as DateTime;
        final duration = DateTime.now().difference(startTime);
        
        _recordMetric(
          url: response.requestOptions.uri.toString(),
          method: response.requestOptions.method,
          statusCode: response.statusCode ?? 0,
          duration: duration,
          responseSize: response.data?.length ?? 0,
        );
        
        handler.next(response);
      },
      onError: (error, handler) {
        final startTime = error.requestOptions.extra['startTime'] as DateTime;
        final duration = DateTime.now().difference(startTime);
        
        _recordMetric(
          url: error.requestOptions.uri.toString(),
          method: error.requestOptions.method,
          statusCode: error.response?.statusCode ?? 0,
          duration: duration,
          error: error.toString(),
        );
        
        handler.next(error);
      },
    ));
  }
  
  void _recordMetric({
    required String url,
    required String method,
    required int statusCode,
    required Duration duration,
    int? responseSize,
    String? error,
  }) {
    PerformanceMetrics.recordMetric('api_${method}_${statusCode}', duration);
    
    // Send to analytics
    AnalyticsService.logEvent(
      name: 'api_request',
      parameters: {
        'url': url,
        'method': method,
        'status_code': statusCode,
        'duration_ms': duration.inMilliseconds,
        'response_size': responseSize,
        'error': error,
      },
    );
  }
}
```

---

# 5. USER BEHAVIOR ANALYTICS

## 5.1 User Journey Tracking

```dart
class UserJourneyTracker {
  final List<String> _screens = [];
  final Map<String, dynamic> _attributes = {};
  
  void trackScreen(String screenName) {
    _screens.add(screenName);
    AnalyticsService.logScreenView(screenName);
  }
  
  void setAttribute(String key, dynamic value) {
    _attributes[key] = value;
  }
  
  List<String> getScreens() => List.unmodifiable(_screens);
  Map<String, dynamic> getAttributes() => Map.unmodifiable(_attributes);
  
  Future<void> sendJourney() async {
    await ApiClient.post('/analytics/journey', data: {
      'screens': _screens,
      'attributes': _attributes,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }
}
```

## 5.2 Feature Usage Analytics

```dart
class FeatureAnalytics {
  static Future<void> trackFeatureUsage({
    required String featureName,
    required String action,
    Map<String, dynamic>? metadata,
  }) async {
    await AnalyticsService.logEvent(
      name: 'feature_used',
      parameters: {
        'feature_name': featureName,
        'action': action,
        'metadata': metadata,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }
  
  static Future<void> trackFeaturePerformance({
    required String featureName,
    required Duration loadTime,
    required bool success,
    String? error,
  }) async {
    await AnalyticsService.logEvent(
      name: 'feature_performance',
      parameters: {
        'feature_name': featureName,
        'load_time_ms': loadTime.inMilliseconds,
        'success': success,
        'error': error,
      },
    );
  }
}
```

---

# 6. BUSINESS INTELLIGENCE

## 6.1 Revenue Analytics

```dart
class RevenueAnalytics {
  static Future<void> trackRevenue({
    required String eventId,
    required String category,
    required double amount,
    required String paymentMethod,
    String? promoCode,
  }) async {
    await AnalyticsService.logEvent(
      name: 'revenue_generated',
      parameters: {
        'event_id': eventId,
        'category': category,
        'amount': amount,
        'payment_method': paymentMethod,
        'promo_code': promoCode,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }
  
  static Future<RevenueReport> getRevenueReport({
    required DateTime startDate,
    required DateTime endDate,
    String? groupBy,
  }) async {
    final response = await ApiClient.get('/analytics/revenue', queryParameters: {
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'groupBy': groupBy,
    });
    
    return RevenueReport.fromJson(response.data);
  }
}
```

## 6.2 Conversion Funnel

```dart
class ConversionFunnel {
  static Future<void> trackFunnelStep({
    required String funnelName,
    required String step,
    required int stepNumber,
    Map<String, dynamic>? metadata,
  }) async {
    await AnalyticsService.logEvent(
      name: 'funnel_step',
      parameters: {
        'funnel_name': funnelName,
        'step': step,
        'step_number': stepNumber,
        'metadata': metadata,
      },
    );
  }
  
  static Future<FunnelReport> getFunnelReport({
    required String funnelName,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final response = await ApiClient.get('/analytics/funnel', queryParameters: {
      'funnel_name': funnelName,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    });
    
    return FunnelReport.fromJson(response.data);
  }
}
```

---

# 7. ALERTING

## 7.1 Alert Rules

```dart
class AlertRules {
  static const List<AlertRule> rules = [
    AlertRule(
      name: 'High Error Rate',
      metric: 'error_rate',
      threshold: 5.0,
      operator: AlertOperator.greaterThan,
      severity: AlertSeverity.critical,
    ),
    AlertRule(
      name: 'Slow API Response',
      metric: 'api_response_time_p95',
      threshold: 1000,
      operator: AlertOperator.greaterThan,
      severity: AlertSeverity.warning,
    ),
    AlertRule(
      name: 'Low User Retention',
      metric: 'retention_rate',
      threshold: 30.0,
      operator: AlertOperator.lessThan,
      severity: AlertSeverity.warning,
    ),
  ];
}
```

## 7.2 Alert Service

```dart
class AlertService {
  static Future<void> checkAlerts(Map<String, dynamic> metrics) async {
    for (final rule in AlertRules.rules) {
      final value = metrics[rule.metric] as num?;
      if (value == null) continue;
      
      bool triggered = false;
      switch (rule.operator) {
        case AlertOperator.greaterThan:
          triggered = value > rule.threshold;
          break;
        case AlertOperator.lessThan:
          triggered = value < rule.threshold;
          break;
        case AlertOperator.equals:
          triggered = value == rule.threshold;
          break;
      }
      
      if (triggered) {
        await _sendAlert(rule, value);
      }
    }
  }
  
  static Future<void> _sendAlert(AlertRule rule, num value) async {
    await ApiClient.post('/alerts', data: {
      'rule_name': rule.name,
      'metric': rule.metric,
      'value': value,
      'threshold': rule.threshold,
      'severity': rule.severity.name,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }
}
```

---

# 8. ANALYTICS CHECKLIST

## Setup Phase
- [ ] Firebase Analytics configured
- [ ] Crashlytics integrated
- [ ] Performance monitoring enabled
- [ ] Custom events defined
- [ ] Dashboard created

## Development Phase
- [ ] All events tracked
- [ ] Error reporting implemented
- [ ] Performance metrics recorded
- [ ] User journey tracked

## Production Phase
- [ ] Alerts configured
- [ ] Reports scheduled
- [ ] Data validated
- [ ] Privacy compliant

---

**Document Version**: 1.0
**Last Updated**: August 29, 2026
