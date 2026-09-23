class VideoLesson {
  final String id;
  final String titleAr;
  final String titleHa;
  final String instructorAr;
  final String instructorHa;
  final String duration;
  final String thumbnail;
  final String videoUrl;
  final String category;
  final String date;
  final int views;
  final bool featured;

  VideoLesson({
    required this.id,
    required this.titleAr,
    required this.titleHa,
    required this.instructorAr,
    required this.instructorHa,
    required this.duration,
    required this.thumbnail,
    required this.videoUrl,
    required this.category,
    required this.date,
    this.views = 0,
    this.featured = false,
  });

  String getLocalizedTitle(String lang) => lang == 'ar' ? titleAr : titleHa;
  String getLocalizedInstructor(String lang) => lang == 'ar' ? instructorAr : instructorHa;

  Map<String, dynamic> toJson() => {
    'id': id,
    'titleAr': titleAr,
    'titleHa': titleHa,
    'instructorAr': instructorAr,
    'instructorHa': instructorHa,
    'duration': duration,
    'thumbnail': thumbnail,
    'videoUrl': videoUrl,
    'category': category,
    'date': date,
    'views': views,
    'featured': featured,
  };

  factory VideoLesson.fromJson(Map<String, dynamic> json) => VideoLesson(
    id: json['id'] ?? '',
    titleAr: json['titleAr'] ?? '',
    titleHa: json['titleHa'] ?? '',
    instructorAr: json['instructorAr'] ?? '',
    instructorHa: json['instructorHa'] ?? '',
    duration: json['duration'] ?? '45:00',
    thumbnail: json['thumbnail'] ?? '',
    videoUrl: json['videoUrl'] ?? '',
    category: json['category'] ?? 'lessons',
    date: json['date'] ?? '',
    views: json['views'] ?? 0,
    featured: json['featured'] ?? false,
  );
}
