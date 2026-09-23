import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/library_provider.dart';
import '../widgets/mini_player.dart';
import 'home_screen.dart';
import 'books_screen.dart';
import 'audios_screen.dart';
import 'videos_screen.dart';
import 'schedule_screen.dart';
import 'favorites_screen.dart';
import 'admin_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    BooksScreen(),
    AudiosScreen(),
    VideosScreen(),
    ScheduleScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final libProvider = Provider.of<LibraryProvider>(context);

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF06382A), Color(0xFF0A533F)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('🕌', style: TextStyle(fontSize: 32)),
                  const SizedBox(height: 6),
                  const Text(
                    'مركز محمد بن إبراهيم آل الشيخ',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Text(
                    'Hasken yada ilimin Musulunci',
                    style: TextStyle(color: const Color(0xFFDFBA73).withOpacity(0.9), fontSize: 11),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.favorite, color: Colors.red),
              title: const Text('Abubuwan da Na Ajiye (Favorites)'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const FavoritesScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.admin_panel_settings, color: Color(0xFF0A533F)),
              title: const Text('Shafin Admin (Loda Littattafai)'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminScreen()));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.language, color: Color(0xFFC5A059)),
              title: const Text('Harshe (Language)'),
              trailing: DropdownButton<String>(
                value: libProvider.currentLang,
                underline: const SizedBox(),
                items: const [
                  DropdownMenuItem(value: 'ha', child: Text('Hausa')),
                  DropdownMenuItem(value: 'ar', child: Text('العربية')),
                  DropdownMenuItem(value: 'en', child: Text('English')),
                ],
                onChanged: (val) => libProvider.setLanguage(val ?? 'ha'),
              ),
            ),
            ListTile(
              leading: Icon(
                libProvider.themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
                color: const Color(0xFF0A533F),
              ),
              title: Text(libProvider.themeMode == ThemeMode.dark ? 'Launin Fari (Light)' : 'Launin Duhu (Dark)'),
              onTap: () => libProvider.toggleTheme(),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          _screens[_currentIndex],
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: MiniAudioPlayerWidget(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF0A533F),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Gida'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'PDFs'),
          BottomNavigationBarItem(icon: Icon(Icons.headset), label: 'Sauti'),
          BottomNavigationBarItem(icon: Icon(Icons.play_circle_fill), label: 'Bidiyo'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Jadawali'),
        ],
      ),
    );
  }
}
