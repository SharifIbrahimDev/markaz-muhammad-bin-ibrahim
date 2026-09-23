import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'providers/library_provider.dart';
import 'providers/audio_player_provider.dart';
import 'screens/main_navigation_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LibraryProvider()),
        ChangeNotifierProvider(create: (_) => AudioPlayerProvider()),
      ],
      child: const MarkazAlsheikhApp(),
    ),
  );
}

class MarkazAlsheikhApp extends StatelessWidget {
  const MarkazAlsheikhApp({super.key});

  @override
  Widget build(BuildContext context) {
    final libProvider = Provider.of<LibraryProvider>(context);

    // Light Theme
    final lightTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: const Color(0xFF0A533F),
      scaffoldBackgroundColor: const Color(0xFFFBF9F5),
      cardColor: Colors.white,
      textTheme: libProvider.currentLang == 'ar'
          ? GoogleFonts.cairoTextTheme()
          : GoogleFonts.plusJakartaSansTextTheme(),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF0A533F),
        primary: const Color(0xFF0A533F),
        secondary: const Color(0xFFC5A059),
        background: const Color(0xFFFBF9F5),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF0A533F),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
    );

    // Dark Theme
    final darkTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF107559),
      scaffoldBackgroundColor: const Color(0xFF0B1713),
      cardColor: const Color(0xFF12241E),
      textTheme: (libProvider.currentLang == 'ar'
              ? GoogleFonts.cairoTextTheme()
              : GoogleFonts.plusJakartaSansTextTheme())
          .apply(bodyColor: const Color(0xFFF3F8F5), displayColor: Colors.white),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF107559),
        brightness: Brightness.dark,
        primary: const Color(0xFF107559),
        secondary: const Color(0xFFDFBA73),
        background: const Color(0xFF0B1713),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF12241E),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
    );

    return MaterialApp(
      title: 'مركز محمد بن إبراهيم آل الشيخ رحمه الله',
      debugShowCheckedModeBanner: false,
      themeMode: libProvider.themeMode,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const MainNavigationScreen(),
    );
  }
}
