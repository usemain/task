import 'package:flutter/material.dart';
import 'package:usemain/screens/language/index.dart';
import 'package:usemain/screens/settings/index.dart';
import 'package:usemain/screens/layout/index.dart';
import 'package:usemain/screens/task_record/index.dart';

final Map<String, WidgetBuilder> routeBuilders = {
  '/': (context) => const LayoutScreen(),
  '/TaskRecord': (context) => const TaskRecordScreen(),
  '/Language': (context) => const LanguageScreen(),
  '/Settings': (context) => const SettingsScreen(),
};

Route<dynamic> routes(RouteSettings settings) {
  final routeBuilder = routeBuilders[settings.name];
  final builder = routeBuilder ?? (context) => const LayoutScreen();

  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => builder(context),
    settings: settings,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      var opacityTween = Tween(begin: 0.0, end: 1.0);
      var opacityAnimation = animation.drive(opacityTween);

      return FadeTransition(
        opacity: opacityAnimation,
        child: SlideTransition(
          position: offsetAnimation,
          child: child,
        ),
      );
    },
  );
}
