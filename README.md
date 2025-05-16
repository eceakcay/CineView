# CineView

CineView, kullanıcıların popüler filmleri görüntüleyebileceği, favori filmlerini kaydedebileceği ve filmlere yorum yapabileceği bir iOS uygulamasıdır. Uygulama, SwiftUI ile geliştirilmiş olup Firebase Authentication ile kullanıcı girişi, The Movie Database (TMDB) API ile film verileri, Core Data ile yerel favori saklama ve Firestore ile yorum yönetimi sağlar.

## Özellikler

- **Kullanıcı Girişi/Kayıt:** Firebase Authentication ile e-posta ve şifreyle giriş yapma veya yeni hesap oluşturma.
- **Popüler Filmler:** TMDB API’sinden popüler filmleri listeleme.
- **Film Detayları:** Film posterleri, açıklamaları ve çıkış tarihlerini görüntüleme.
- **Favori Filmler:** Kullanıcılar filmleri favorilere ekleyip çıkarabilir, favoriler Core Data ile yerel olarak saklanır ve çevrimdışı erişilebilir.
- **Yorum Yapma:** Kullanıcılar filmlere yorum ekleyebilir, yorumlar Firestore’da saklanır.
- **Sekmeli Arayüz:** “Filmler” ve “Favoriler” sekmeleriyle kolay navigasyon.

## Teknolojiler

- **SwiftUI:** Kullanıcı arayüzü için.
- **Firebase:**
  - Authentication: Kullanıcı girişi ve kayıt.
  - Firestore: Yorumların bulutta saklanması.
- **Core Data:** Favori filmlerin yerel saklanması.
- **TMDB API:** Film verilerini çekmek için.
- **Kingfisher:** Film posterlerini hızlı ve önbellekli yüklemek için.
