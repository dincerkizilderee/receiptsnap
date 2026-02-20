import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants.dart';
import '../models/receipt.dart';
import 'receipts_provider.dart';

final categoryTotalsProvider = Provider<Map<String, double>>((ref) {
  final receipts = ref.watch(receiptsProvider);
  final totals = <String, double>{};

  for (final category in AppConstants.categories) {
    totals[category] = 0.0;
  }

  for (final receipt in receipts) {
    totals[receipt.category] =
        (totals[receipt.category] ?? 0.0) + receipt.totalAmount;
  }

  return totals;
});

final totalSpendingProvider = Provider<double>((ref) {
  final receipts = ref.watch(receiptsProvider);
  return receipts.fold(0.0, (sum, r) => sum + r.totalAmount);
});

final receiptsByCategoryProvider =
    Provider<Map<String, List<Receipt>>>((ref) {
  final receipts = ref.watch(receiptsProvider);
  final grouped = <String, List<Receipt>>{};

  for (final category in AppConstants.categories) {
    final categoryReceipts =
        receipts.where((r) => r.category == category).toList();
    if (categoryReceipts.isNotEmpty) {
      grouped[category] = categoryReceipts;
    }
  }

  return grouped;
});
