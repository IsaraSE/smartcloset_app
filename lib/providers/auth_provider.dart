import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noir_app/data/models/user.dart';
import 'package:noir_app/data/models/address.dart';

final authProvider =
    AsyncNotifierProvider<AuthNotifier, AppUser?>(AuthNotifier.new);

class AuthNotifier extends AsyncNotifier<AppUser?> {
  @override
  Future<AppUser?> build() async {
    // Simulate auth check — in production, read from secure storage
    await Future.delayed(const Duration(milliseconds: 800));
    return null;
  }

  Future<bool> signIn(String email, String password) async {
    state = const AsyncLoading();
    await Future.delayed(const Duration(seconds: 1));
    if (email.isNotEmpty && password.length >= 6) {
      state = AsyncData(_makeUser(email));
      return true;
    }
    state = const AsyncData(null);
    return false;
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncLoading();
    await Future.delayed(const Duration(seconds: 1));
    state = AsyncData(AppUser(
      id: 'g001',
      name: 'Alex Johnson',
      email: 'alex@gmail.com',
      addresses: [_defaultAddress()],
    ));
  }

  Future<bool> signUp(String name, String email, String password) async {
    state = const AsyncLoading();
    await Future.delayed(const Duration(seconds: 1));
    state = AsyncData(AppUser(
        id: 'u_${DateTime.now().millisecondsSinceEpoch}',
        name: name,
        email: email));
    return true;
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    await Future.delayed(const Duration(milliseconds: 400));
    state = const AsyncData(null);
  }

  AppUser _makeUser(String email) => AppUser(
        id: 'u001',
        name: email
            .split('@')
            .first
            .split('.')
            .map(
                (w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
            .join(' '),
        email: email,
        addresses: [_defaultAddress()],
      );

  Address _defaultAddress() => const Address(
        id: 'a01',
        name: 'Home',
        phone: '+1 234 567 8900',
        line1: '247 Fifth Avenue',
        line2: 'Apt 12B',
        city: 'New York',
        state: 'NY',
        zip: '10001',
        country: 'USA',
        isDefault: true,
      );
}
