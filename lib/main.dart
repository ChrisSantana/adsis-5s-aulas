import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:order_manager/configs/injection_container.dart' as injector;
import 'package:order_manager/core/service/app_service.dart';
import 'package:order_manager/routing/route_generator.dart';
import 'package:order_manager/utils/util.dart';

void main() async {
  await injector.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale(Util.kLanguageCode, Util.kCountryCode)],
      onGenerateRoute: RouteGeneratorHelper.generateRoute,
      navigatorKey: injector.getIt<IAppService>().navigatorKey,
    );
  }
}
