import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/library_provider.dart';
import '../widgets/book_card.dart';

class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final libProvider = Provider.of<LibraryProvider>(context);
    final books = libProvider.filteredBooks;

    final categories = [
      {'id': 'all', 'label': 'Duka (All)'},
      {'id': 'aqeedah', 'label': 'العقيدة (Aqeedah)'},
      {'id': 'fiqh', 'label': 'الفقه (Fiqh)'},
      {'id': 'hadith', 'label': 'الحديث (Hadith)'},
      {'id': 'tafseer', 'label': 'التفسير (Tafsir)'},
      {'id': 'fatawa', 'label': 'الفتاوى (Fatawa)'},
      {'id': 'arabic', 'label': 'العربية (Arabic)'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('📚 Maktabar Littattafai (PDFs)'),
        backgroundColor: const Color(0xFF0A533F),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Category chips bar
          Container(
            height: 55,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final cat = categories[index];
                final isSelected = libProvider.activeCategory == cat['id'];
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(cat['label']!),
                    selected: isSelected,
                    selectedColor: const Color(0xFF0A533F),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    backgroundColor: Colors.grey.withOpacity(0.1),
                    onSelected: (_) => libProvider.setCategory(cat['id']!),
                  ),
                );
              },
            ),
          ),

          // Books Grid
          Expanded(
            child: books.isEmpty
                ? const Center(
                    child: Text('Ba a sami littafi ba.', style: TextStyle(color: Colors.grey)),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.68,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                    ),
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      return BookCardWidget(book: books[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
