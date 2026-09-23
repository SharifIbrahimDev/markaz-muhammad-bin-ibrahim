class Book {
  final String id;
  final String titleAr;
  final String titleHa;
  final String authorAr;
  final String authorHa;
  final String category;
  final int pages;
  final String size;
  final String year;
  final String cover;
  final String pdfUrl;
  final String descriptionAr;
  final String descriptionHa;
  final bool featured;
  final int downloads;

  Book({
    required this.id,
    required this.titleAr,
    required this.titleHa,
    required this.authorAr,
    required this.authorHa,
    required this.category,
    required this.pages,
    required this.size,
    required this.year,
    required this.cover,
    required this.pdfUrl,
    required this.descriptionAr,
    required this.descriptionHa,
    this.featured = false,
    this.downloads = 0,
  });

  String getLocalizedTitle(String lang) => lang == 'ar' ? titleAr : titleHa;
  String getLocalizedAuthor(String lang) => lang == 'ar' ? authorAr : authorHa;
  String getLocalizedDescription(String lang) => lang == 'ar' ? descriptionAr : descriptionHa;

  Map<String, dynamic> toJson() => {
    'id': id,
    'titleAr': titleAr,
    'titleHa': titleHa,
    'authorAr': authorAr,
    'authorHa': authorHa,
    'category': category,
    'pages': pages,
    'size': size,
    'year': year,
    'cover': cover,
    'pdfUrl': pdfUrl,
    'descriptionAr': descriptionAr,
    'descriptionHa': descriptionHa,
    'featured': featured,
    'downloads': downloads,
  };

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    id: json['id'] ?? '',
    titleAr: json['titleAr'] ?? '',
    titleHa: json['titleHa'] ?? '',
    authorAr: json['authorAr'] ?? '',
    authorHa: json['authorHa'] ?? '',
    category: json['category'] ?? 'aqeedah',
    pages: json['pages'] ?? 100,
    size: json['size'] ?? '5 MB',
    year: json['year'] ?? '',
    cover: json['cover'] ?? '',
    pdfUrl: json['pdfUrl'] ?? '',
    descriptionAr: json['descriptionAr'] ?? '',
    descriptionHa: json['descriptionHa'] ?? '',
    featured: json['featured'] ?? false,
    downloads: json['downloads'] ?? 0,
  );
}
