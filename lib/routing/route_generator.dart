import 'package:flutter/material.dart';
import 'package:order_manager/configs/injection_container.dart';
import 'package:order_manager/core/service/app_service.dart';

final class RouteGeneratorHelper {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    return switch (settings.name) {
      kInitial => createRoutePage(
        Scaffold(
          body: Center(
            child: Text('Hello World!'),
          ),
        ),
      ),
      _ => createRouteError(),
    };
  }

  static PageRoute createRoutePage(Widget widget) {
    return MaterialPageRoute(
      builder: (context) => widget,
    );
  }

  static Route<dynamic> createRouteError() {
    const String msg = 'Error Route';
    return MaterialPageRoute(
      builder: (context) {
        return const Scaffold(
          body: Center(
            child: Text(msg),
          ),
        );
      },
    );
  }

  static const String kInitial = '/';

  static void onRouteInitialization(String route) {
    if (route.isNotEmpty) getIt<IAppService>().navigateNamedReplacementTo(route);
  }
}
