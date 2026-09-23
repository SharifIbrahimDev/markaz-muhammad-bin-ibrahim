import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/audio_player_provider.dart';
import '../providers/library_provider.dart';

class MiniAudioPlayerWidget extends StatelessWidget {
  const MiniAudioPlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioPlayerProvider>(context);
    final libProvider = Provider.of<LibraryProvider>(context);
    final track = audioProvider.currentTrack;

    if (track == null) return const SizedBox.shrink();

    final title = track.getLocalizedTitle(libProvider.currentLang);
    final speaker = track.getLocalizedSpeaker(libProvider.currentLang);

    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF0D3B2E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFC5A059), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.35),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFC5A059),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.mic, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  speaker,
                  style: const TextStyle(
                    color: Color(0xFFDFBA73),
                    fontSize: 11,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              audioProvider.isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
              color: const Color(0xFFDFBA73),
              size: 34,
            ),
            onPressed: () => audioProvider.togglePlayPause(),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white70, size: 20),
            onPressed: () => audioProvider.stop(),
          ),
        ],
      ),
    );
  }
}
