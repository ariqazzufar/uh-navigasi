import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uh_mobile_apps/app.dart';
import 'package:uh_mobile_apps/data/product_data.dart';
import 'package:uh_mobile_apps/data/voucher_data.dart';
import 'package:uh_mobile_apps/models/voucher.dart';
import 'package:uh_mobile_apps/utils/currency_formatter.dart';

void main() {
  group('Price Calculation & Formatter Tests', () {
    test('CurrencyFormatter formats numbers to Indonesian Rupiah', () {
      expect(CurrencyFormatter.formatRupiah(100000), 'Rp100.000');
      expect(CurrencyFormatter.formatRupiah(90000), 'Rp90.000');
      expect(CurrencyFormatter.formatRupiah(80000), 'Rp80.000');
      expect(CurrencyFormatter.formatRupiah(2500000), 'Rp2.500.000');
      expect(CurrencyFormatter.formatRupiah(0), 'Rp0');
    });

    test('Voucher 10% calculation matches specification formula', () {
      const voucher10 = Voucher(
        id: 'V10',
        name: 'Voucher 10%',
        discountPercentage: 10,
        description: 'Test 10%',
      );
      const originalPrice = 100000;
      final discount = voucher10.calculateDiscount(originalPrice);
      final finalPrice = voucher10.calculateFinalPrice(originalPrice);

      expect(discount, 10000);
      expect(finalPrice, 90000);
      expect(originalPrice, 100000);
    });

    test('Voucher 20% calculation matches specification formula', () {
      const voucher20 = Voucher(
        id: 'V20',
        name: 'Voucher 20%',
        discountPercentage: 20,
        description: 'Test 20%',
      );
      const originalPrice = 100000;
      final discount = voucher20.calculateDiscount(originalPrice);
      final finalPrice = voucher20.calculateFinalPrice(originalPrice);

      expect(discount, 20000);
      expect(finalPrice, 80000);
      expect(originalPrice, 100000);
    });

    test('Sample data contains valid vouchers and products', () {
      expect(sampleVouchers.length, 2);
      expect(sampleVouchers[0].discountPercentage, 10);
      expect(sampleVouchers[1].discountPercentage, 20);

      expect(sampleProducts.isNotEmpty, true);
      for (final p in sampleProducts) {
        expect(p.price, greaterThan(0));
        expect(p.name.isNotEmpty, true);
        expect(p.category.isNotEmpty, true);
      }
    });
  });

  group('Widget Navigation & Flow Tests', () {
    testWidgets('App opens on LoginPage and navigates to Dashboard', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(const MyApp());
      await tester.pump();

      // Check Login page elements
      expect(find.text('Katalog Produk'), findsOneWidget);
      expect(find.text('Masuk'), findsOneWidget);

      // Tap Login button
      await tester.tap(find.text('Masuk'));
      await tester.pumpAndSettle();

      // Verifies Dashboard is reached
      expect(find.text('Katalog Produk'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);

      // Switch tab to Profile
      await tester.tap(find.byIcon(Icons.person_outline_rounded));
      await tester.pumpAndSettle();

      // Verifies Profile page elements
      expect(find.text('Profil'), findsOneWidget);
      expect(find.text('Ahmad Fajar'), findsOneWidget);
      expect(find.text('Keluar'), findsOneWidget);

      // Switch back to Katalog
      await tester.tap(find.byIcon(Icons.storefront_outlined));
      await tester.pumpAndSettle();

      expect(find.text('Katalog Produk'), findsOneWidget);
    });

    testWidgets('Catalog to Detail, claim 10% voucher, switch to 20%, remove voucher, and back', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(const MyApp());
      await tester.pump();

      // Login
      await tester.tap(find.text('Masuk'));
      await tester.pumpAndSettle();

      // Tap on first product
      final productFinder = find.text('Wireless Headphones ANC');
      expect(productFinder, findsOneWidget);
      await tester.tap(productFinder);
      await tester.pumpAndSettle();

      // On Product Detail Page
      expect(find.text('Detail Produk'), findsOneWidget);
      expect(find.text('Belum ada voucher yang digunakan'), findsOneWidget);

      // Scroll down to bring voucher section clearly into view
      await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -250));
      await tester.pumpAndSettle();

      // Tap Claim Diskon Voucher
      await tester.tap(find.text('Claim Diskon Voucher'));
      await tester.pumpAndSettle();

      // On Voucher Selection Page
      expect(find.text('Pilih Voucher Diskon'), findsOneWidget);
      expect(find.text('Voucher Diskon 10%'), findsOneWidget);
      expect(find.text('Voucher Diskon 20%'), findsOneWidget);

      // Select 10% voucher
      await tester.tap(find.text('Voucher Diskon 10%'));
      await tester.pump();

      // Apply voucher
      await tester.tap(find.text('Terapkan Voucher Diskon 10%'));
      await tester.pumpAndSettle();

      // Back on Detail Page: verify discount applied
      expect(find.text('Rp90.000'), findsAtLeastNWidgets(1));
      expect(find.text('-10%'), findsOneWidget);
      expect(find.text('Ganti Voucher Diskon'), findsOneWidget);

      // Ensure voucher section is visible then switch voucher to 20%
      await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -250));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Ganti Voucher Diskon'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Voucher Diskon 20%'));
      await tester.pump();

      await tester.tap(find.text('Terapkan Voucher Diskon 20%'));
      await tester.pumpAndSettle();

      // Verify 20% discount applied
      expect(find.text('Rp80.000'), findsAtLeastNWidgets(1));
      expect(find.text('-20%'), findsOneWidget);

      // Remove voucher
      await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -250));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('remove_voucher_btn')));
      await tester.pumpAndSettle();

      // Verify returned to original price
      expect(find.text('Belum ada voucher yang digunakan'), findsOneWidget);
      expect(find.text('Claim Diskon Voucher'), findsOneWidget);

      // Tap back button
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      // Verify back in Catalog
      expect(find.text('Katalog Produk'), findsOneWidget);
    });
  });
}
