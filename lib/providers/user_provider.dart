import 'package:flutter/foundation.dart';
import 'package:simple_auth/utils/db.dart';

class UserProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  late Map<String, dynamic> _user;
  Map<String, dynamic> get user => _user;

  int _loginAttempts = 0;
  int get loginAttempts => _loginAttempts;

  DateTime? _lockUntil;

  final Duration _lockDuration = const Duration(minutes: 30);

  final int _maxAttempts = 5;
  int get maxAttempts => _maxAttempts;

  UserProvider() {
    _loadLoginAttempts();
    _loadLockInfo();
  }

  // Retrieve stored lock information if the app was previously locked
  Future<void> _loadLockInfo() async {
    final lockUntilString = await DatabaseHelper.db.getValueForKey('lock_until');
    if (lockUntilString != null) {
      _lockUntil = DateTime.parse(lockUntilString);
      // Check if the lock period has expired
      if (_lockUntil!.isBefore(DateTime.now())) {
        _lockUntil = null;
        await DatabaseHelper.db.deleteKey('lock_until');
        _loginAttempts = 0;
        await DatabaseHelper.db.saveKeyValue('login_attempts', '0'); // Reset login attempts in DB
      }
    }
    notifyListeners();
  }

  // Load login attempts from the database
  Future<void> _loadLoginAttempts() async {
    final attemptsString = await DatabaseHelper.db.getValueForKey('login_attempts');
    _loginAttempts = int.tryParse(attemptsString ?? '0') ?? 0;
    notifyListeners();
  }

  // Save login attempts to the database
  Future<void> _saveLoginAttempts() async {
    await DatabaseHelper.db.saveKeyValue('login_attempts', _loginAttempts.toString());
  }

  Future<bool> loginUser(String identifier, String password) async {
    await _loadLockInfo();

    if (isLocked) {
      // App is locked
      return false;
    }

    _setLoading(true);
    try {
      await Future.delayed(const Duration(seconds: 1));

      final user = await DatabaseHelper.db.authenticateUser(identifier, password);

      if (user != null) {
        _loginAttempts = 0;
        await DatabaseHelper.db.deleteKey('lock_until'); // Reset lock info
        await DatabaseHelper.db.saveKeyValue('login_attempts', '0'); // Reset login attempts in DB
        _user = user;
        notifyListeners();
        return true;
      } else {
        _loginAttempts += 1;
        await _saveLoginAttempts();
        if (_loginAttempts >= _maxAttempts) {
          _lockUntil = DateTime.now().add(_lockDuration);
          await DatabaseHelper.db.saveKeyValue('lock_until', _lockUntil!.toIso8601String());
        }
        notifyListeners();
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      return false;
    } finally {
      _setLoading(false);
    }
  }

  bool get isLocked => _lockUntil != null && _lockUntil!.isAfter(DateTime.now());

  Duration get timeLeft => isLocked ? _lockUntil!.difference(DateTime.now()) : Duration.zero;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> registerUser(String firstName, String lastName, String email,
      String mobileNumber, String password) async {
    _setLoading(true);
    try {
      await Future.delayed(const Duration(seconds: 1));

      final user = await DatabaseHelper.db.insertUser({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'mobileNumber': mobileNumber,
        'password': password,
      });

      if (user) {
        notifyListeners();
        return true;
      } else {
        notifyListeners();
        return false;
      }
    } finally {
      _setLoading(false);
    }
  }
}
