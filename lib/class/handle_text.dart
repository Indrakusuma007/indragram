import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

// Formatter untuk mengubah semua huruf menjadi kapital
class FormatterHurufBesar extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.copyWith(
      text: newValue.text.toUpperCase(), // Mengubah semua huruf ke kapital
      selection: newValue.selection,
    );
  }
}

// Formatter untuk mengubah huruf pertama dari setiap kata menjadi kapital
class FormatterKataKapital extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text
        .split(' ') // Pisahkan kata-kata dengan spasi
        .map((word) {
      if (word.isEmpty) return word; // Jika kata kosong, kembalikan kata kosong
      return word[0].toUpperCase() + word.substring(1); // Huruf pertama kapital
    }).join(' '); // Gabungkan kembali kata-kata tersebut

    return newValue.copyWith(
      text: newText,
      selection: newValue.selection,
    );
  }
}

// Formatter untuk mengubah huruf pertama dari teks menjadi kapital dan sisanya menjadi huruf kecil
class FormatterHurufPertamaKapital extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;

    if (newText.isNotEmpty) {
      // Mengubah huruf pertama menjadi kapital, sisanya menjadi huruf kecil
      newText = newText[0].toUpperCase() + newText.substring(1).toLowerCase();
    }

    return newValue.copyWith(
      text: newText,
      selection: newValue.selection,
    );
  }
}

// Formatter untuk hanya mengizinkan huruf, angka, dan spasi
class FormatterHanyaAlfanumerikDanSpasi extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Hanya mengizinkan huruf, angka, dan spasi
    String filteredText = newValue.text.replaceAll(RegExp(r'[^a-zA-Z0-9 ]'), '');

    // Hitung posisi pemilihan baru
    int selectionIndex = newValue.selection.start;

    // Jika teks telah difilter, kita harus memastikan selection tidak keluar dari panjang teks
    if (filteredText.length < selectionIndex) {
      selectionIndex = filteredText.length; // Atur ke panjang filteredText jika lebih besar
    }

    return newValue.copyWith(
      text: filteredText,
      selection: TextSelection.collapsed(offset: selectionIndex), // Atur posisi selection
    );
  }
}

// Formatter untuk hanya mengizinkan huruf dan angka tanpa spasi
class FormatterHanyaAlfanumerikTanpaSpasi extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Hanya mengizinkan huruf dan angka, tanpa spasi
    String filteredText = newValue.text.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');

    // Hitung posisi pemilihan baru
    int selectionIndex = newValue.selection.start;

    // Jika teks telah difilter, kita harus memastikan selection tidak keluar dari panjang teks
    if (filteredText.length < selectionIndex) {
      selectionIndex = filteredText.length; // Atur ke panjang filteredText jika lebih besar
    }

    return newValue.copyWith(
      text: filteredText,
      selection: TextSelection.collapsed(offset: selectionIndex), // Atur posisi selection
    );
  }
}

// Formatter untuk hanya mengizinkan angka
class FormatterHanyaAngka extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Hanya mengizinkan angka
    String filteredText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Hitung posisi pemilihan baru
    int selectionIndex = newValue.selection.start;

    // Jika teks telah difilter, kita harus memastikan selection tidak keluar dari panjang teks
    if (filteredText.length < selectionIndex) {
      selectionIndex = filteredText.length; // Atur ke panjang filteredText jika lebih besar
    }

    return newValue.copyWith(
      text: filteredText,
      selection: TextSelection.collapsed(offset: selectionIndex), // Atur posisi selection
    );
  }
}

// Formatter untuk hanya mengizinkan angka, tanpa angka 0 di awal
class FormatterHanyaAngkaTanpaNolAwal extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Hanya mengizinkan angka
    String filteredText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Jika teks tidak kosong dan diawali dengan 0, hapus 0 di awal
    if (filteredText.isNotEmpty && filteredText.startsWith('0')) {
      filteredText = filteredText.replaceFirst('0', '');
    }

    // Hitung posisi pemilihan baru
    int selectionIndex = newValue.selection.start;

    // Jika teks telah difilter, kita harus memastikan selection tidak keluar dari panjang teks
    if (filteredText.length < selectionIndex) {
      selectionIndex = filteredText.length; // Atur ke panjang filteredText jika lebih besar
    }

    return newValue.copyWith(
      text: filteredText,
      selection: TextSelection.collapsed(offset: selectionIndex), // Atur posisi selection
    );
  }
}

class FormatterTanpaSpasiAwal extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Hapus spasi di awal
    String filteredText = newValue.text.replaceFirst(RegExp(r'^\s+'), '');

    // Hitung posisi pemilihan baru
    int selectionIndex = newValue.selection.start;

    // Pastikan posisi selection tidak keluar dari panjang teks
    if (filteredText.length < selectionIndex) {
      selectionIndex = filteredText.length;
    }

    return newValue.copyWith(
      text: filteredText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

class RupiahFormatter extends TextInputFormatter {
  final NumberFormat currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Hapus simbol rupiah dan titik pemisah ribuan sebelum memformat ulang
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (newText.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Format menjadi Rupiah
    String formattedText = currencyFormatter.format(int.parse(newText));

    // Kembalikan nilai yang terformat
    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
