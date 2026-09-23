import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/library_provider.dart';

class VideosScreen extends StatelessWidget {
  const VideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final libProvider = Provider.of<LibraryProvider>(context);
    final videos = libProvider.filteredVideos;

    return Scaffold(
      appBar: AppBar(
        title: const Text('🎥 Bidiyoyin Karatuttuka (Videos)'),
        backgroundColor: const Color(0xFF0A533F),
        foregroundColor: Colors.white,
      ),
      body: videos.isEmpty
          ? const Center(child: Text('Ba a sami bidiyoyi ba.', style: TextStyle(color: Colors.grey)))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: videos.length,
              itemBuilder: (context, index) {
                final video = videos[index];
                final title = video.getLocalizedTitle(libProvider.currentLang);
                final instructor = video.getLocalizedInstructor(libProvider.currentLang);

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 4)),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final uri = Uri.parse(video.videoUrl);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri, mode: LaunchMode.externalApplication);
                          }
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                              child: Image.network(
                                video.thumbnail,
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: const BoxDecoration(color: Color(0xFFC5A059), shape: BoxShape.circle),
                              child: const Icon(Icons.play_arrow, color: Colors.white, size: 36),
                            ),
                            Positioned(
                              bottom: 8,
                              right: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(6)),
                                child: Text(video.duration, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text('👨‍🏫 $instructor', style: const TextStyle(fontSize: 12, color: Color(0xFFC5A059))),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
