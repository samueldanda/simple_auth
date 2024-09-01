import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_auth/config/localization/localications.dart';
import 'package:simple_auth/providers/user_provider.dart';
import 'package:simple_auth/routes/routes.dart';

class LockScreen extends StatefulWidget {
  const LockScreen({super.key});

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  Timer? _timer;
  Duration _timeLeft = Duration.zero;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    _updateTimeLeft(userProvider);
    _startTimer(userProvider);
  }

  void _updateTimeLeft(UserProvider userProvider) {
    setState(() {
      _timeLeft = userProvider.timeLeft;
    });
  }

  void _startTimer(UserProvider userProvider) {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final newTimeLeft = userProvider.timeLeft - const Duration(seconds: 1);
      if (newTimeLeft <= Duration.zero) {
        timer.cancel();
        Navigator.pushReplacementNamed(
            context, Routes.login); // Adjust the route as needed
      } else {
        setState(() {
          _timeLeft = newTimeLeft;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatDuration(Duration duration, Locale locale) {
    final days = duration.inDays;
    final hours = duration.inHours % 24;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;

    return locale.languageCode == 'sw'
        ? 'Siku $days, Saa $hours, Dakika $minutes, Sekunde $seconds'
        : '$days d $hours h $minutes m $seconds s';
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    final locale2 = Localizations.localeOf(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Theme.of(context).colorScheme.error, Colors.orangeAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 32.0, horizontal: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.lock_outline,
                      size: 80,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      locale!.translate('app_locked'),
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      locale.translate('time_left'),
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                      child: Text(
                        _formatDuration(_timeLeft, locale2),
                        key: ValueKey<String>(
                            _formatDuration(_timeLeft, locale2)),
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Optional: Add a button or other interactive elements
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
