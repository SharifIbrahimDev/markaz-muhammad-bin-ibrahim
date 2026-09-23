import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/library_provider.dart';
import '../widgets/book_card.dart';
import '../widgets/audio_tile.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final libProvider = Provider.of<LibraryProvider>(context);
    final favBooks = libProvider.books.where((b) => libProvider.isFavorite(b.id)).toList();
    final favAudios = libProvider.audios.where((a) => libProvider.isFavorite(a.id)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('⭐ Abubuwan da Na Ajiye'),
        backgroundColor: const Color(0xFF0A533F),
        foregroundColor: Colors.white,
      ),
      body: (favBooks.isEmpty && favAudios.isEmpty)
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bookmark_border, size: 64, color: Colors.grey),
                  SizedBox(height: 12),
                  Text('Ba ka ajiye komai ba tukunna.', style: TextStyle(color: Colors.grey)),
                ],
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (favBooks.isNotEmpty) ...[
                  const Text('📚 Littattafan da Ka Ajiye', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 240,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: favBooks.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 150,
                          margin: const EdgeInsets.only(right: 12),
                          child: BookCardWidget(book: favBooks[index]),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
                if (favAudios.isNotEmpty) ...[
                  const Text('🎧 Karatuttukan da Ka Ajiye', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 12),
                  ...favAudios.map((audio) => AudioTileWidget(audio: audio)),
                ],
              ],
            ),
    );
  }
}
