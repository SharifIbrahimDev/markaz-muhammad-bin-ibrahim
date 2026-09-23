import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/audio_lesson.dart';
import '../providers/library_provider.dart';
import '../providers/audio_player_provider.dart';

class AudioTileWidget extends StatelessWidget {
  final AudioLesson audio;

  const AudioTileWidget({super.key, required this.audio});

  @override
  Widget build(BuildContext context) {
    final libProvider = Provider.of<LibraryProvider>(context);
    final audioProvider = Provider.of<AudioPlayerProvider>(context);
    final isPlayingThis = audioProvider.currentTrack?.id == audio.id && audioProvider.isPlaying;
    final isFav = libProvider.isFavorite(audio.id);

    final title = audio.getLocalizedTitle(libProvider.currentLang);
    final speaker = audio.getLocalizedSpeaker(libProvider.currentLang);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPlayingThis ? const Color(0xFFC5A059) : const Color(0xFF0A533F).withOpacity(0.12),
          width: isPlayingThis ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (isPlayingThis) {
                audioProvider.togglePlayPause();
              } else {
                audioProvider.playTrack(audio);
              }
            },
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isPlayingThis
                      ? [const Color(0xFFC5A059), const Color(0xFFDFBA73)]
                      : [const Color(0xFF0A533F), const Color(0xFF107559)],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isPlayingThis ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 26,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  speaker,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text('⏱️ ${audio.duration}', style: const TextStyle(fontSize: 10, color: Colors.grey)),
                    const SizedBox(width: 12),
                    Text('📅 ${audio.date}', style: const TextStyle(fontSize: 10, color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: isFav ? Colors.red : Colors.grey,
              size: 20,
            ),
            onPressed: () => libProvider.toggleFavorite(audio.id),
          ),
        ],
      ),
    );
  }
}
