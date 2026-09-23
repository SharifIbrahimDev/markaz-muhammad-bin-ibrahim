# مركز محمد بن إبراهيم آل الشيخ رحمه الله للعلوم الشرعية
## Dandalin Karatuttuka da Littattafan Addinin Musulunci (Web & Mobile App Platform)

Barka da zuwa taskar dandalin ilimi na **مركز محمد بن إبراهيم آل الشيخ رحمه الله**. Wannan aikin ya kunshi cikakken tsarin yanar gizo (Web Platform & PWA) da kuma manhajar waya (Flutter Mobile App) domin yada ilimin addinin Musulunci ta hanyar:
1. 📚 **Littattafai (PDFs Library)**: Karanta littattafai kai tsaye a ciki da saukewa (Download).
2. 🎧 **Karatun Sauti (Audios/MP3s)**: Sauraron darussa, lakcoci, da karatu tare da Audio Player na zamani.
3. 🎥 **Bidiyoyi (Videos & Courses)**: Kallon darussan bidiyo da watsa karatu kai tsaye.
4. 📅 **Jadawalin Karatuttuka (Weekly Schedule)**: Lokuta, malamai, da wuraren da ake gabatar da darussa.
5. ⚙️ **Shafin Kula da Tsari (Admin Dashboard)**: Loda sabbin littattafai, muryoyi, bidiyoyi, da fitar da backup.

---

## Tsarin Fayiloli (Project Structure)

```
مركز محمد بن إبراهيم آل الشيخ رحمه الله/
├── web/                               # 🌐 DANDALIN YANAR GIZO (Web Platform & PWA)
│   ├── index.html                     # Babban shafi mai kunshe da dukkan bangarori
│   ├── reader.html                    # Shafin karanta PDF na musamman
│   ├── admin.html                     # Shafin Admin na loda sabbin littattafai da darussa
│   ├── css/
│   │   └── style.css                  # Tsarin zane na Musulunci (Islamic Luxury UI)
│   ├── js/
│   │   ├── data.js                    # Taskar bayanan littattafai da karatuttuka
│   │   ├── i18n.js                    # Injin fassara (Hausa, Larabci, Turanci)
│   │   ├── storage.js                 # Manajan ajiya (LocalStorage / IndexedDB)
│   │   ├── audio-player.js            # Injin kunna sautin karatu (Persistent Audio Player)
│   │   ├── app.js                     # Babban injin shafi da bincike
│   │   └── admin.js                   # Injin shafin admin da backup
│   ├── manifest.json                  # Saitin PWA (don zama App a waya)
│   └── sw.js                          # Service worker don aiki ba tare da intanet ba
│
├── mobile/                            # 📱 MANHAJAR WAYA (Flutter Mobile App)
│   ├── pubspec.yaml                   # Saitunan Flutter da packages
│   └── lib/
│       ├── main.dart                  # Mabudin shiga manhaja
│       ├── models/                    # Tsarin bayanai (Book, Audio, Video, Schedule)
│       ├── data/initial_data.dart     # Bayanan farko na manhaja
│       ├── providers/                 # State management (LibraryProvider, AudioPlayerProvider)
│       ├── screens/                   # Shafukan manhaja (Home, Books, Reader, Audio, Video, Admin)
│       └── widgets/                   # Kayan aikin zane (BookCard, AudioTile, MiniPlayer)
│
└── README.md                          # Jagoran amfani da bayani
```

---

## Yadda Ake Bude Shafin Yanar Gizo (Web Platform)

Kuna iya bude shafin yanar gizon kai tsaye a kowace browser (Chrome, Edge, Safari, Firefox):
1. Ku shiga cikin folda ta `web/`.
2. Ku bude fayil din [`index.html`](file:///c:/Users/USER/مركز%20محمد%20بن%20إبراهيم%20آل%20الشيخ%20رحمه%20الله/web/index.html) a cikin browser.
3. Domin loda sabbin littattafai ko darussa, ku danna **Admin** a sama ko ku bude [`admin.html`](file:///c:/Users/USER/مركز%20محمد%20بن%20إبراهيم%20آل%20الشيخ%20رحمه%20الله/web/admin.html).

---

## Yadda Ake Gwada Manhajar Waya (Flutter App)

Domin gwada manhajar a wayar Android ko iOS:
```bash
cd mobile
flutter pub get
flutter run
```

---

## Babban Fatanmu
Allah Ya sanya albarka a cikin wannan cibiya da dandalin karatu, Ya sa ya zama sadakatul jariya ga kowa da kowa!
