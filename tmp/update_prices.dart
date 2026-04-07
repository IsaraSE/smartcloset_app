import 'dart:io';

void main() {
  final file = File('/Users/isara/ALL Projects/smartcloset_app/lib/core/constants/mock_data.dart');
  final content = file.readAsStringSync();
  
  final regex = RegExp(r'(price|originalPrice): (\d+(\.\d+)?)');
  
  final updated = content.replaceAllMapped(regex, (m) {
    final key = m.group(1);
    final val = double.parse(m.group(2)!);
    final newVal = (val * 300).round();
    return '$key: $newVal.0';
  });
  
  file.writeAsStringSync(updated);
  print('Successfully updated prices in mock_data.dart');
}
