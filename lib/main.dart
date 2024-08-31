import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:simple_auth/providers/language_provider.dart';
import 'package:simple_auth/providers/theme_provider.dart';
import 'package:simple_auth/providers/user_provider.dart';
import 'package:simple_auth/routes/route_generator.dart';
import 'package:simple_auth/utils/check_device.dart';
import 'package:simple_auth/utils/db.dart';
import 'package:simple_auth/utils/theme.dart';
import 'package:simple_auth/app_lifecycle_observer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:simple_auth/views/device_unsafe.dart';

import 'config/localization/localications.dart';
import 'config/theme.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  DatabaseHelper.db.initDatabase();

  bool isDeviceSafe = await checkDeviceIsSafe();
  if (!isDeviceSafe) {
    runApp(const DeviceUnsafeApp());
  } else {
    runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ChangeNotifierProvider(create: (context) => LanguageProvider()),
      ChangeNotifierProvider(create: (context) => UserProvider()),
    ], child: const SimpleAuthApp()));
  }

}

class MyApp {
  const MyApp();
}

class SimpleAuthApp extends StatelessWidget {
  const SimpleAuthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, LanguageProvider>(
      builder: (context, themeProvider, languageProvider, child) {
        // final brightness =
        //     View.of(context).platformDispatcher.platformBrightness;

        TextTheme textTheme = createTextTheme(context, "Open Sans", "Poppins");
        MaterialTheme theme = MaterialTheme(textTheme);

        final themeMode = themeProvider.themeMode;

        final locale = languageProvider.locale;

        return MaterialApp(
          title: 'Simple Auth',
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          theme: themeMode == ThemeMode.light ? theme.light() : theme.dark(),
          locale: locale,
          localizationsDelegates: const [
            AppLocalizations.delegate, // Ensure this line is present
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English
            Locale('sw', ''), // Swahili
          ],
          initialRoute: '/',
          onGenerateRoute: RouteGenerator.generateRoute,
          builder: (context, child) {
            return AppLifecycleObserver(child: child!);
          },
        );
      },
    );
  }
}
