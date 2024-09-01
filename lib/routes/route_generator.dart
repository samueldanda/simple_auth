import 'package:flutter/material.dart';
import 'package:simple_auth/views/device_unsafe.dart';
import 'package:simple_auth/views/lock_screen.dart';
import 'package:simple_auth/views/login_screen.dart';
import 'package:simple_auth/views/profile_screen.dart';
import 'package:simple_auth/views/registration_screen.dart';
import 'routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.register:
        return MaterialPageRoute(builder: (_) => const RegistrationScreen());
      case Routes.deviceUnsafe:
        return MaterialPageRoute(builder: (_) => const DeviceUnsafeApp());
      case Routes.lockScreen:
        return MaterialPageRoute(builder: (_) => const LockScreen());
      case Routes.profile:
        final args = settings.arguments as Map<String, dynamic>;
        final user = args['user'] as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) => ProfileScreen(user: user));
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text('Error')),
          body: const Center(child: Text('Page not found')),
        );
      },
    );
  }
}
