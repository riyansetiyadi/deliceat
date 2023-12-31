import 'dart:convert';
import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:deliceat/common/navigation.dart';
import 'package:deliceat/data/api/api_service.dart';
import 'package:deliceat/data/db/database_helper.dart';
import 'package:deliceat/data/model/restaurant.dart';
import 'package:deliceat/data/preferences/preferences_helper.dart';
import 'package:deliceat/provider/database_provider.dart';
import 'package:deliceat/provider/detail_restaurant_provider.dart';
import 'package:deliceat/provider/list_restaurant_provider.dart';
import 'package:deliceat/provider/preferences_provider.dart';
import 'package:deliceat/provider/review_restaurant_provider.dart';
import 'package:deliceat/provider/scheduling_provider.dart';
import 'package:deliceat/provider/search_restaurant_provider.dart';
import 'package:deliceat/ui/home_page.dart';
import 'package:deliceat/ui/restaurant_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:deliceat/ui/restaurant_list_page.dart';
import 'package:deliceat/ui/restaurant_search_page.dart';
import 'package:deliceat/ui/splash_screen_page.dart';
import 'package:provider/provider.dart';
import 'package:deliceat/utils/background_service.dart';
import 'package:deliceat/utils/notification_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();

  service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  String? selectedNotificationPayload;
  String initialRoute = SplashScreenPage.routeName;
  String? idRestaurant;

  final NotificationAppLaunchDetails? notificationAppLaunchDetails = !kIsWeb &&
          Platform.isLinux
      ? null
      : await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    selectedNotificationPayload =
        notificationAppLaunchDetails!.notificationResponse?.payload;
    if (selectedNotificationPayload != null) {
      var restaurant =
          Restaurant.fromJson(json.decode(selectedNotificationPayload));
      idRestaurant = restaurant.id;
      initialRoute = RestaurantDetailPage.routeName;
    }
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  bool? isFirstLaunchApp = await PreferencesHelper(
          sharedPreferences: SharedPreferences.getInstance())
      .isFirstLaunchApp;

  if (initialRoute == SplashScreenPage.routeName) {
    if (isFirstLaunchApp) {
      initialRoute = SplashScreenPage.routeName;
    } else {
      initialRoute = HomePage.routeName;
    }
  }

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<SearchRestaurantProvider>(
          create: (_) => SearchRestaurantProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider<ListRestaurantProvider>(
          create: (_) => ListRestaurantProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider<ReviewRestaurantProvider>(
          create: (_) => ReviewRestaurantProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider<SchedulingProvider>(
          create: (_) => SchedulingProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(
            create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper())),
      ],
      child: Consumer<PreferencesProvider>(builder: (context, provider, child) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          title: 'DelicEat',
          theme: provider.themeData,
          initialRoute: initialRoute,
          routes: {
            HomePage.routeName: (context) => const HomePage(),
            SplashScreenPage.routeName: (context) => const SplashScreenPage(),
            RestaurantListPage.routeName: (context) =>
                const RestaurantListPage(),
            RestaurantDetailPage.routeName: (context) =>
                ChangeNotifierProvider<DetailRestaurantProvider>(
                  create: (_) => DetailRestaurantProvider(
                      apiService: ApiService(),
                      idRestaurant: ModalRoute.of(context)?.settings.arguments
                              as String? ??
                          idRestaurant ??
                          ''),
                  child: const RestaurantDetailPage(),
                ),
            RestaurantSearchPage.routeName: (context) =>
                const RestaurantSearchPage(),
          },
          builder: (context, child) {
            return CupertinoTheme(
              data: CupertinoThemeData(
                brightness:
                    provider.isDarkTheme ? Brightness.dark : Brightness.light,
              ),
              child: Material(
                child: child,
              ),
            );
          },
        );
      })));
}
