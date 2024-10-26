import 'package:intl/intl.dart';

String formatRupiah(int value) {
  final formatCurrency = NumberFormat.currency(
    locale: 'id_ID', // Set locale to Indonesian
    symbol: '', // Currency symbol
    decimalDigits: 0, // No decimal digits
  );
  return formatCurrency.format(value);
}
