# Flutter Social App

Flutter Social App, modern Flutter teknolojileri kullanılarak geliştirilmiş, kullanıcı dostu bir sosyal medya uygulamasıdır. Bu uygulama sayesinde JSONPlaceholder API üzerinden gönderiler, kullanıcılar ve yorumlar gibi verilere erişebilir, gönderi detaylarını görüntüleyebilir ve yeni gönderiler oluşturabilirsiniz.

Proje, gerçek bir sosyal medya deneyimini simüle etmeyi amaçlayan temel ama güçlü özellikler sunar. Aynı zamanda yazılım geliştirme süreçlerinde state management (Riverpod), REST API tüketimi (Dio), sayfa yönlendirme (go_router) gibi önemli konuların öğrenilmesine yardımcı olur.

## 🚀 Özellikler

- 📄 Tüm gönderileri listeleme
- 📝 Gönderi detaylarını görüntüleme
- 🔗Kullanıcının yorumlarını görüntüleme
- 👤 Kullanıcıları listeleme
- ✍️ Yeni gönderi oluşturma
- 🛠️ Gönderi düzenleme
- 🔗 Riverpod ile State Management
- 📡 Dio ile API haberleşmesi
- 🧱 Repository Pattern mimarisi
- 🔀 go_router ile sayfa geçişleri

## 🧪 Kullanılan Teknolojiler

- **Flutter**
- **Dart**
- **Riverpod** - State Management
- **Dio** - HTTP İstekleri
- **Repository Pattern** - Mimari yapı
- **go_router** - Sayfalar arası yönlendirme
- **JSONPlaceholder** - Sahte REST API

## 📂 Proje Yapısı

```
lib/
├── main.dart
├── models/
│   ├── user_model.dart
│   ├── comment_model.dart
│   └── post_model.dart
├── providers/
│   └── providers.dart
├── repository/
│   ├── user_repository.dart
│   ├── comment_repository.dart
│   └── post_repository.dart
├── screens/
│   ├── home_screen.dart
│   ├── post_create_screen.dart
│   ├── post_detail_screen.dart
│   ├── post_edit_screen.dart
│   ├── user_posts_screen.dart
│   └── user_list_screen.dart
└── service/
    └── api_service.dart
```

    

## 📸 Ekran Görüntüleri
<img src="https://github.com/user-attachments/assets/c32ee89e-251b-4d82-a178-27806cd25133" width=300 height=600>
<img src="https://github.com/user-attachments/assets/74e4e941-8dc5-4529-a6c5-cd28d9af3ac2" width=300 height=600>
<img src="https://github.com/user-attachments/assets/1eb7e333-ae88-4b02-8d62-80eeccb8f808" width=300 height=600>
<img src="https://github.com/user-attachments/assets/c76d0587-d6d4-4180-afd4-3d4b733eb7a9" width=300 height=600>
<img src="https://github.com/user-attachments/assets/c40bab95-6af5-4faf-991f-f608cf472cb1" width=300 height=600>

## 🛠️ Kurulum Talimatları
Bu projeyi yerel makinenizde çalıştırmak için aşağıdaki adımları izleyin:
1. **Bu repoyu klonlayın**:
```
git clone https://github.com/kullanici/flutter-social-app.git
cd flutter-social-app
```
3. **Gerekli Paketleri Kurun**:
```
flutter pub get
```
5. **Uygulamayı Başlatın**:
```
flutter run
```

    
