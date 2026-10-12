class CurrencyFormatter {
  CurrencyFormatter._();

  /// Format angka integer ke dalam format Rupiah Indonesia, contoh: Rp100.000
  static String formatRupiah(int amount) {
    if (amount < 0) {
      return '-${formatRupiah(-amount)}';
    }
    final String amountStr = amount.toString();
    final StringBuffer buffer = StringBuffer();
    int count = 0;
    for (int i = amountStr.length - 1; i >= 0; i--) {
      buffer.write(amountStr[i]);
      count++;
      if (count % 3 == 0 && i != 0) {
        buffer.write('.');
      }
    }
    return 'Rp${buffer.toString().split('').reversed.join()}';
  }
}
