import 'package:flutter/material.dart';

class AppConstants {
  AppConstants._();

  static const String appName = 'ReceiptSnap';
  static const String hiveBoxName = 'receipts';

  static const List<String> categories = ['Yemek', 'Market', 'Ulaşım', 'Ofis', 'Yazılım', 'Diğer'];

  static const Map<String, List<String>> categoryKeywords = {
    'Yemek': [
      'restoran',
      'cafe',
      'kafe',
      'yemek',
      'restaurant',
      'food',
      'pizza',
      'burger',
      'lokanta',
      'pastane',
      'bakery',
      'kebap',
      'döner',
      'starbucks',
      'mcdonalds',
      'kahve',
      'coffee',
      'gida',
    ],
    'Market': [
      'market',
      'migros',
      'bim',
      'a101',
      'sok',
      'carrefour',
      'gross',
      'file',
      'happy',
      'metro market',
      'makro',
      'kim',
      'groseri',
      'supermarket',
    ],
    'Ulaşım': [
      'taksi',
      'uber',
      'benzin',
      'petrol',
      'taxi',
      'opet',
      'shell',
      'bp',
      'metro',
      'otobus',
      'bilet',
      'otopark',
      'parking',
      'fuel',
      'gas',
      'total',
      'turkuaz',
    ],
    'Ofis': [
      'kirtasiye',
      'kagit',
      'office',
      'kalem',
      'toner',
      'yazici',
      'printer',
      'mobilya',
      'furniture',
      'stationery',
      'paper',
    ],
    'Yazılım': [
      'google',
      'aws',
      'github',
      'hosting',
      'domain',
      'software',
      'apple',
      'microsoft',
      'netflix',
      'spotify',
      'adobe',
      'subscription',
      'saas',
      'cloud',
      'server',
      'digital',
      'heroku',
      'vercel',
      'figma',
      'notion',
      'slack',
    ],
  };

  static const Map<String, Color> categoryColors = {
    'Yemek': Color(0xFFFF6B6B),
    'Market': Color(0xFF22C55E),
    'Ulaşım': Color(0xFF4ECDC4),
    'Ofis': Color(0xFF45B7D1),
    'Yazılım': Color(0xFFA78BFA),
    'Diğer': Color(0xFF9CA3AF),
  };

  static const Map<String, IconData> categoryIcons = {
    'Yemek': Icons.restaurant_rounded,
    'Market': Icons.shopping_cart_rounded,
    'Ulaşım': Icons.directions_car_rounded,
    'Ofis': Icons.business_center_rounded,
    'Yazılım': Icons.code_rounded,
    'Diğer': Icons.receipt_long_rounded,
  };
}
