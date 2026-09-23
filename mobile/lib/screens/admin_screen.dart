import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../models/audio_lesson.dart';
import '../providers/library_provider.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final _bookTitleHaController = TextEditingController();
  final _bookTitleArController = TextEditingController();
  final _bookAuthorController = TextEditingController();
  final _bookPdfUrlController = TextEditingController();
  final _bookPagesController = TextEditingController();
  String _bookCategory = 'aqeedah';

  @override
  Widget build(BuildContext context) {
    final libProvider = Provider.of<LibraryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('⚙️ Kula da Tsari (Admin Panel)'),
        backgroundColor: const Color(0xFF0A533F),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '➕ Sanya Sabon Littafi (PDF)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0A533F)),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _bookTitleHaController,
              decoration: const InputDecoration(
                labelText: 'Sunan Littafi (Hausa/English) *',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _bookTitleArController,
              decoration: const InputDecoration(
                labelText: 'اسم الكتاب بالعربية *',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _bookAuthorController,
              decoration: const InputDecoration(
                labelText: 'Mawallafi (Author) *',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _bookCategory,
              decoration: const InputDecoration(labelText: 'Bangare (Category)', border: OutlineInputBorder()),
              items: const [
                DropdownMenuItem(value: 'aqeedah', child: Text('العقيدة (Aqeedah)')),
                DropdownMenuItem(value: 'fiqh', child: Text('الفقه (Fiqh)')),
                DropdownMenuItem(value: 'hadith', child: Text('الحديث (Hadith)')),
                DropdownMenuItem(value: 'tafseer', child: Text('التفسير (Tafsir)')),
                DropdownMenuItem(value: 'fatawa', child: Text('الفتاوى (Fatawa)')),
                DropdownMenuItem(value: 'arabic', child: Text('العربية (Arabic)')),
              ],
              onChanged: (val) => setState(() => _bookCategory = val ?? 'aqeedah'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _bookPagesController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Adadin Shafuka (Pages)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _bookPdfUrlController,
              decoration: const InputDecoration(
                labelText: 'Hanyar PDF URL *',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC5A059),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
              ),
              onPressed: () {
                if (_bookTitleHaController.text.isEmpty || _bookPdfUrlController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Da fatan a cika dukkan bayanan da ake bukata!')),
                  );
                  return;
                }

                final newBook = Book(
                  id: 'b_${DateTime.now().millisecondsSinceEpoch}',
                  titleHa: _bookTitleHaController.text.trim(),
                  titleAr: _bookTitleArController.text.trim().isNotEmpty
                      ? _bookTitleArController.text.trim()
                      : _bookTitleHaController.text.trim(),
                  authorHa: _bookAuthorController.text.trim(),
                  authorAr: _bookAuthorController.text.trim(),
                  category: _bookCategory,
                  pages: int.tryParse(_bookPagesController.text) ?? 100,
                  size: '4.5 MB',
                  year: '1446H',
                  cover: 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&w=600&q=80',
                  pdfUrl: _bookPdfUrlController.text.trim(),
                  descriptionHa: 'Littafi ne mai albarka daga Markaz Muhammad bin Ibrahim.',
                  descriptionAr: 'كتاب مبارك من مطبوعات المركز.',
                );

                libProvider.addBook(newBook);
                _bookTitleHaController.clear();
                _bookTitleArController.clear();
                _bookAuthorController.clear();
                _bookPdfUrlController.clear();
                _bookPagesController.clear();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('An sanya sabon littafin cikin nasara!')),
                );
              },
              child: const Text('💾 Ajiye & Wallafa Littafi'),
            ),
          ],
        ),
      ),
    );
  }
}
