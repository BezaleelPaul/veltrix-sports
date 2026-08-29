# VELTRIX SPORTS - PERFORMANCE OPTIMIZATION
## Complete Performance Guide

---

# PERFORMANCE TARGETS

| Metric | Target | Measurement |
|--------|--------|-------------|
| App Load Time | < 2 seconds | Cold start |
| API Response Time | < 500ms | 95th percentile |
| Frame Rate | 60 FPS | No jank |
| Memory Usage | < 200MB | Average |
| Battery Impact | < 5% | Per hour of use |
| Network Requests | < 50KB | Initial load |

---

# 1. FLUTTER PERFORMANCE

## 1.1 Widget Optimization

### Use const Constructors
```dart
// ❌ Bad
Text('Hello')
Container(child: Text('World'))

// ✅ Good
const Text('Hello')
const Container(child: Text('World'))
```

### Minimize Rebuilds
```dart
// ❌ Bad - Rebuilds entire screen
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Counter: $counter'),
        ElevatedButton(
          onPressed: () => setState(() => counter++),
          child: Text('Increment'),
        ),
      ],
    );
  }
}

// ✅ Good - Only rebuilds affected widget
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CounterWidget(),  // Separate state
        IncrementButton(),
      ],
    );
  }
}

class CounterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = context.watch<CounterCubit>().state;
    return Text('Counter: $counter');
  }
}
```

### Use ListView.builder
```dart
// ❌ Bad - Builds all items at once
ListView(
  children: items.map((item) => ListTile(title: Text(item))).toList(),
)

// ✅ Good - Builds items lazily
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) => ListTile(title: Text(items[index])),
)
```

## 1.2 Image Optimization

### Resize Images
```dart
// Resize before displaying
Image.network(
  url,
  width: 200,
  height: 200,
  fit: BoxFit.cover,
)

// Use cached network image
CachedNetworkImage(
  imageUrl: url,
  width: 200,
  height: 200,
  placeholder: (context, url) => CircularProgressIndicator(),
  errorWidget: (context, url, error) => Icon(Icons.error),
)
```

### Compress Images
```dart
// Use image package for compression
import 'package:image/image.dart' as img;

Future<File> compressImage(File file) async {
  final bytes = await file.readAsBytes();
  final image = img.decodeImage(bytes);
  final compressed = img.encodeJpg(image, quality: 85);
  return File(file.path)..writeAsBytesSync(compressed);
}
```

## 1.3 Memory Management

### Dispose Controllers
```dart
class _MyScreenState extends State<MyScreen> {
  late TextEditingController _controller;
  late ScrollController _scrollController;
  
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _scrollController = ScrollController();
  }
  
  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
```

### Use Weak References
```dart
// Store large data temporarily
class DataManager {
  final Map<String, WeakReference<Object>> _cache = {};
  
  void store(String key, Object data) {
    _cache[key] = WeakReference(data);
  }
  
  Object? retrieve(String key) {
    return _cache[key]?.target;
  }
}
```

---

# 2. API OPTIMIZATION

## 2.1 Caching Strategy

### In-Memory Cache
```dart
class CacheService {
  final Map<String, CacheEntry> _cache = {};
  final Duration defaultTTL = const Duration(minutes: 5);
  
  void set(String key, dynamic value, {Duration? ttl}) {
    _cache[key] = CacheEntry(
      value: value,
      expiresAt: DateTime.now().add(ttl ?? defaultTTL),
    );
  }
  
  T? get<T>(String key) {
    final entry = _cache[key];
    if (entry == null || entry.isExpired) {
      _cache.remove(key);
      return null;
    }
    return entry.value as T;
  }
}
```

### Persistent Cache
```dart
class PersistentCache {
  final Box _box;
  
  PersistentCache() : _box = Hive.box('cache');
  
  Future<void> set(String key, dynamic value, {Duration? ttl}) async {
    await _box.put(key, {
      'value': value,
      'expiresAt': ttl != null 
        ? DateTime.now().add(ttl).millisecondsSinceEpoch
        : null,
    });
  }
  
  T? get<T>(String key) {
    final data = _box.get(key);
    if (data == null) return null;
    
    if (data['expiresAt'] != null && 
        DateTime.now().millisecondsSinceEpoch > data['expiresAt']) {
      _box.delete(key);
      return null;
    }
    
    return data['value'] as T;
  }
}
```

## 2.2 Request Optimization

### Batch Requests
```dart
class BatchApiClient {
  final Dio _dio;
  
  Future<List<T>> batchGet<T>(List<String> urls) async {
    final responses = await Future.wait(
      urls.map((url) => _dio.get(url)),
    );
    return responses.map((r) => r.data as T).toList();
  }
}
```

### Pagination
```dart
class PaginatedList<T> {
  final List<T> items = [];
  int _page = 1;
  bool _hasMore = true;
  
  Future<void> loadMore(Future<List<T>> Function(int page) fetch) async {
    if (!_hasMore) return;
    
    final newItems = await fetch(_page);
    if (newItems.isEmpty) {
      _hasMore = false;
      return;
    }
    
    items.addAll(newItems);
    _page++;
  }
}
```

## 2.3 Compression

### Enable Gzip
```dart
// Backend (Node.js)
const compression = require('compression');
app.use(compression());

// Flutter Client
final dio = Dio();
dio.options.extra['responseType'] = 'json';
dio.interceptors.add(LogInterceptor());
```

---

# 3. DATABASE OPTIMIZATION

## 3.1 Indexing

```sql
-- Create indexes for frequently queried columns
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_events_event_date ON events(event_date);
CREATE INDEX idx_sessions_plan_id ON plan_sessions(plan_id);

-- Partial indexes
CREATE INDEX idx_active_users ON users(id) WHERE is_active = true;

-- Composite indexes
CREATE INDEX idx_sessions_plan_week ON plan_sessions(plan_id, week_number);
```

## 3.2 Query Optimization

```sql
-- ❌ Bad - SELECT *
SELECT * FROM users WHERE email = 'test@email.com';

-- ✅ Good - Select specific columns
SELECT id, name, email FROM users WHERE email = 'test@email.com';

-- ❌ Bad - N+1 query
SELECT * FROM plans;
-- Then for each plan:
SELECT * FROM sessions WHERE plan_id = ?;

-- ✅ Good - JOIN
SELECT p.*, s.* 
FROM plans p 
JOIN sessions s ON p.id = s.plan_id;

-- ✅ Good - Subquery
SELECT * FROM sessions 
WHERE plan_id IN (SELECT id FROM plans WHERE user_id = ?);
```

## 3.3 Connection Pooling

```dart
class DatabasePool {
  static final _pool = ConnectionPool(
    host: 'localhost',
    port: 5432,
    database: 'veltrix',
    user: 'admin',
    password: 'password',
    maxConnections: 10,
  );
  
  static Future<Connection> getConnection() async {
    return await _pool.getConnection();
  }
}
```

---

# 4. NETWORK OPTIMIZATION

## 4.1 Connection Management

```dart
class OptimizedHttpClient {
  final Dio _dio;
  
  OptimizedHttpClient() : _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      'Connection': 'keep-alive',
      'Keep-Alive': 'timeout=5, max=100',
    },
  ));
}
```

## 4.2 Retry Logic

```dart
class RetryInterceptor extends Interceptor {
  final int maxRetries;
  final Duration delay;
  
  RetryInterceptor({
    this.maxRetries = 3,
    this.delay = const Duration(seconds: 1),
  });
  
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err) && err.requestOptions.extra['retryCount'] == null) {
      err.requestOptions.extra['retryCount'] = 0;
    }
    
    final retryCount = err.requestOptions.extra['retryCount'] ?? 0;
    
    if (retryCount < maxRetries && _shouldRetry(err)) {
      err.requestOptions.extra['retryCount'] = retryCount + 1;
      await Future.delayed(delay * (retryCount + 1));
      
      try {
        final response = await _dio.fetch(err.requestOptions);
        handler.resolve(response);
        return;
      } catch (e) {
        // Fall through to error handler
      }
    }
    
    handler.next(err);
  }
  
  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
           err.type == DioExceptionType.sendTimeout ||
           (err.response?.statusCode ?? 0) >= 500;
  }
}
```

## 4.3 Offline Support

```dart
class OfflineService {
  final Connectivity _connectivity = Connectivity();
  final Queue<Request> _pendingRequests = Queue();
  
  Future<void> init() async {
    _connectivity.onConnectivityChanged.listen((result) {
      if (result != ConnectivityResult.none) {
        _processPendingRequests();
      }
    });
  }
  
  Future<void> queueRequest(Request request) async {
    _pendingRequests.add(request);
    await _savePendingRequests();
  }
  
  Future<void> _processPendingRequests() async {
    while (_pendingRequests.isNotEmpty) {
      final request = _pendingRequests.removeFirst();
      try {
        await _executeRequest(request);
      } catch (e) {
        _pendingRequests.addFirst(request);
        break;
      }
    }
    await _savePendingRequests();
  }
}
```

---

# 5. BATTERY OPTIMIZATION

## 5.1 Location Services

```dart
class OptimizedLocationService {
  Timer? _locationTimer;
  LocationSettings _settings = AndroidSettings(
    accuracy: LocationAccuracy.medium,
    intervalDuration: const Duration(minutes: 5),
    foregroundNotificationConfig: ForegroundNotificationConfig(
      notificationTitle: 'Veltrix Sports',
      notificationText: 'Tracking your activity',
    ),
  );
  
  void startTracking() {
    _locationTimer = Timer.periodic(_settings.intervalDuration!, (_) {
      _getCurrentLocation();
    });
  }
  
  void stopTracking() {
    _locationTimer?.cancel();
  }
}
```

## 5.2 Background Tasks

```dart
class BackgroundTaskManager {
  final Workmanager _workmanager = Workmanager();
  
  Future<void> init() async {
    await _workmanager.initialize(
      callbackDispatcher,
      isInDebugMode: false,
    );
  }
  
  Future<void> schedulePeriodicTask() async {
    await _workmanager.registerPeriodicTask(
      'syncData',
      'syncDataTask',
      constraints: Constraints(
        networkType: NetworkType.connected,
        requiresBatteryNotLow: true,
      ),
      frequency: const Duration(hours: 1),
    );
  }
}
```

## 5.3 Efficient Animations

```dart
// Use AnimatedBuilder instead of setState
class EfficientAnimation extends StatefulWidget {
  @override
  _EfficientAnimationState createState() => _EfficientAnimationState();
}

class _EfficientAnimationState extends State<EfficientAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: child,
        );
      },
      child: Container(
        width: 100,
        height: 100,
        color: Colors.blue,
      ),
    );
  }
}
```

---

# 6. MONITORING & PROFILING

## 6.1 Flutter Performance Overlay

```dart
MaterialApp(
  showPerformanceOverlay: kDebugMode,
  // ...
)
```

## 6.2 Custom Metrics

```dart
class PerformanceMonitor {
  static final Map<String, Stopwatch> _timers = {};
  
  static void startTimer(String name) {
    _timers[name] = Stopwatch()..start();
  }
  
  static Duration stopTimer(String name) {
    final timer = _timers.remove(name);
    if (timer == null) return Duration.zero;
    timer.stop();
    return timer.elapsed;
  }
  
  static void logMetric(String name, Duration duration) {
    // Send to analytics
    AnalyticsService.logEvent(
      name: 'performance_metric',
      parameters: {
        'metric_name': name,
        'duration_ms': duration.inMilliseconds,
      },
    );
  }
}
```

## 6.3 Network Monitoring

```dart
class NetworkMonitor {
  final Dio _dio;
  
  NetworkMonitor(this._dio) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.extra['startTime'] = DateTime.now();
        handler.next(options);
      },
      onResponse: (response, handler) {
        final startTime = response.requestOptions.extra['startTime'] as DateTime;
        final duration = DateTime.now().difference(startTime);
        
        AnalyticsService.logNetworkRequest(
          url: response.requestOptions.uri.toString(),
          method: response.requestOptions.method,
          statusCode: response.statusCode ?? 0,
          duration: duration,
        );
        
        handler.next(response);
      },
    ));
  }
}
```

---

# 7. PERFORMANCE CHECKLIST

## Development Phase
- [ ] Use const constructors
- [ ] Implement lazy loading
- [ ] Optimize images
- [ ] Use proper state management
- [ ] Implement caching

## Testing Phase
- [ ] Run performance tests
- [ ] Profile with DevTools
- [ ] Test on low-end devices
- [ ] Monitor memory usage
- [ ] Check frame rates

## Production Phase
- [ ] Enable performance monitoring
- [ ] Set up alerts
- [ ] Monitor API response times
- [ ] Track crash rates
- [ ] Analyze user metrics

---

**Document Version**: 1.0
**Last Updated**: August 29, 2026
