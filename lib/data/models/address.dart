
class Address {
  final String id, name, phone, line1, city, state, zip, country;
  final String? line2;
  final bool isDefault;

  const Address({
    required this.id,
    required this.name,
    required this.phone,
    required this.line1,
    this.line2,
    required this.city,
    required this.state,
    required this.zip,
    required this.country,
    this.isDefault = false,
  });

  String get full =>
      '$line1${line2 != null ? ', $line2' : ''}, $city, $state $zip, $country';
  String get short => '$line1, $city';
}
