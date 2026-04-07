import 'package:intl/intl.dart';

extension CurrencyFormatter on num {
  /// Formats the weight or currency in LKR.
  /// Example: 15497.0 -> LKR 15,497
  String formatPrice() {
    final format = NumberFormat("#,##0", "en_LK");
    return "LKR ${format.format(this)}";
  }
}
