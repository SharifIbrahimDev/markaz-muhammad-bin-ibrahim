import 'package:flutter/material.dart';
import '../models/book.dart';
import '../models/audio_lesson.dart';
import '../models/video_lesson.dart';
import '../models/schedule_item.dart';
import '../data/initial_data.dart';

class LibraryProvider extends ChangeNotifier {
  List<Book> _books = [];
  List<AudioLesson> _audios = [];
  List<VideoLesson> _videos = [];
  List<ScheduleItem> _schedule = [];
  final Set<String> _favoriteIds = {};

  String _currentLang = 'ha'; // 'ha', 'ar', 'en'
  ThemeMode _themeMode = ThemeMode.light;
  String _activeCategory = 'all';
  String _searchQuery = '';

  LibraryProvider() {
    _loadInitialData();
  }

  List<Book> get books => _books;
  List<AudioLesson> get audios => _audios;
  List<VideoLesson> get videos => _videos;
  List<ScheduleItem> get schedule => _schedule;
  Set<String> get favoriteIds => _favoriteIds;
  String get currentLang => _currentLang;
  ThemeMode get themeMode => _themeMode;
  String get activeCategory => _activeCategory;
  String get searchQuery => _searchQuery;

  void _loadInitialData() {
    _books = AppInitialData.getInitialBooks();
    _audios = AppInitialData.getInitialAudios();
    _videos = AppInitialData.getInitialVideos();
    _schedule = AppInitialData.getInitialSchedule();
    notifyListeners();
  }

  void setLanguage(String lang) {
    _currentLang = lang;
    notifyListeners();
  }

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void setCategory(String category) {
    _activeCategory = category;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query.toLowerCase().trim();
    notifyListeners();
  }

  bool isFavorite(String id) => _favoriteIds.contains(id);

  void toggleFavorite(String id) {
    if (_favoriteIds.contains(id)) {
      _favoriteIds.remove(id);
    } else {
      _favoriteIds.add(id);
    }
    notifyListeners();
  }

  // Filtered lists
  List<Book> get filteredBooks {
    return _books.where((b) {
      final matchesCategory = _activeCategory == 'all' || b.category == _activeCategory;
      final matchesSearch = _searchQuery.isEmpty ||
          b.titleHa.toLowerCase().contains(_searchQuery) ||
          b.titleAr.toLowerCase().contains(_searchQuery) ||
          b.authorHa.toLowerCase().contains(_searchQuery) ||
          b.authorAr.toLowerCase().contains(_searchQuery);
      return matchesCategory && matchesSearch;
    }).toList();
  }

  List<AudioLesson> get filteredAudios {
    return _audios.where((a) {
      final matchesCategory = _activeCategory == 'all' || a.category == _activeCategory;
      final matchesSearch = _searchQuery.isEmpty ||
          a.titleHa.toLowerCase().contains(_searchQuery) ||
          a.titleAr.toLowerCase().contains(_searchQuery) ||
          a.speakerHa.toLowerCase().contains(_searchQuery) ||
          a.speakerAr.toLowerCase().contains(_searchQuery);
      return matchesCategory && matchesSearch;
    }).toList();
  }

  List<VideoLesson> get filteredVideos {
    return _videos.where((v) {
      final matchesCategory = _activeCategory == 'all' || v.category == _activeCategory;
      final matchesSearch = _searchQuery.isEmpty ||
          v.titleHa.toLowerCase().contains(_searchQuery) ||
          v.titleAr.toLowerCase().contains(_searchQuery) ||
          v.instructorHa.toLowerCase().contains(_searchQuery) ||
          v.instructorAr.toLowerCase().contains(_searchQuery);
      return matchesCategory && matchesSearch;
    }).toList();
  }

  // Admin Actions
  void addBook(Book book) {
    _books.insert(0, book);
    notifyListeners();
  }

  void deleteBook(String id) {
    _books.removeWhere((b) => b.id == id);
    notifyListeners();
  }

  void addAudio(AudioLesson audio) {
    _audios.insert(0, audio);
    notifyListeners();
  }

  void deleteAudio(String id) {
    _audios.removeWhere((a) => a.id == id);
    notifyListeners();
  }

  void addVideo(VideoLesson video) {
    _videos.insert(0, video);
    notifyListeners();
  }

  void deleteVideo(String id) {
    _videos.removeWhere((v) => v.id == id);
    notifyListeners();
  }
}
