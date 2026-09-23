import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/library_provider.dart';
import '../widgets/book_card.dart';
import '../widgets/audio_tile.dart';
import 'book_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final libProvider = Provider.of<LibraryProvider>(context);
    final books = libProvider.books;
    final audios = libProvider.audios;
    final featuredBooks = books.where((b) => b.featured).toList();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Islamic Center App Bar Banner
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF06382A), Color(0xFF0A533F), Color(0xFF04241B)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 70, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFC5A059).withOpacity(0.25),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFFDFBA73)),
                        ),
                        child: const Text(
                          '✨ مركز محمد بن إبراهيم آل الشيخ رحمه الله',
                          style: TextStyle(color: Color(0xFFDFBA73), fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Dandalin Karatuttuka da Littattafan Addini',
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Littattafan PDF, Sautin Murya, da Bidiyoyi',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Search Bar Sliver
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (value) => libProvider.setSearchQuery(value),
                decoration: InputDecoration(
                  hintText: 'Nemi littafi, karatun sauti, ko malami...',
                  prefixIcon: const Icon(Icons.search, color: Color(0xFF0A533F)),
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Color(0xFFC5A059)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
                  ),
                ),
              ),
            ),
          ),

          // Featured Books Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '📚 Fitattun Littattafai (Featured)',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${featuredBooks.length} littattafai',
                    style: const TextStyle(fontSize: 12, color: Color(0xFFC5A059)),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                itemCount: featuredBooks.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 155,
                    margin: const EdgeInsets.only(right: 14),
                    child: BookCardWidget(book: featuredBooks[index]),
                  );
                },
              ),
            ),
          ),

          // Recent Audio Lectures Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: const Text(
                '🎧 Sabbin Karatuttukan Murya (Audios)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return AudioTileWidget(audio: audios[index]);
                },
                childCount: audios.length,
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 80),
          ),
        ],
      ),
    );
  }
}
