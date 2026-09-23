class AudioLesson {
  final String id;
  final String titleAr;
  final String titleHa;
  final String speakerAr;
  final String speakerHa;
  final String category;
  final String duration;
  final String audioUrl;
  final String date;
  final String fileSize;
  final bool featured;

  AudioLesson({
    required this.id,
    required this.titleAr,
    required this.titleHa,
    required this.speakerAr,
    required this.speakerHa,
    required this.category,
    required this.duration,
    required this.audioUrl,
    required this.date,
    this.fileSize = '20 MB',
    this.featured = false,
  });

  String getLocalizedTitle(String lang) => lang == 'ar' ? titleAr : titleHa;
  String getLocalizedSpeaker(String lang) => lang == 'ar' ? speakerAr : speakerHa;

  Map<String, dynamic> toJson() => {
    'id': id,
    'titleAr': titleAr,
    'titleHa': titleHa,
    'speakerAr': speakerAr,
    'speakerHa': speakerHa,
    'category': category,
    'duration': duration,
    'audioUrl': audioUrl,
    'date': date,
    'fileSize': fileSize,
    'featured': featured,
  };

  factory AudioLesson.fromJson(Map<String, dynamic> json) => AudioLesson(
    id: json['id'] ?? '',
    titleAr: json['titleAr'] ?? '',
    titleHa: json['titleHa'] ?? '',
    speakerAr: json['speakerAr'] ?? '',
    speakerHa: json['speakerHa'] ?? '',
    category: json['category'] ?? 'aqeedah',
    duration: json['duration'] ?? '45:00',
    audioUrl: json['audioUrl'] ?? '',
    date: json['date'] ?? '',
    fileSize: json['fileSize'] ?? '20 MB',
    featured: json['featured'] ?? false,
  );
}
