import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/receipt.dart';
import '../services/gemini_service.dart';
import '../services/hive_service.dart';

// --- Service Providers ---

final hiveServiceProvider = Provider<HiveService>((ref) {
  return HiveService();
});

final geminiServiceProvider = Provider<GeminiService>((ref) {
  return GeminiService();
});

// --- Receipts State ---

final receiptsProvider = StateNotifierProvider<ReceiptsNotifier, List<Receipt>>((ref) {
  final hiveService = ref.watch(hiveServiceProvider);
  return ReceiptsNotifier(hiveService);
});

class ReceiptsNotifier extends StateNotifier<List<Receipt>> {
  final HiveService _hiveService;

  ReceiptsNotifier(this._hiveService) : super([]) {
    _loadReceipts();
  }

  void _loadReceipts() {
    state = _hiveService.getAllReceipts();
  }

  Future<void> addReceipt(Receipt receipt) async {
    await _hiveService.addReceipt(receipt);
    _loadReceipts();
  }

  Future<void> deleteReceipt(String id) async {
    await _hiveService.deleteReceipt(id);
    _loadReceipts();
  }
}
