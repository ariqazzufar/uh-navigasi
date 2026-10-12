class Voucher {
  final String id;
  final String name;
  final int discountPercentage;
  final String description;

  const Voucher({
    required this.id,
    required this.name,
    required this.discountPercentage,
    required this.description,
  });

  /// Menghitung jumlah potongan diskon: originalPrice * discountPercentage / 100
  int calculateDiscount(int originalPrice) {
    return (originalPrice * discountPercentage / 100).round();
  }

  /// Menghitung harga akhir setelah potongan diskon: originalPrice - discountAmount
  int calculateFinalPrice(int originalPrice) {
    return originalPrice - calculateDiscount(originalPrice);
  }
}
