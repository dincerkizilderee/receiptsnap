import 'package:hive_flutter/hive_flutter.dart';
import '../models/receipt.dart';
import '../core/constants.dart';

class HiveService {
  static const String _boxName = AppConstants.hiveBoxName;

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ReceiptAdapter());
    await Hive.openBox<Receipt>(_boxName);
  }

  Box<Receipt> get receiptBox => Hive.box<Receipt>(_boxName);

  Future<void> addReceipt(Receipt receipt) async {
    await receiptBox.put(receipt.id, receipt);
  }

  Future<void> deleteReceipt(String id) async {
    await receiptBox.delete(id);
  }

  List<Receipt> getAllReceipts() {
    return receiptBox.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }
}
