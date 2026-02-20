import 'package:hive/hive.dart';

part 'receipt.g.dart';

@HiveType(typeId: 0)
class Receipt extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String merchantName;

  @HiveField(2)
  final double totalAmount;

  @HiveField(3)
  final String currency;

  @HiveField(4)
  final DateTime date;

  @HiveField(5)
  final String category;

  @HiveField(6)
  final String imagePath;

  @HiveField(7)
  final String rawText;

  @HiveField(8)
  final DateTime createdAt;

  Receipt({
    required this.id,
    required this.merchantName,
    required this.totalAmount,
    required this.currency,
    required this.date,
    required this.category,
    required this.imagePath,
    required this.rawText,
    required this.createdAt,
  });

  Receipt copyWith({
    String? id,
    String? merchantName,
    double? totalAmount,
    String? currency,
    DateTime? date,
    String? category,
    String? imagePath,
    String? rawText,
    DateTime? createdAt,
  }) {
    return Receipt(
      id: id ?? this.id,
      merchantName: merchantName ?? this.merchantName,
      totalAmount: totalAmount ?? this.totalAmount,
      currency: currency ?? this.currency,
      date: date ?? this.date,
      category: category ?? this.category,
      imagePath: imagePath ?? this.imagePath,
      rawText: rawText ?? this.rawText,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
