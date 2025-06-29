import 'package:flutter_riverpod/flutter_riverpod.dart';

final sessionProvider = StateNotifierProvider<SessionNotifier, String?>((ref) {
  return SessionNotifier();
});

class SessionNotifier extends StateNotifier<String?> {
  SessionNotifier() : super(null);

  void startSession(String id) => state = id;
  void clearSession() => state = null;
}
