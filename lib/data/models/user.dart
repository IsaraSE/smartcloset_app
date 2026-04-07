import 'package:aura_app/data/models/address.dart';

class AppUser {
  final String id, name, email;
  final String? photoUrl;
  final List<Address> addresses;

  const AppUser({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    this.addresses = const [],
  });

  Address? get defaultAddress =>
      addresses.where((a) => a.isDefault).firstOrNull ?? addresses.firstOrNull;
}
