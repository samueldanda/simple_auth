import 'package:flutter/foundation.dart';
import 'package:simple_auth/utils/db.dart';

class UserProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  late Map<String, dynamic> _user;
  Map<String, dynamic> get user => _user;

  Future<bool> loginUser(String identifier, String password) async {
    _setLoading(true);
    try {
      await Future.delayed(const Duration(seconds: 1));

      final user = await DatabaseHelper.db.authenticateUser(identifier, password);

      if (user != null) {
        if (kDebugMode) {
          print(user);
        }
        _user = user;
        notifyListeners();
        return true;
      } else {
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

  Future<Map<String, dynamic>?> getUser() async {
    _setLoading(true);
    try {
      var map = await DatabaseHelper.db.getUser();
      if (map!= null) {
        _user = map;
        notifyListeners();
      }
      return map;
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
