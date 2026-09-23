import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/library_provider.dart';
import '../widgets/audio_tile.dart';

class AudiosScreen extends StatelessWidget {
  const AudiosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final libProvider = Provider.of<LibraryProvider>(context);
    final audios = libProvider.filteredAudios;

    return Scaffold(
      appBar: AppBar(
        title: const Text('🎧 Karatuttukan Murya (Audios)'),
        backgroundColor: const Color(0xFF0A533F),
        foregroundColor: Colors.white,
      ),
      body: audios.isEmpty
          ? const Center(
              child: Text('Ba a sami karatun sauti ba.', style: TextStyle(color: Colors.grey)),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: audios.length,
              itemBuilder: (context, index) {
                return AudioTileWidget(audio: audios[index]);
              },
            ),
    );
  }
}
