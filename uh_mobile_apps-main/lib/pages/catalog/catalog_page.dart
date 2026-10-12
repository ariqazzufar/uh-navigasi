import 'package:flutter/material.dart';
import '../../data/product_data.dart';
import '../../models/product.dart';
import '../../utils/app_colors.dart';
import '../../widgets/product_card.dart';
import '../product_detail/product_detail_page.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  void _navigateToDetail(BuildContext context, Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailPage(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Katalog Produk',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: AppColors.border,
            height: 1,
          ),
        ),
      ),
      body: SafeArea(
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.70,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: sampleProducts.length,
          itemBuilder: (context, index) {
            final product = sampleProducts[index];
            return ProductCard(
              product: product,
              onTap: () => _navigateToDetail(context, product),
            );
          },
        ),
      ),
    );
  }
}
