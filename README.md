<![CDATA[<div align="center">

# 🧾 ReceiptSnap

**Yapay zeka destekli fiş tarama ve harcama takip uygulaması**

[![Flutter](https://img.shields.io/badge/Flutter-3.10+-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.10+-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Gemini AI](https://img.shields.io/badge/Gemini_AI-2.5_Flash-4285F4?logo=google&logoColor=white)](https://ai.google.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

*Fişlerinizi kameraya gösterin, gerisini Gemini AI halletsin!*

</div>

---

## 📱 Ekran Görüntüleri

<div align="center">

| Fiş Tarama | AI Analiz | Harcama Özeti | Kategori Detayları |
|:-:|:-:|:-:|:-:|
| <img src="screenshots/scan.png" width="200"/> | <img src="screenshots/analyzing.png" width="200"/> | <img src="screenshots/summary.png" width="200"/> | <img src="screenshots/categories.png" width="200"/> |

</div>

---

## ✨ Özellikler

- 📸 **Fiş Tarama** — Kamera ile anlık fiş fotoğrafı çekme veya galeriden fiş görseli seçme
- 🤖 **Gemini AI Analizi** — Google Gemini 2.5 Flash modeli ile fişlerdeki bilgileri otomatik çıkarma (mağaza adı, tutar, tarih, kategori)
- 📊 **Harcama Özeti** — Aylık toplam harcama, pasta grafiği ile dağılım görüntüleme
- 🏷️ **Otomatik Kategorizasyon** — Fişler 6 kategoriye otomatik sınıflandırılır:
  - 🍽️ Yemek — Restoran, kafe, fast food
  - 🛒 Market — Süpermarket, gıda alışverişi
  - 🚗 Ulaşım — Taksi, benzin, toplu taşıma
  - 🏢 Ofis — Kırtasiye, ofis malzemesi
  - 💻 Yazılım — Dijital abonelik, hosting
  - 📋 Diğer — Sınıflandırılamayan harcamalar
- 🗂️ **İşlem Geçmişi** — Son işlemleri listeleme ve kaydırarak silme
- 📱 **Modern Koyu Tema** — Mor aksan renkli premium dark mode arayüz
- 💾 **Yerel Depolama** — Tüm veriler Hive ile cihazda güvenle saklanır

---

## 🏗️ Mimari

```
lib/
├── main.dart                  # Uygulama giriş noktası
├── app.dart                   # Ana uygulama widget'ı ve navigasyon
├── core/
│   ├── constants.dart         # Kategori tanımları, renkler, ikonlar
│   └── theme.dart             # Dark tema konfigürasyonu
├── models/
│   ├── receipt.dart           # Fiş veri modeli (Hive)
│   └── receipt.g.dart         # Hive TypeAdapter (otomatik üretilir)
├── providers/
│   ├── receipts_provider.dart # Fiş state yönetimi (Riverpod)
│   └── dashboard_providers.dart # Özet ekranı provider'ları
├── screens/
│   ├── camera_screen.dart     # Kamera / tarama ekranı
│   └── dashboard_screen.dart  # Harcama özeti ekranı
├── services/
│   ├── gemini_service.dart    # Gemini AI entegrasyonu
│   └── hive_service.dart      # Yerel veritabanı servisi
└── widgets/
    ├── total_card.dart        # Toplam harcama kartı
    ├── expense_pie_chart.dart # Pasta grafiği widget'ı
    ├── category_card.dart     # Kategori kartı widget'ı
    └── receipt_tile.dart      # İşlem satırı widget'ı
```

---

## 🛠️ Teknoloji Yığını

| Teknoloji | Kullanım Amacı |
|-----------|---------------|
| **Flutter 3.10+** | Cross-platform mobil uygulama geliştirme |
| **Dart 3.10+** | Programlama dili |
| **Riverpod** | State management (reactive) |
| **Hive** | Yerel NoSQL veritabanı |
| **Google Generative AI** | Gemini 2.5 Flash ile fiş analizi |
| **Camera** | Kamera erişimi ve fotoğraf çekme |
| **Image Picker** | Galeriden görsel seçme |
| **fl_chart** | Pasta grafiği görselleştirme |
| **intl** | Türkçe tarih ve sayı formatları |
| **path_provider** | Dosya sistemi yolu yönetimi |
| **uuid** | Benzersiz kimlik üretimi |
| **permission_handler** | Kamera izin yönetimi |

---

## 🚀 Kurulum

### Ön Gereksinimler

- Flutter SDK `>= 3.10.7`
- Dart SDK `>= 3.10.7`
- Android Studio / Xcode (platform hedefine göre)
- [Google AI Studio](https://aistudio.google.com/) üzerinden bir **Gemini API Key**

### Adımlar

1. **Depoyu klonlayın:**
   ```bash
   git clone https://github.com/dincerkizilderee/receiptsnap.git
   cd receiptsnap
   ```

2. **Bağımlılıkları yükleyin:**
   ```bash
   flutter pub get
   ```

3. **Hive TypeAdapter'larını üretin:**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Gemini API Key'inizi ayarlayın:**

   `lib/services/gemini_service.dart` dosyasını açın ve şu satırı güncelleyin:
   ```dart
   static const String _apiKey = 'YOUR_API_KEY';
   ```
   > ⚠️ **Önemli:** API anahtarınızı versiyon kontrolüne (git) göndermemeye dikkat edin. Ortam değişkeni veya `.env` dosyası kullanmanız önerilir.

5. **Uygulamayı çalıştırın:**
   ```bash
   flutter run
   ```

---

## 📖 Kullanım

1. **Tara** sekmesinde kamera ile fişinizi çerçeveye hizalayın
2. 📸 butonuna basarak fotoğraf çekin (veya 🖼️ butonuyla galeriden seçin)
3. **Gemini AI** fişi analiz eder — mağaza adı, tutar, tarih ve kategori otomatik çıkarılır
4. **Özet** sekmesine geçerek harcama dağılımınızı görün:
   - Aylık toplam tutar
   - Kategori bazlı pasta grafiği
   - Kategori kartları
   - Son işlemler listesi
5. İşlem satırını sola kaydırarak silebilirsiniz

---

## 🔧 Yapılandırma

### Kategori Özelleştirme

Kategoriler `lib/core/constants.dart` dosyasından düzenlenebilir:

```dart
static const List<String> categories = ['Yemek', 'Market', 'Ulaşım', 'Ofis', 'Yazılım', 'Diğer'];
```

Her kategoriye ait **anahtar kelimeler**, **renkler** ve **ikonlar** aynı dosyadan yapılandırılabilir.

### Gemini Prompt Özelleştirme

AI'ın fiş analiz davranışı `lib/services/gemini_service.dart` dosyasındaki `_prompt` sabiti üzerinden özelleştirilebilir.

---

## 📁 Proje Yapısı Özeti

| Katman | Dosyalar | Sorumluluk |
|--------|---------|------------|
| **Sunum** | `screens/`, `widgets/` | UI bileşenleri ve ekranlar |
| **İş Mantığı** | `providers/` | Riverpod ile state yönetimi |
| **Veri** | `models/`, `services/` | Veri modelleri, AI ve DB servisleri |
| **Çekirdek** | `core/` | Tema, sabitler, yapılandırma |

---

## 🤝 Katkıda Bulunma

1. Bu depoyu **fork** edin
2. Yeni bir branch oluşturun (`git checkout -b feature/yeni-ozellik`)
3. Değişikliklerinizi commit edin (`git commit -m 'Yeni özellik eklendi'`)
4. Branch'inizi push edin (`git push origin feature/yeni-ozellik`)
5. **Pull Request** oluşturun

---

## 📄 Lisans

Bu proje [MIT Lisansı](LICENSE) ile lisanslanmıştır.

---

<div align="center">

**ReceiptSnap** ile harcamalarınızı akıllıca takip edin 💜

</div>
]]>
