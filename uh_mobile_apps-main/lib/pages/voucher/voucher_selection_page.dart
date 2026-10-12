import 'package:flutter/material.dart';
import '../../data/voucher_data.dart';
import '../../models/voucher.dart';
import '../../utils/app_colors.dart';
import '../../widgets/voucher_item.dart';

/// Hasil kembalian dari VoucherSelectionPage
class VoucherSelectionResult {
  final Voucher? voucher;
  final bool isCleared;

  const VoucherSelectionResult.apply(Voucher this.voucher) : isCleared = false;
  const VoucherSelectionResult.clear() : voucher = null, isCleared = true;
}

class VoucherSelectionPage extends StatefulWidget {
  final Voucher? currentVoucher;

  const VoucherSelectionPage({
    super.key,
    this.currentVoucher,
  });

  @override
  State<VoucherSelectionPage> createState() => _VoucherSelectionPageState();
}

class _VoucherSelectionPageState extends State<VoucherSelectionPage> {
  Voucher? _selectedVoucher;

  @override
  void initState() {
    super.initState();
    _selectedVoucher = widget.currentVoucher;
  }

  void _applyVoucher(Voucher voucher) {
    Navigator.pop(context, VoucherSelectionResult.apply(voucher));
  }

  void _clearVoucher() {
    Navigator.pop(context, const VoucherSelectionResult.clear());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Pilih Voucher Diskon',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: AppColors.border,
            height: 1,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const Text(
                    'Pilihan Voucher',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Voucher items list
                  ...sampleVouchers.map((voucher) {
                    final bool isSelected = _selectedVoucher?.id == voucher.id;
                    return VoucherItem(
                      voucher: voucher,
                      isSelected: isSelected,
                      onTap: () {
                        setState(() {
                          _selectedVoucher = voucher;
                        });
                      },
                    );
                  }),
                  // Clear Voucher option
                  if (widget.currentVoucher != null || _selectedVoucher != null) ...[
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: _clearVoucher,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.remove_circle_outline,
                                  color: AppColors.discountRed,
                                  size: 20,
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Hapus Voucher',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.discountRed,
                                        ),
                                      ),
                                      Text(
                                        'Gunakan harga asli tanpa diskon',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            // Bottom Action Bar
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                border: Border(
                  top: BorderSide(color: AppColors.border),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _selectedVoucher == null
                      ? null
                      : () => _applyVoucher(_selectedVoucher!),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    disabledBackgroundColor: AppColors.border,
                    foregroundColor: Colors.white,
                    disabledForegroundColor: AppColors.textSecondary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    _selectedVoucher != null
                        ? 'Terapkan ${_selectedVoucher!.name}'
                        : 'Pilih Voucher',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
