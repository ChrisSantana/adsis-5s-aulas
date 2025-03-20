import 'package:flutter/material.dart';

abstract interface class IAppService {
  Future<Object?> navigateNamedTo(String routeName, {Object? arguments});
  Future<Object?> navigateNamedReplacementTo(String routeName, {Object? arguments});
  Future<Object?> navigatePushNamedAndRemoveUntil(String routeName, {bool Function(Route<dynamic>)? predicate});
  Future<Object?> navigatePushReplecementTo(Widget widget);
  Future<Object?> navigateTo(Widget widget);
  Future<Object?> navigateReplacementTo(Widget widget);
  Future<Object?> navigatePushAndRemoveUntil(Widget widget);
  void navigatePop([Object? object]);
  BuildContext? get context;
  GlobalKey<NavigatorState> get navigatorKey;
}

final class AppService implements IAppService {
  final GlobalKey<NavigatorState> _navigatorKey;

  const AppService(
    this._navigatorKey,
  );

  @override
  Future<dynamic> navigateNamedTo(String routeName, {Object? arguments}) async {
    return navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  @override
  Future<dynamic> navigateNamedReplacementTo(String routeName, {Object? arguments}) async {
    return navigatorKey.currentState?.pushReplacementNamed(routeName, arguments: arguments);
  }

  @override
  Future<dynamic> navigatePushNamedAndRemoveUntil(String routeName, {bool Function(Route<dynamic>)? predicate}) async {
    return navigatorKey.currentState?.pushNamedAndRemoveUntil(routeName, predicate ?? (_) => false);
  }

  @override
  Future<dynamic> navigatePushReplecementTo(Widget widget) async {
    return navigatorKey.currentState?.pushReplacement(_pageRoute(widget));
  }

  @override
  Future<dynamic> navigateTo(Widget widget) async {
    return navigatorKey.currentState?.push(_pageRoute(widget));
  }

  @override
  Future<dynamic> navigateReplacementTo(Widget widget) async {
    return navigatorKey.currentState?.pushReplacement(_pageRoute(widget));
  }

  @override
  Future<dynamic> navigatePushAndRemoveUntil(Widget widget) async {
    return navigatorKey.currentState?.pushAndRemoveUntil(_pageRoute(widget), (_) {
      return false;
    });
  }

  @override
  void navigatePop([Object? object]) {
    return navigatorKey.currentState?.pop(object);
  }

  MaterialPageRoute _pageRoute(Widget widget) {
    return MaterialPageRoute(
      builder: (context) => widget,
    );
  }

  @override
  BuildContext? get context => navigatorKey.currentState?.overlay?.context;

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
}
