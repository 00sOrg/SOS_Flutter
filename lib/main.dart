import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sos/features/auth/viewmodels/login_viewmodel.dart';
import 'package:sos/firebase_options.dart';
import 'package:sos/shared/navigation/app_router.dart';
import 'package:sos/shared/services/push_notification_service.dart';
import 'package:sos/shared/utils/log_util.dart';
import 'package:sos/shared/viewmodels/location_viewmodel.dart';

Future<void> main() async {
  await _initialize();
  runApp(const ProviderScope(child: MyApp()));
}

Future<void> _initialize() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final container = ProviderContainer();
  final pushNotificationService = container.read(pushNotificationProvider);
  await pushNotificationService.preAppInitialization();

  // PushNotificationService pushNotificationService = PushNotificationService();
  // await pushNotificationService.preAppInitialization();

  try {
    await dotenv.load(fileName: '.env');
  } catch (e) {
    LogUtil.e("Could not load .env file: $e");
  }

  await NaverMapSdk.instance.initialize(
    clientId: dotenv.env['NAVER_MAP_API_ID']!,
    onAuthFailed: (ex) {
      LogUtil.e("네이버맵 인증오류 : $ex");
    },
  );

  await Geolocator.checkPermission();
  await Geolocator.requestPermission();
  final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best);

  log('latitude: ${position.latitude}');
  log('longitude: ${position.longitude}');

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future.microtask(() {
      final pushNotificationService = ref.read(pushNotificationProvider);
      pushNotificationService.postAppInitialization(context, ref);
    });
    ref.read(loginViewModelProvider.notifier).checkLoginStatus();
    final locationAsyncValue = ref.watch(locationViewModelProvider);

    return ScreenUtilInit(
        designSize: const Size(393, 852),
        builder: (context, child) {
          return MaterialApp(
            title: 'SOS',
            debugShowCheckedModeBanner: false,
            home: locationAsyncValue.when(
              data: (location) {
                final appRouter = AppRouter(ref);
                return MaterialApp.router(
                  title: 'SOS',
                  routerConfig: appRouter.router(location.adminAddress),
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    fontFamily: 'AppleSD',
                    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text('Error: $error'),
              ),
            ),
            theme: ThemeData(
              fontFamily: 'AppleSD',
            ),
          );
        });
  }
}
