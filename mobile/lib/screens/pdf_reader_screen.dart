import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../providers/library_provider.dart';

class PdfReaderScreen extends StatefulWidget {
  final Book book;

  const PdfReaderScreen({super.key, required this.book});

  @override
  State<PdfReaderScreen> createState() => _PdfReaderScreenState();
}

class _PdfReaderScreenState extends State<PdfReaderScreen> {
  int _currentChapterIndex = 0;
  double _fontSize = 16.0;
  String _themeMode = 'light'; // 'light', 'sepia', 'dark'

  // Pre-loaded chapters for books
  late List<Map<String, dynamic>> _chapters;

  @override
  void initState() {
    super.initState();
    _loadBookChapters();
  }

  void _loadBookChapters() {
    final id = widget.book.id;

    if (id == 'b_isa_6') {
      // Ad-Durar Al-Bahiyyah (Al-Qawa'idul Arba')
      _chapters = [
        {
          'title': '🕊️ المُقَدِّمَةُ العَامَّةُ',
          'arabic': 'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ\nالحَمْدُ لِلَّهِ رَبِّ العَالَمِينَ، وَالصَّلَاةُ وَالسَّلَامُ عَلَى نَبِيِّنَا مُحَمَّدٍ خَاتَمِ النَّبِيِّينَ وَعَلَى آلِهِ وَصَحْبِهِ أَجْمَعِينَ.',
          'hausa': 'Fahimtar Tauhidi shi ne babban ginshiki da ya kamata kowane Musulmi ya fara koya domin samun tsira a duniya da gobe Kiyama.\n\nAllah Ta\'ala Ya ce:\n﴿وَمَا خَلَقْتُ الْجِنَّ وَالْإِنْسَ إِلَّا لِيَعْبُدُونِ﴾ [الذاريات: 56]\n\nWannan littafi «الدُّرَرُ البَهِيَّةُ» sharhi ne mai sauki da zai taimaka wajen raba tsakanin Tauhidi da Shirka.',
        },
        {
          'title': '👤 البَابُ الأَوَّلُ: تَرْجَمَةُ الإِمَامِ مُحَمَّدِ بْنِ عَبْدِ الوَهَّابِ',
          'arabic': 'الإِمَامُ المُجَدِّدُ شَيْخُ الإِسْلَامِ مُحَمَّدُ بْنُ عَبْدِ الوَهَّابِ بْنِ سُلَيْمَانَ التَّمِيمِيُّ (1115 – 1206 هـ)',
          'hausa': 'An haife shi a garin Uyainah a Najd a shekara ta 1115 H. Ya haddace Alkur\'ani kafin shekaru 10, ya yi balaguron neman ilimi zuwa Makka, Madina, da Basra. Ya kafa da\'awar Tauhidi tare da Amir Muhammad bin Sa\'ud a 1157 H.',
        },
        {
          'title': '📖 البَابُ الثَّانِي: شَرْحُ تَمْهِيدِ المَتْنِ',
          'arabic': '«أَسْأَلُ اللَّهَ الْكَرِيمَ أَنْ يَتَوَلَّاكَ فِي الدُّنْيَا وَالْآخِرَةِ، وَأَنْ يَجْعَلَكَ مُبَارَكًا أَيْنَمَا كُنْتَ، وَأَنْ يَجْعَلَكَ مِمَّنْ إِذَا أُعْطِيَ شَكَرَ، وَإِذَا ابْتُلِيَ صَبَرَ، وَإِذَا أَذْنَبَ اسْتَغْفَرَ؛ فَإِنَّ هَؤُلَاءِ الثَّلَاثَ عُنْوَانُ السَّعَادَةِ.»',
          'hausa': 'Alamomin Sa\'ada Guda 3:\n1. Godiya (Ash-Shukr) a lokacin ni\'ima.\n2. Hakuri (As-Sabr) a lokacin jarrabawa.\n3. Istigfari (Al-Istighfar) a lokacin da aka yi kuskure.',
        },
        {
          'title': '🧭 القَاعِدَةُ الأُولَى: الإِقْرَارُ بِالرُّبُوبِيَّةِ لَا يَكْفِي',
          'arabic': '«أَنَّ الْكُفَّارَ الَّذِينَ قَاتَلَهُمْ رَسُولُ اللَّهِ ﷺ يُقِرُّونَ بِأَنَّ اللَّهَ تَعَالَى هُوَ الْخَالِقُ الرَّازِقُ الْمُدَبِّرُ، وَأَنَّ ذَلِكَ لَمْ يُدْخِلْهُمْ فِي الْإِسْلَامِ...»',
          'hausa': 'Kafiran Makka sun yarda cewa Allah ne Mahalicci mai saukar da ruwan sama (Suratu Yunus: 31), amma hakan bai shigar da su Musulunci ba har sai an kadaita Allah a cikin Tauhidul Uluhiyyah (bauta da roko ga Allah kadai).',
        },
        {
          'title': '⚖️ القَاعِدَةُ الثَّانِيَةُ: شُبْهَةُ القُرْبَةِ وَالشَّفَاعَةِ',
          'arabic': '﴿وَالَّذِينَ اتَّخَذُوا مِنْ دُونِهِ أَوْلِيَاءَ مَا نَعْبُدُهُمْ إِلَّا لِيُقَرِّبُونَا إِلَى اللَّهِ زُلْفَى﴾ [الزمر: 3]',
          'hausa': 'Mushrikan ba su ce gumaka ne suka halicce su ba, suna kiran su ne don neman kusanci da ceto. Ceton da aka amince da shi a Shari\'a yana da sharudda biyu: Iznin Allah da YardarSa.',
        },
        {
          'title': '🌿 القَاعِدَةُ الثَّالِثَةُ: بُطْلَانُ الشِّرْكِ فِي كُلِّ المَعْبُودَاتِ',
          'arabic': '«أَنَّ النَّبِيَّ ﷺ ظَهَرَ عَلَى أُنَاسٍ مُتَفَرِّقِينَ فِي عِبَادَاتِهِمْ... وَقَاتَلَهُمْ رَسُولُ اللَّهِ ﷺ وَلَمْ يُفَرِّقْ بَيْنَهُمْ.»',
          'hausa': 'Annabi (SAW) ya yaki dukkan masu bautar wanin Allah ba tare da banbanta tsakanin mala\'iku, annabawa (Isa AS), salihan bayi, ko duwatsu ba.',
        },
        {
          'title': '⚡ القَاعِدَةُ الرَّابِعَةُ: شِرْكُ المُتَأَخِّرِينَ أَغْلَظُ',
          'arabic': '﴿فَإِذَا رَكِبُوا فِي الْفُلْكِ دَعَوُا اللَّهَ مُخْلِصِينَ لَهُ الدِّينَ فَلَمَّا نَجَّاهُمْ إِلَى الْبَرِّ إِذَا هُمْ يُشْرِكُونَ﴾ [العنكبوت: 65]',
          'hausa': 'Kafiran da suna shirka a lokacin dadi, amma a tsanani suna kiran Allah kadai. Amma masu shirkar zamani suna shirka a dadi da kuma lokacin kunci.',
        },
      ];
    } else if (id == 'b_isa_15') {
      // Naylul Amani (Al-Bayquniyyah)
      _chapters = [
        {
          'title': '🕊️ المُقَدِّمَةُ وَتَرْجَمَةُ النَّاظِمِ',
          'arabic': 'أَبْدَأُ بِالْحَمْدِ مُصَلِّيًا عَلَى ... مُحَمَّدٍ خَيْرِ نَبِيٍّ أُرْسِلَا\nوَذِي مِنَ أَقْسَامِ الْحَدِيثِ عِدَّهْ ... وَكُلُّ وَاحِدٍ أَتَى وَحَدَّهْ',
          'hausa': 'Sheikh Umar bin Muhammad Al-Bayquni (رحمه الله) ya tsara wannan waka mai baitoci 34 domin koya wa dalibai rabe-raben hadisai cikin sauki.',
        },
        {
          'title': '🏆 الصَّحِيحُ وَالحَسَنُ',
          'arabic': 'أَوَّلُهَا: الصَّحِيحُ، وَهْوَ مَا اتَّصَلْ ... إِسْنَادُهُ، وَلَمْ يَشِذَّ أَوْ يُعَلْ\nيَرْوِيهِ عَدْلٌ ضَابِطٌ عَنْ مِثْلِهِ ... مُعْتَمَدٌ فِي ضَبْطِهِ وَنَقْلِهِ',
          'hausa': 'Sharuddan Sahih guda 5:\n1. Ittisalus Sanad (Sarkar sanadi)\n2. Adalcin Marawiyi\n3. Cikakkiyar Kiyayewa (Dabt)\n4. Kaucewa Sabani (Adamush Shudhudh)\n5. Kaucewa Illa Boyayya.',
        },
        {
          'title': '📉 الضَّعِيفُ، المَرْفُوعُ، وَالمَوْقُوفُ',
          'arabic': 'وَكُلُّ مَا عَنْ رُتْبَةِ الْحُسْنِ قَصُرْ ... فَهْوَ الضَّعِيفُ، وَهْوَ أَقْسَامًا كَثُرْ\nوَمَا أُضِيفَ لِلنَّبِيِّ: الْمَرْفُوعُ ... وَمَا لِتَابِعٍ: هُوَ الْمَقْطُوعُ',
          'hausa': 'Da\'if shi ne wanda ya gaza cika sharuddan Hasan. Marfu\' shi ne maganar Annabi (SAW). Mawquf maganar Sahabi ce.',
        },
        {
          'title': '🚫 المَتْرُوكُ وَالمَوْضُوعُ',
          'arabic': 'وَالمَتْرُوكُ: مَا وَاحِدٌ بِهِ انْفَرَدْ ... وَأَجْمَعُوا لِضَعْفِهِ فَهْوَ كَرَدْ\nوَالكَذِبُ المُخْتَلَقُ المَصْنُوعُ ... عَلَى النَّبِيِّ: فَذَلِكَ المَوْضُوعُ',
          'hausa': 'Al-Mawdu\' shi ne hadisin qarya da aka kirkira aka lika wa Annabi (SAW). Haramun ne kafa hujja da shi a addini.',
        },
      ];
    } else if (id == 'b_isa_5') {
      // Fath Ar-Rahim Al-Mannan (Usulus Salasa)
      _chapters = [
        {
          'title': '🕊️ المُقَدِّمَةُ: ثَلَاثَةُ الأُصُولِ',
          'arabic': 'المَسَائِلُ الأَرْبَعُ مِنْ سُورَةِ العَصْرِ:\n1. العِلْمُ  2. العَمَلُ بِهِ  3. الدَّعْوَةُ إِلَيْهِ  4. الصَّبْرُ عَلَى الأَذَى فِيهِ',
          'hausa': 'Wadannan Asalai guda 3 su ne tambayoyin kabari: Sanin Allah, Sanin Musulunci, da Sanin Manzon Allah (SAW).',
        },
        {
          'title': '🧭 الأَصْلُ الأَوَّلُ: مَعْرِفَةُ الرَّبِّ',
          'arabic': '﴿وَأَنَّ الْمَسَاجِدَ لِلَّهِ فَلَا تَدْعُوا مَعَ اللَّهِ أَحَدًا﴾ [الجن: 18]',
          'hausa': 'Ubangijina shi ne Allah. Dukkan ibada (Addu\'a, Tsoro, Fata, Dogaro, Yanka, da Bakance) na Allah ne kadai.',
        },
        {
          'title': '📖 الأَصْلُ الثَّانِي: مَعْرِفَةُ دِينِ الإِسْلَامِ',
          'arabic': 'مَرَاتِبُ الدِّينِ الثَّلَاثُ: الإِسْلَامُ (5 أَرْكَان)، الإِيمَانُ (6 أَرْكَان)، وَالإِحْسَانُ (رُكْنٌ وَاحِدٌ).',
          'hausa': 'Musulunci yana da darajoji 3: 1. Musulunci (Rukunai 5), 2. Imani (Rukunai 6), 3. Ihsani (Bautawa Allah kamar kana ganinSa).',
        },
        {
          'title': '🕌 الأَصْلُ الثَّالِثُ: مَعْرِفَةُ النَّبِيِّ ﷺ',
          'arabic': 'مُحَمَّدُ بْنُ عَبْدِ اللَّهِ بْنِ عَبْدِ المُطَّلِبِ ﷺ (عَاشَ 63 سَنَةً)',
          'hausa': 'Shi ne Annabi Muhammad (SAW), ya yi hijira zuwa Madina, kuma ya isar da sakon addini baki daya.',
        },
      ];
    } else if (id == 'b_isa_18') {
      // Al-Manhal As-Safi (Qawa'idus Sa'di)
      _chapters = [
        {
          'title': '🕊️ المُقَدِّمَةُ وَتَرْجَمَةُ الشَّيْخِ السَّعْدِيِّ',
          'arabic': 'الحَمْدُ لِلَّهِ العَلِيِّ الأَرْفَقِ ... وَجَامِعِ الأَشْيَاءِ وَالمُفَرِّقِ\nذِي النِّعَمِ الوَاسِعَةِ الغَزِيرَةْ ... وَالحِكَمِ البَاهِرَةِ الكَثِيرَةْ',
          'hausa': 'Wakar Sheikh Abdurrahman As-Sa\'di mai baitoci 46 tana tattara manyan ka\'idojin fiqhu a saukake.',
        },
        {
          'title': '🏛️ أَعْظَمُ قَوَاعِدِ الشَّرِيعَةِ',
          'arabic': 'الدِّينُ مَبْنِيٌّ عَلَى المَصَالِحِ ... فِي جَلْبِهَا وَالدَّرْءِ لِلقَبَائِحِ\nفَإِنْ تَزَاحَمْ عَدَدُ المَصَالِحِ ... يُقَدَّمُ الأَعْلَى مِنَ المَصَالِحِ',
          'hausa': 'Dukkan Shari\'a an gina ta ne domin kawo alheri da maslaha da magance barna. Idan maslaholi suka hadu, ana fifita mafi girma.',
        },
        {
          'title': '⚖️ قَوَاعِدُ النِّيَّاتِ، المَشَقَّةِ، وَاليَقِينِ',
          'arabic': 'وَالنِّيَّةُ شَرْطٌ لِسَائِرِ العَمَلِ ... بِهَا الصَّلَاحُ وَالفَسَادُ لِلعَمَلِ\nوَقَاعِدَةُ الشَّرِيعَةِ التَّيْسِيرُ ... فِي كُلِّ أَمْرٍ نَابَهُ تَعْسِيرُ',
          'hausa': '1. Ayyuka suna tare da niyya.\n2. Tsanani yana jawo sauki a Shari\'a.\n3. Yakinci ba ya gushewa da kokwanto.',
        },
      ];
    } else {
      // General View for other books
      _chapters = [
        {
          'title': '📖 Bayanin Littafi & Fihirisa',
          'arabic': widget.book.titleAr,
          'hausa': widget.book.descriptionHa,
        }
      ];
    }
  }

  Color _getBackgroundColor() {
    switch (_themeMode) {
      case 'sepia':
        return const Color(0xFFF4ECD8);
      case 'dark':
        return const Color(0xFF181A1B);
      case 'light':
      default:
        return const Color(0xFFFAF8F5);
    }
  }

  Color _getTextColor() {
    switch (_themeMode) {
      case 'sepia':
        return const Color(0xFF5C4B37);
      case 'dark':
        return const Color(0xFFE8E6E3);
      case 'light':
      default:
        return const Color(0xFF1F2937);
    }
  }

  Color _getCardColor() {
    switch (_themeMode) {
      case 'sepia':
        return const Color(0xFFFCF8EE);
      case 'dark':
        return const Color(0xFF23272A);
      case 'light':
      default:
        return Colors.white;
    }
  }

  void _showTableOfContents() {
    showModalBottomSheet(
      context: context,
      backgroundColor: _getCardColor(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.2))),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '📑 Fihirisar Babobi (Chapters)',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0A533F)),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(ctx),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _chapters.length,
                  itemBuilder: (ctx, idx) {
                    final ch = _chapters[idx];
                    final isSelected = idx == _currentChapterIndex;
                    return ListTile(
                      selected: isSelected,
                      selectedTileColor: const Color(0xFF0A533F).withOpacity(0.1),
                      title: Text(
                        ch['title'] ?? 'Babi ${idx + 1}',
                        style: TextStyle(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? const Color(0xFF0A533F) : _getTextColor(),
                        ),
                      ),
                      trailing: isSelected ? const Icon(Icons.check_circle, color: Color(0xFF0A533F)) : null,
                      onTap: () {
                        setState(() => _currentChapterIndex = idx);
                        Navigator.pop(ctx);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final libProvider = Provider.of<LibraryProvider>(context);
    final title = widget.book.getLocalizedTitle(libProvider.currentLang);
    final currentChapter = _chapters[_currentChapterIndex];

    return Scaffold(
      backgroundColor: _getBackgroundColor(),
      appBar: AppBar(
        title: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF0A533F),
        foregroundColor: Colors.white,
        actions: [
          // Table of Contents
          IconButton(
            icon: const Icon(Icons.list_alt),
            tooltip: 'Fihirisa',
            onPressed: _showTableOfContents,
          ),
          // Font zoom out
          IconButton(
            icon: const Icon(Icons.text_decrease),
            tooltip: 'Rage Haruffa',
            onPressed: _fontSize > 12 ? () => setState(() => _fontSize -= 2) : null,
          ),
          // Font zoom in
          IconButton(
            icon: const Icon(Icons.text_increase),
            tooltip: 'Kara Girman Haruffa',
            onPressed: _fontSize < 26 ? () => setState(() => _fontSize += 2) : null,
          ),
          // Theme menu
          PopupMenuButton<String>(
            icon: const Icon(Icons.color_lens_outlined),
            tooltip: 'Canza Launin Karatu',
            onSelected: (mode) => setState(() => _themeMode = mode),
            itemBuilder: (ctx) => [
              const PopupMenuItem(value: 'light', child: Text('☀️ Fari (Light)')),
              const PopupMenuItem(value: 'sepia', child: Text('📜 Tsohuwar Takarda (Sepia)')),
              const PopupMenuItem(value: 'dark', child: Text('🌙 Duhu (Dark)')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Chapter Progress Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: const Color(0xFFC5A059).withOpacity(0.15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    currentChapter['title'] ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF0A533F)),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${_currentChapterIndex + 1} / ${_chapters.length}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFFC5A059)),
                ),
              ],
            ),
          ),

          // Main Reading Area
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Chapter Header Box
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _getCardColor(),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFC5A059).withOpacity(0.3)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          '🕌 مركز محمد بن إبراهيم آل الشيخ رحمه الله',
                          style: TextStyle(fontSize: 12, color: Color(0xFFC5A059), fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          currentChapter['title'] ?? '',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: _fontSize + 2,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF0A533F),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Arabic Box
                  if (currentChapter['arabic'] != null && currentChapter['arabic'].toString().isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: _themeMode == 'dark' ? const Color(0xFF2D3238) : const Color(0xFFF3F8F5),
                        borderRadius: BorderRadius.circular(10),
                        border: const Border(right: BorderSide(color: Color(0xFF0A533F), width: 4)),
                      ),
                      child: Text(
                        currentChapter['arabic'],
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: _fontSize + 4,
                          height: 2.0,
                          fontWeight: FontWeight.w600,
                          color: _themeMode == 'dark' ? Colors.white : const Color(0xFF06382B),
                        ),
                      ),
                    ),

                  const SizedBox(height: 18),

                  // Hausa Commentary Box
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: _getCardColor(),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.withOpacity(0.2)),
                    ),
                    child: Text(
                      currentChapter['hausa'] ?? '',
                      style: TextStyle(
                        fontSize: _fontSize,
                        height: 1.8,
                        color: _getTextColor(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),

          // Bottom Chapter Navigator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: _getCardColor(),
              border: Border(top: BorderSide(color: Colors.grey.withOpacity(0.2))),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0A533F),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _currentChapterIndex > 0
                      ? () => setState(() => _currentChapterIndex--)
                      : null,
                  icon: const Icon(Icons.arrow_back, size: 16),
                  label: const Text('Babi na Baya'),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0A533F),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _currentChapterIndex < _chapters.length - 1
                      ? () => setState(() => _currentChapterIndex++)
                      : null,
                  icon: const Icon(Icons.arrow_forward, size: 16),
                  label: const Text('Babi na Gaba'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
