import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/library_provider.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final libProvider = Provider.of<LibraryProvider>(context);
    final schedule = libProvider.schedule;

    return Scaffold(
      appBar: AppBar(
        title: const Text('📅 Jadawalin Karatuttuka'),
        backgroundColor: const Color(0xFF0A533F),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: schedule.length,
        itemBuilder: (context, index) {
          final item = schedule[index];
          final day = item.getLocalizedDay(libProvider.currentLang);
          final subject = item.getLocalizedSubject(libProvider.currentLang);
          final teacher = item.getLocalizedTeacher(libProvider.currentLang);
          final location = item.getLocalizedLocation(libProvider.currentLang);

          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFC5A059), width: 1),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2)),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 65,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0A533F).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      const Text('🗓️', style: TextStyle(fontSize: 20)),
                      const SizedBox(height: 4),
                      Text(
                        day,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Color(0xFF0A533F)),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(subject, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
                      const SizedBox(height: 4),
                      Text('🎙️ $teacher', style: const TextStyle(fontSize: 12, color: Color(0xFFC5A059))),
                      const SizedBox(height: 6),
                      Text('⏰ ${item.time}', style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
                      Text('📍 $location', style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
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
