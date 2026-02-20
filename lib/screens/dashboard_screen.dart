import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/theme.dart';
import '../providers/dashboard_providers.dart';
import '../providers/receipts_provider.dart';
import '../widgets/category_card.dart';
import '../widgets/expense_pie_chart.dart';
import '../widgets/receipt_tile.dart';
import '../widgets/total_card.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalSpending = ref.watch(totalSpendingProvider);
    final receiptsByCategory = ref.watch(receiptsByCategoryProvider);
    final categoryTotals = ref.watch(categoryTotalsProvider);
    final allReceipts = ref.watch(receiptsProvider);

    return Scaffold(
      backgroundColor: AppTheme.scaffoldBg,
      body: SafeArea(
        child: allReceipts.isEmpty
            ? _buildEmptyState()
            : _buildContent(
                ref,
                totalSpending,
                receiptsByCategory,
                categoryTotals,
                allReceipts.length,
              ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppTheme.cardBg,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.receipt_long_rounded, size: 40, color: AppTheme.textMuted),
            ),
            const SizedBox(height: 24),
            const Text(
              'Henuz fis kaydi yok',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Ilk fisinizi taramak icin\nkamera sekmesine gecin.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: AppTheme.textMuted, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(
    WidgetRef ref,
    double totalSpending,
    Map<String, List<dynamic>> receiptsByCategory,
    Map<String, double> categoryTotals,
    int receiptCount,
  ) {
    return CustomScrollView(
      slivers: [
        // Header
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Merhaba',
                  style: TextStyle(
                    color: AppTheme.textMuted,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Harcama Ozeti',
                  style: TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 20)),

        // Total card
        SliverToBoxAdapter(
          child: TotalCard(totalSpending: totalSpending, receiptCount: receiptCount),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 24)),

        // Pie chart
        SliverToBoxAdapter(
          child: ExpensePieChart(categoryTotals: categoryTotals, totalSpending: totalSpending),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 24)),

        // Categories header
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(Icons.category_rounded, color: AppTheme.accentLight, size: 20),
                SizedBox(width: 8),
                Text(
                  'Kategoriler',
                  style: TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 12)),

        // Category cards
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final entries = receiptsByCategory.entries.toList();
              final entry = entries[index];
              final percentage = totalSpending > 0
                  ? ((categoryTotals[entry.key] ?? 0) / totalSpending) * 100
                  : 0.0;
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: CategoryCard(
                  category: entry.key,
                  receipts: entry.value.cast(),
                  total: categoryTotals[entry.key] ?? 0.0,
                  percentage: percentage,
                ),
              );
            }, childCount: receiptsByCategory.length),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 24)),

        // Recent transactions header
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(Icons.history_rounded, color: AppTheme.accentLight, size: 20),
                SizedBox(width: 8),
                Text(
                  'Son Islemler',
                  style: TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 12)),

        // Recent transactions
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final allReceipts = receiptsByCategory.values
                    .expand((list) => list.cast<dynamic>())
                    .toList();
                // Sort by createdAt desc
                allReceipts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
                final receipt = allReceipts[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ReceiptTile(
                    receipt: receipt,
                    onDismissed: () {
                      ref.read(receiptsProvider.notifier).deleteReceipt(receipt.id);
                    },
                  ),
                );
              },
              childCount: receiptsByCategory.values.fold<int>(0, (sum, list) => sum + list.length),
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }
}
