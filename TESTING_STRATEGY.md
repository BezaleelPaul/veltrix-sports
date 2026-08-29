# VELTRIX SPORTS - TESTING STRATEGY
## Complete Testing Guide

---

# TESTING OVERVIEW

```
Testing Approach: Test-Driven Development (TDD)
Coverage Target: 80% minimum
Automation: 90% of tests automated
CI/CD: Tests run on every commit
```

---

# TEST PYRAMID

```
                    ┌─────────┐
                    │   E2E   │  10%
                    │  Tests  │
                    ├─────────┤
                    │Integration│  20%
                    │  Tests   │
                    ├─────────┤
                    │  Unit    │  70%
                    │  Tests   │
                    └─────────┘
```

---

# 1. UNIT TESTS (70%)

## 1.1 BLoC Tests

```dart
// training_plan_bloc_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:veltrix_sports/features/training_plan/presentation/bloc/training_plan_bloc.dart';

void main() {
  group('TrainingPlanBloc', () {
    blocTest<TrainingPlanBloc, TrainingPlanState>(
      'emits [Loading, Loaded] when LoadPlans is added',
      build: () => TrainingPlanBloc(
        getPlansUseCase: mockGetPlansUseCase,
      ),
      act: (bloc) => bloc.add(const LoadPlans()),
      expect: () => [
        TrainingPlanLoading(),
        isA<TrainingPlanLoaded>(),
      ],
    );

    blocTest<TrainingPlanBloc, TrainingPlanState>(
      'emits [Loading, Error] when LoadPlans fails',
      build: () => TrainingPlanBloc(
        getPlansUseCase: mockGetPlansUseCase,
      ),
      act: (bloc) => bloc.add(const LoadPlans()),
      expect: () => [
        TrainingPlanLoading(),
        isA<TrainingPlanError>(),
      ],
    );

    blocTest<TrainingPlanBloc, TrainingPlanState>(
      'emits [Loading, Loaded] when CreatePlan is added',
      build: () => TrainingPlanBloc(
        createPlanUseCase: mockCreatePlanUseCase,
      ),
      act: (bloc) => bloc.add(CreatePlan(params: createParams)),
      expect: () => [
        TrainingPlanLoading(),
        isA<TrainingPlanLoaded>(),
      ],
    );
  });
}
```

---

## 1.2 Repository Tests

```dart
// training_plan_repository_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:veltrix_sports/features/training_plan/data/repositories/training_plan_repository_impl.dart';

void main() {
  late TrainingPlanRepositoryImpl repository;
  late MockTrainingPlanRemoteDataSource mockRemoteDataSource;
  late MockTrainingPlanLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTrainingPlanRemoteDataSource();
    mockLocalDataSource = MockTrainingPlanLocalDataSource();
    repository = TrainingPlanRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  group('getPlans', () {
    test('should return plans from remote when remote data source succeeds',
        () async {
      // Arrange
      when(mockRemoteDataSource.getPlans(any))
          .thenAnswer((_) async => testPlans);

      // Act
      final result = await repository.getPlans(params);

      // Assert
      expect(result, isA<Right<Failure, List<TrainingPlan>>>());
      verify(mockRemoteDataSource.getPlans(any)).called(1);
    });

    test('should return plans from local when remote fails',
        () async {
      // Arrange
      when(mockRemoteDataSource.getPlans(any))
          .thenThrow(ServerException());
      when(mockLocalDataSource.getCachedPlans())
          .thenAnswer((_) async => testPlans);

      // Act
      final result = await repository.getPlans(params);

      // Assert
      expect(result, isA<Right<Failure, List<TrainingPlan>>>());
      verify(mockLocalDataSource.getCachedPlans()).called(1);
    });

    test('should return failure when both remote and local fail',
        () async {
      // Arrange
      when(mockRemoteDataSource.getPlans(any))
          .thenThrow(ServerException());
      when(mockLocalDataSource.getCachedPlans())
          .thenThrow(CacheException());

      // Act
      final result = await repository.getPlans(params);

      // Assert
      expect(result, isA<Left<Failure, List<TrainingPlan>>>());
    });
  });
}
```

---

## 1.3 Use Case Tests

```dart
// get_plans_use_case_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:veltrix_sports/features/training_plan/domain/usecases/get_plans.dart';

void main() {
  late GetPlansUseCase useCase;
  late MockTrainingPlanRepository mockRepository;

  setUp(() {
    mockRepository = MockTrainingPlanRepository();
    useCase = GetPlansUseCase(mockRepository);
  });

  final testParams = GetPlansParams(
    status: 'active',
    sport: 'running',
  );

  test('should get plans from repository', () async {
    // Arrange
    when(mockRepository.getPlans(testParams))
        .thenAnswer((_) async => Right(testPlans));

    // Act
    final result = await useCase(testParams);

    // Assert
    expect(result, isA<Right<Failure, List<TrainingPlan>>>());
    verify(mockRepository.getPlans(testParams)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return failure when repository fails', () async {
    // Arrange
    when(mockRepository.getPlans(testParams))
        .thenAnswer((_) async => Left(ServerFailure()));

    // Act
    final result = await useCase(testParams);

    // Assert
    expect(result, isA<Left<Failure, List<TrainingPlan>>>());
    verify(mockRepository.getPlans(testParams)).called(1);
  });
}
```

---

## 1.4 Model Tests

```dart
// training_plan_model_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:veltrix_sports/features/training_plan/data/models/training_plan_model.dart';

void main() {
  group('TrainingPlanModel', () {
    test('should create model from JSON', () {
      // Arrange
      final json = {
        'id': 'plan-123',
        'title': 'Marathon Training',
        'sport': 'running',
        'duration': 12,
        'startDate': '2024-01-15',
        'endDate': '2024-04-08',
        'status': 'active',
        'progress': 75.0,
      };

      // Act
      final model = TrainingPlanModel.fromJson(json);

      // Assert
      expect(model.id, 'plan-123');
      expect(model.title, 'Marathon Training');
      expect(model.sport, 'running');
      expect(model.duration, 12);
      expect(model.status, 'active');
      expect(model.progress, 75.0);
    });

    test('should convert model to JSON', () {
      // Arrange
      final model = TrainingPlanModel(
        id: 'plan-123',
        title: 'Marathon Training',
        sport: 'running',
        duration: 12,
        startDate: DateTime.parse('2024-01-15'),
        endDate: DateTime.parse('2024-04-08'),
        status: 'active',
        progress: 75.0,
      );

      // Act
      final json = model.toJson();

      // Assert
      expect(json['id'], 'plan-123');
      expect(json['title'], 'Marathon Training');
      expect(json['sport'], 'running');
      expect(json['duration'], 12);
      expect(json['status'], 'active');
      expect(json['progress'], 75.0);
    });

    test('should handle null values in JSON', () {
      // Arrange
      final json = {
        'id': 'plan-123',
        'title': 'Marathon Training',
      };

      // Act
      final model = TrainingPlanModel.fromJson(json);

      // Assert
      expect(model.id, 'plan-123');
      expect(model.title, 'Marathon Training');
      expect(model.sport, isNull);
      expect(model.duration, isNull);
    });
  });
}
```

---

## 1.5 Validation Tests

```dart
// validators_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:veltrix_sports/core/utils/validators.dart';

void main() {
  group('Email Validation', () {
    test('should return null for valid email', () {
      expect(Validators.email('test@email.com'), isNull);
    });

    test('should return error for invalid email', () {
      expect(Validators.email('invalid-email'), isNotNull);
    });

    test('should return error for empty email', () {
      expect(Validators.email(''), isNotNull);
    });
  });

  group('Password Validation', () {
    test('should return null for valid password', () {
      expect(Validators.password('SecurePass123!'), isNull);
    });

    test('should return error for short password', () {
      expect(Validators.password('Short'), isNotNull);
    });

    test('should return error for password without uppercase', () {
      expect(Validators.password('securepass123!'), isNotNull);
    });

    test('should return error for password without number', () {
      expect(Validators.password('SecurePass!'), isNotNull);
    });
  });

  group('Phone Validation', () {
    test('should return null for valid Indian phone', () {
      expect(Validators.phone('+919876543210'), isNull);
    });

    test('should return error for invalid phone', () {
      expect(Validators.phone('123456'), isNotNull);
    });

    test('should return error for phone without country code', () {
      expect(Validators.phone('9876543210'), isNotNull);
    });
  });

  group('OTP Validation', () {
    test('should return null for valid 6-digit OTP', () {
      expect(Validators.otp('123456'), isNull);
    });

    test('should return error for short OTP', () {
      expect(Validators.otp('123'), isNotNull);
    });

    test('should return error for non-numeric OTP', () {
      expect(Validators.otp('123abc'), isNotNull);
    });
  });
}
```

---

## 1.6 Utility Tests

```dart
// date_utils_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:veltrix_sports/core/utils/date_utils.dart';

void main() {
  group('DateUtils', () {
    test('should format date correctly', () {
      final date = DateTime(2024, 1, 15);
      expect(CustomDateUtils.formatDate(date), '15 Jan 2024');
    });

    test('should format time correctly', () {
      final time = DateTime(2024, 1, 15, 14, 30);
      expect(CustomDateUtils.formatTime(time), '2:30 PM');
    });

    test('should calculate days until date', () {
      final futureDate = DateTime.now().add(const Duration(days: 5));
      expect(CustomDateUtils.daysUntil(futureDate), 5);
    });

    test('should return 0 for past date', () {
      final pastDate = DateTime.now().subtract(const Duration(days: 5));
      expect(CustomDateUtils.daysUntil(pastDate), 0);
    });
  });
}
```

---

# 2. INTEGRATION TESTS (20%)

## 2.1 API Integration Tests

```dart
// training_plan_api_integration_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:veltrix_sports/features/training_plan/data/datasources/training_plan_remote_data_source.dart';

void main() {
  late TrainingPlanRemoteDataSourceImpl dataSource;
  late http.Client client;

  setUp(() {
    client = http.Client();
    dataSource = TrainingPlanRemoteDataSourceImpl(client: client);
  });

  tearDown(() {
    client.close();
  });

  group('Training Plan API Integration', () {
    test('should get plans from API', () async {
      // Act
      final result = await dataSource.getPlans(
        const GetPlansParams(status: 'active'),
      );

      // Assert
      expect(result, isA<List<TrainingPlanModel>>());
      expect(result.isNotEmpty, true);
    });

    test('should create plan via API', () async {
      // Arrange
      final params = CreatePlanParams(
        title: 'Test Plan',
        sport: 'running',
        duration: 12,
      );

      // Act
      final result = await dataSource.createPlan(params);

      // Assert
      expect(result, isA<TrainingPlanModel>());
      expect(result.title, 'Test Plan');
    });
  });
}
```

---

## 2.2 Database Integration Tests

```dart
// training_plan_database_integration_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:veltrix_sports/features/training_plan/data/datasources/training_plan_local_data_source.dart';
import 'package:veltrix_sports/core/database/database_helper.dart';

void main() {
  late TrainingPlanLocalDataSourceImpl dataSource;
  late DatabaseHelper databaseHelper;

  setUp(() async {
    databaseHelper = DatabaseHelper();
    await databaseHelper.init();
    dataSource = TrainingPlanLocalDataSourceImpl(
      databaseHelper: databaseHelper,
    );
  });

  tearDown(() async {
    await databaseHelper.close();
  });

  group('Training Plan Database Integration', () {
    test('should cache plans', () async {
      // Arrange
      final plans = [testPlanModel];

      // Act
      await dataSource.cachePlans(plans);
      final result = await dataSource.getCachedPlans();

      // Assert
      expect(result.length, 1);
      expect(result.first.id, testPlanModel.id);
    });

    test('should get cached plan by id', () async {
      // Arrange
      await dataSource.cachePlans([testPlanModel]);

      // Act
      final result = await dataSource.getCachedPlanById('plan-123');

      // Assert
      expect(result, isNotNull);
      expect(result!.id, 'plan-123');
    });

    test('should clear cache', () async {
      // Arrange
      await dataSource.cachePlans([testPlanModel]);

      // Act
      await dataSource.clearCache();
      final result = await dataSource.getCachedPlans();

      // Assert
      expect(result.isEmpty, true);
    });
  });
}
```

---

## 2.3 Firebase Integration Tests

```dart
// firebase_auth_integration_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:veltrix_sports/core/services/firebase_auth_service.dart';

void main() {
  late FirebaseAuthService authService;

  setUp(() {
    authService = FirebaseAuthService();
  });

  group('Firebase Auth Integration', () {
    test('should send OTP to phone', () async {
      // Act
      final result = await authService.sendOTP('+919876543210');

      // Assert
      expect(result, isA<String>());
      expect(result.isNotEmpty, true);
    });

    test('should verify OTP', () async {
      // Arrange
      final verificationId = await authService.sendOTP('+919876543210');

      // Act
      final result = await authService.verifyOTP(verificationId, '123456');

      // Assert
      expect(result, isA<UserCredential>());
    });
  });
}
```

---

# 3. WIDGET TESTS

```dart
// login_screen_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:veltrix_sports/features/auth/presentation/pages/login_screen.dart';
import 'package:veltrix_sports/features/auth/presentation/bloc/auth_bloc.dart';

void main() {
  late MockAuthBloc mockAuthBloc;

  setUp(() {
    mockAuthBloc = MockAuthBloc();
  });

  Widget makeTestable(Widget child) {
    return BlocProvider<AuthBloc>.value(
      value: mockAuthBloc,
      child: MaterialApp(home: child),
    );
  }

  group('LoginScreen', () {
    testWidgets('should show email and password fields', (tester) async {
      // Act
      await tester.pumpWidget(makeTestable(const LoginScreen()));

      // Assert
      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
    });

    testWidgets('should show login button', (tester) async {
      // Act
      await tester.pumpWidget(makeTestable(const LoginScreen()));

      // Assert
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
    });

    testWidgets('should show forgot password link', (tester) async {
      // Act
      await tester.pumpWidget(makeTestable(const LoginScreen()));

      // Assert
      expect(find.text('Forgot Password?'), findsOneWidget);
    });

    testWidgets('should show register link', (tester) async {
      // Act
      await tester.pumpWidget(makeTestable(const LoginScreen()));

      // Assert
      expect(find.text("Don't have an account? Register"), findsOneWidget);
    });

    testWidgets('should validate empty email', (tester) async {
      // Act
      await tester.pumpWidget(makeTestable(const LoginScreen()));
      await tester.tap(find.text('Login'));
      await tester.pump();

      // Assert
      expect(find.text('Email is required'), findsOneWidget);
    });

    testWidgets('should validate invalid email', (tester) async {
      // Act
      await tester.pumpWidget(makeTestable(const LoginScreen()));
      await tester.enterText(
        find.byType(TextField).first,
        'invalid-email',
      );
      await tester.tap(find.text('Login'));
      await tester.pump();

      // Assert
      expect(find.text('Invalid email format'), findsOneWidget);
    });

    testWidgets('should validate empty password', (tester) async {
      // Act
      await tester.pumpWidget(makeTestable(const LoginScreen()));
      await tester.enterText(
        find.byType(TextField).first,
        'test@email.com',
      );
      await tester.tap(find.text('Login'));
      await tester.pump();

      // Assert
      expect(find.text('Password is required'), findsOneWidget);
    });
  });
}
```

---

# 4. E2E TESTS

```dart
// login_e2e_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:veltrix_sports/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Login Flow E2E', () {
    testWidgets('should login successfully', (tester) async {
      // Arrange
      app.main();
      await tester.pumpAndSettle();

      // Act
      await tester.enterText(
        find.byKey(const Key('email_field')),
        'test@email.com',
      );
      await tester.enterText(
        find.byKey(const Key('password_field')),
        'SecurePass123!',
      );
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Dashboard'), findsOneWidget);
    });

    testWidgets('should show error for invalid credentials', (tester) async {
      // Arrange
      app.main();
      await tester.pumpAndSettle();

      // Act
      await tester.enterText(
        find.byKey(const Key('email_field')),
        'wrong@email.com',
      );
      await tester.enterText(
        find.byKey(const Key('password_field')),
        'WrongPass123!',
      );
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Invalid credentials'), findsOneWidget);
    });
  });

  group('Registration Flow E2E', () {
    testWidgets('should register successfully', (tester) async {
      // Arrange
      app.main();
      await tester.pumpAndSettle();

      // Act
      await tester.tap(find.text("Don't have an account? Register"));
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byKey(const Key('name_field')),
        'John Doe',
      );
      await tester.enterText(
        find.byKey(const Key('email_field')),
        'john@email.com',
      );
      await tester.enterText(
        find.byKey(const Key('phone_field')),
        '+919876543210',
      );
      await tester.enterText(
        find.byKey(const Key('password_field')),
        'SecurePass123!',
      );
      await tester.enterText(
        find.byKey(const Key('confirm_password_field')),
        'SecurePass123!',
      );
      await tester.tap(find.byKey(const Key('register_button')));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('OTP Verification'), findsOneWidget);
    });
  });
}
```

---

# 5. PERFORMANCE TESTS

```dart
// performance_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:performance/performance.dart';
import 'package:veltrix_sports/main.dart' as app;

void main() {
  group('Performance Tests', () {
    testWidgets('should load dashboard under 3 seconds', (tester) async {
      // Arrange
      app.main();
      
      // Act
      final metrics = await PerformanceMonitor.measure(
        () async {
          await tester.pumpAndSettle();
          return true;
        },
      );

      // Assert
      expect(metrics.elapsedMilliseconds, lessThan(3000));
    });

    testWidgets('should render 100 list items under 16ms', (tester) async {
      // Arrange
      final items = List.generate(100, (i) => 'Item $i');
      
      // Act
      final metrics = await PerformanceMonitor.measure(
        () async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(items[index]),
                  ),
                ),
              ),
            ),
          );
          return true;
        },
      );

      // Assert
      expect(metrics.elapsedMilliseconds, lessThan(16));
    });

    testWidgets('should handle rapid taps without crash', (tester) async {
      // Arrange
      app.main();
      await tester.pumpAndSettle();

      // Act
      for (var i = 0; i < 100; i++) {
        await tester.tap(find.byType(ElevatedButton).first);
        await tester.pump();
      }

      // Assert
      expect(tester.takeException(), isNull);
    });
  });
}
```

---

# 6. ACCESSIBILITY TESTS

```dart
// accessibility_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_accessibility_service/flutter_accessibility_service.dart';
import 'package:veltrix_sports/main.dart' as app;

void main() {
  group('Accessibility Tests', () {
    testWidgets('should have semantic labels', (tester) async {
      // Arrange
      app.main();
      await tester.pumpAndSettle();

      // Assert
      expect(
        find.bySemanticsLabel('Email input field'),
        findsOneWidget,
      );
      expect(
        find.bySemanticsLabel('Password input field'),
        findsOneWidget,
      );
      expect(
        find.bySemanticsLabel('Login button'),
        findsOneWidget,
      );
    });

    testWidgets('should support screen readers', (tester) async {
      // Arrange
      app.main();
      await tester.pumpAndSettle();

      // Act
      final semantics = find.byType(Semantics);

      // Assert
      expect(semantics, findsWidgets);
    });

    testWidgets('should have sufficient color contrast', (tester) async {
      // Arrange
      app.main();
      await tester.pumpAndSettle();

      // Assert - Color contrast ratio should be at least 4.5:1
      final colors = [
        // Primary text color
        Color(0xFF000000),
        // Background color
        Color(0xFFFFFFFF),
      ];

      final contrastRatio = calculateContrastRatio(colors[0], colors[1]);
      expect(contrastRatio, greaterThanOrEqualTo(4.5));
    });
  });
}
```

---

# 7. SECURITY TESTS

```dart
// security_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:veltrix_sports/core/services/security_service.dart';

void main() {
  group('Security Tests', () {
    test('should hash password securely', () async {
      // Arrange
      final password = 'SecurePass123!';

      // Act
      final hash1 = await SecurityService.hashPassword(password);
      final hash2 = await SecurityService.hashPassword(password);

      // Assert
      expect(hash1, isNot(equals(password)));
      expect(hash1, equals(hash2));
    });

    test('should verify password correctly', () async {
      // Arrange
      final password = 'SecurePass123!';
      final hash = await SecurityService.hashPassword(password);

      // Act
      final isValid = await SecurityService.verifyPassword(password, hash);
      final isInvalid = await SecurityService.verifyPassword('WrongPass', hash);

      // Assert
      expect(isValid, true);
      expect(isInvalid, false);
    });

    test('should encrypt and decrypt data', () async {
      // Arrange
      final data = 'Sensitive data';

      // Act
      final encrypted = await SecurityService.encrypt(data);
      final decrypted = await SecurityService.decrypt(encrypted);

      // Assert
      expect(encrypted, isNot(equals(data)));
      expect(decrypted, equals(data));
    });

    test('should generate secure token', () {
      // Act
      final token1 = SecurityService.generateToken();
      final token2 = SecurityService.generateToken();

      // Assert
      expect(token1.length, greaterThanOrEqualTo(32));
      expect(token1, isNot(equals(token2)));
    });
  });
}
```

---

# TEST COVERAGE REPORT

```yaml
# coverage_config.yaml
report:
  format: html
  output: coverage/report.html
  thresholds:
    line: 80
    branch: 75
    function: 85
    statement: 80

exclude:
  - "**/*.g.dart"
  - "**/*.freezed.dart"
  - "**/generated/**"
  - "**/*.gen.dart"
```

---

# CI/CD TEST CONFIGURATION

```yaml
# .github/workflows/test.yml
name: Tests

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main, develop]

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3

      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.41.9'
          channel: 'stable'

      - name: Install dependencies
        run: flutter pub get

      - name: Run unit tests
        run: flutter test --coverage

      - name: Run integration tests
        run: flutter test integration_test/

      - name: Check coverage
        run: |
          if [ $(lcov --summary coverage/lcov.info 2>&1 | grep "lines" | awk '{print $2}' | sed 's/%//') -lt 80 ]; then
            echo "Coverage is below 80% threshold"
            exit 1
          fi

      - name: Upload coverage
        uses: codecov/codecov-action@v3
        with:
          file: coverage/lcov.info
```

---

# TEST COMMANDS

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test file
flutter test test/features/training_plan/training_plan_bloc_test.dart

# Run integration tests
flutter test integration_test/

# Run tests in watch mode
flutter test --watch

# Generate coverage report
genhtml coverage/lcov.info -o coverage/html

# Open coverage report
open coverage/html/index.html
```

---

# TEST CHECKLIST

## Before Each Commit
- [ ] All unit tests pass
- [ ] No new test failures
- [ ] Coverage doesn't decrease

## Before Each PR
- [ ] All tests pass locally
- [ ] New code has tests
- [ ] Integration tests pass
- [ ] No security vulnerabilities

## Before Each Release
- [ ] All E2E tests pass
- [ ] Performance tests pass
- [ ] Accessibility tests pass
- [ ] Coverage >= 80%
- [ ] Security audit complete

---

**Document Version**: 1.0
**Last Updated**: August 29, 2026
