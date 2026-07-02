import 'package:flutter/foundation.dart';

import '../../../../data/repositories/profile_repository.dart';
import '../../../../domain/models/user_profile.dart';

/// Owns the profile screen state.
///
/// Seeds SYNCHRONOUSLY in the constructor so the UI (and screenshots) render
/// populated content immediately.
class ProfileViewModel extends ChangeNotifier {
  ProfileViewModel({required ProfileRepository repository})
      : _repository = repository {
    _profile = _repository.seed();
  }

  final ProfileRepository _repository;

  late final UserProfile _profile;
  bool _notifications = true;
  bool _darkMode = false;

  UserProfile get profile => _profile;
  bool get notifications => _notifications;
  bool get darkMode => _darkMode;

  void toggleNotifications(bool value) {
    _notifications = value;
    notifyListeners();
  }

  void toggleDarkMode(bool value) {
    _darkMode = value;
    notifyListeners();
  }
}
