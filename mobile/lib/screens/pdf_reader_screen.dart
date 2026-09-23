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
  int _currentPage = 1;
  bool _isNightMode = false;

  @override
  Widget build(BuildContext context) {
    final libProvider = Provider.of<LibraryProvider>(context);
    final title = widget.book.getLocalizedTitle(libProvider.currentLang);

    return Scaffold(
      backgroundColor: _isNightMode ? const Color(0xFF1A1A1A) : const Color(0xFFF9F6EE),
      appBar: AppBar(
        title: Text(title, style: const TextStyle(fontSize: 15)),
        backgroundColor: _isNightMode ? Colors.black : const Color(0xFF0A533F),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(_isNightMode ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: () => setState(() => _isNightMode = !_isNightMode),
          ),
        ],
      ),
      body: Column(
        children: [
          // Reader Canvas Area
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _isNightMode ? const Color(0xFF262626) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.picture_as_pdf,
                      size: 72,
                      color: const Color(0xFFC5A059),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _isNightMode ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Shafi na $_currentPage daga ${widget.book.pages}',
                      style: const TextStyle(color: Color(0xFFC5A059), fontSize: 13),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0A533F).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Ana nuna matani da fassarar littafin daidai...',
                        style: TextStyle(fontSize: 12, color: Color(0xFF0A533F)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Reading Controller
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: _isNightMode ? Colors.black : Colors.white,
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
                  onPressed: _currentPage > 1 ? () => setState(() => _currentPage--) : null,
                  icon: const Icon(Icons.arrow_back, size: 16),
                  label: const Text('Baya'),
                ),
                Text(
                  '$_currentPage / ${widget.book.pages}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _isNightMode ? Colors.white : Colors.black87,
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0A533F),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _currentPage < widget.book.pages ? () => setState(() => _currentPage++) : null,
                  icon: const Icon(Icons.arrow_forward, size: 16),
                  label: const Text('Gaba'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
