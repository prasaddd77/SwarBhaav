import 'package:flutter/widgets.dart';
import 'package:voicesenti/home/home_screen.dart';
import 'package:voicesenti/info/info_screen.dart';
import 'package:voicesenti/newfeatures/new_features_screen.dart';
import 'package:voicesenti/sign_in/sign_in_screen.dart';
import 'package:voicesenti/splash_screen.dart';
import 'package:voicesenti/statistics/stats_screen.dart';

import 'history/history_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName : (context) => const SplashScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  HomeScreen.routeName:(context) => const HomeScreen(),
  HistoryScreen.routeName : (context) => const HistoryScreen(),
  StatsScreen.routeName : (context) => const StatsScreen(),
  InfoScreen.routeName : (context) => const InfoScreen(),
  ComingSoonPage.routeName :(context) =>  const ComingSoonPage(),
};