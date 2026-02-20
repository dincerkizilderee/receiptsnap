import 'dart:convert';
import 'dart:io';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:uuid/uuid.dart';

import '../models/receipt.dart';

class GeminiService {
  static const _uuid = Uuid();

  static const String _apiKey = 'YOUR_API_KEY';

  static const String _prompt = '''
Asagidaki fis gorselini analiz et. Su verileri JSON formatinda dondur:
{
  "total_amount": double,
  "currency": string,
  "date": string (DD/MM/YYYY formatinda),
  "category": string,
  "merchant_name": string
}

Kurallar:
- total_amount: Fisteki TOPLAM tutari (KDV dahil nihai tutar). Virgul yerine nokta kullan (ornek: 427.42).
- currency: Para birimi (TRY, USD, EUR). Bulunamazsa "TRY" yaz.
- date: Fisteki tarih. Bulunamazsa bugunku tarihi yaz.
- merchant_name: Isletme/magaza adi.
- category: Asagidaki seceneklerden SADECE biri olmali:
  * "Yemek" - Restoran, kafe, fast food, gida
  * "Market" - Supermarket, market, gida alisverisi (Migros, Bim, A101, Sok, Carrefour vb.)
  * "Ulasim" - Taksi, benzin, toplu tasima, otopark
  * "Ofis" - Kirtasiye, ofis malzemesi, mobilya
  * "Yazilim" - Dijital abonelik, hosting, yazilim lisansi
  * "Diger" - Yukaridakilere uymayanlar

SADECE JSON dondur, baska hicbir aciklama yazma.
''';

  late final GenerativeModel _model;

  GeminiService() {
    _model = GenerativeModel(model: 'gemini-2.5-flash', apiKey: _apiKey);
  }

  Future<Receipt> analyzeReceipt(String imagePath) async {
    final imageBytes = await File(imagePath).readAsBytes();
    final mimeType = imagePath.toLowerCase().endsWith('.png') ? 'image/png' : 'image/jpeg';

    final content = Content.multi([TextPart(_prompt), DataPart(mimeType, imageBytes)]);

    final response = await _model.generateContent([content]);
    final text = response.text;

    if (text == null || text.trim().isEmpty) {
      throw Exception('Gemini bos yanit dondurdu.');
    }

    return _parseResponse(text, imagePath);
  }

  Receipt _parseResponse(String responseText, String imagePath) {
    // Clean JSON from markdown code blocks if present
    var cleaned = responseText.trim();
    if (cleaned.startsWith('```json')) {
      cleaned = cleaned.substring(7);
    } else if (cleaned.startsWith('```')) {
      cleaned = cleaned.substring(3);
    }
    if (cleaned.endsWith('```')) {
      cleaned = cleaned.substring(0, cleaned.length - 3);
    }
    cleaned = cleaned.trim();

    final Map<String, dynamic> json = jsonDecode(cleaned);

    final totalAmount = (json['total_amount'] is int)
        ? (json['total_amount'] as int).toDouble()
        : (json['total_amount'] as num?)?.toDouble() ?? 0.0;

    final currency = json['currency'] as String? ?? 'TRY';
    final merchantName = json['merchant_name'] as String? ?? 'Bilinmeyen';
    final categoryRaw = json['category'] as String? ?? 'Diger';
    final dateStr = json['date'] as String?;

    // Parse date
    DateTime date = DateTime.now();
    if (dateStr != null) {
      final parts = dateStr.split(RegExp(r'[./\-]'));
      if (parts.length == 3) {
        final day = int.tryParse(parts[0]);
        final month = int.tryParse(parts[1]);
        final year = int.tryParse(parts[2]);
        if (day != null && month != null && year != null) {
          date = DateTime(year < 100 ? 2000 + year : year, month, day);
        }
      }
    }

    // Normalize category
    final category = _normalizeCategory(categoryRaw);

    return Receipt(
      id: _uuid.v4(),
      merchantName: merchantName,
      totalAmount: totalAmount,
      currency: currency,
      date: date,
      category: category,
      imagePath: imagePath,
      rawText: 'Gemini AI ile analiz edildi',
      createdAt: DateTime.now(),
    );
  }

  String _normalizeCategory(String raw) {
    final lower = raw.toLowerCase();
    if (lower.contains('market')) return 'Market';
    if (lower.contains('yemek')) return 'Yemek';
    if (lower.contains('ulas') || lower.contains('ulaş')) return 'Ulaşım';
    if (lower.contains('ofis')) return 'Ofis';
    if (lower.contains('yazil') || lower.contains('yazıl')) return 'Yazılım';
    return 'Diğer';
  }
}
