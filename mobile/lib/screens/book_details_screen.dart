import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/book.dart';
import '../providers/library_provider.dart';
import 'pdf_reader_screen.dart';

class BookDetailsScreen extends StatelessWidget {
  final Book book;

  const BookDetailsScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final libProvider = Provider.of<LibraryProvider>(context);
    final isFav = libProvider.isFavorite(book.id);
    final title = book.getLocalizedTitle(libProvider.currentLang);
    final author = book.getLocalizedAuthor(libProvider.currentLang);
    final desc = book.getLocalizedDescription(libProvider.currentLang);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFF0A533F),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: Colors.white),
            onPressed: () => libProvider.toggleFavorite(book.id),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 240,
                width: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFC5A059), width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.network(
                    book.cover,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Center(
                      child: Icon(Icons.menu_book, size: 64, color: Color(0xFF0A533F)),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 6),
            Text(
              'Mawallafi: $author',
              style: const TextStyle(fontSize: 14, color: Color(0xFFC5A059), fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoBadge('📄 Shafuka', '${book.pages}'),
                _buildInfoBadge('💾 Girma', book.size),
                _buildInfoBadge('🏷️ Bangare', book.category),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Bayanin Littafi:',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              desc,
              style: const TextStyle(fontSize: 13, height: 1.6, color: Colors.black87),
            ),
            const SizedBox(height: 30),
            if (book.isUpcoming)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFC5A059).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFC5A059)),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.hourglass_top, color: Color(0xFFC5A059), size: 32),
                    SizedBox(height: 8),
                    Text(
                      'Wannan Littafi Yana Nan Tafe (قيد الإعداد والنشر)',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF0A533F)),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Za a wallafa shi kuma za a iya karantawa da saukewa a nan da zarar an kammala buga shi in sha Allah.',
                      style: TextStyle(fontSize: 12, color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            else
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0A533F),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectanglePlatform(12),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PdfReaderScreen(book: book),
                          ),
                        );
                      },
                      icon: const Icon(Icons.menu_book),
                      label: const Text('Karanta PDF'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC5A059),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectanglePlatform(12),
                      ),
                      onPressed: () async {
                        final uri = Uri.parse(book.pdfUrl);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri, mode: LaunchMode.externalApplication);
                        }
                      },
                      icon: const Icon(Icons.download),
                      label: const Text('Sauke PDF'),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBadge(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF0A533F).withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
          const SizedBox(height: 2),
          Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF0A533F))),
        ],
      ),
    );
  }

  OutlinedBorder RoundedRectanglePlatform(double radius) => RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius));
}
