class ScheduleItem {
  final String id;
  final String dayAr;
  final String dayHa;
  final String time;
  final String subjectAr;
  final String subjectHa;
  final String teacherAr;
  final String teacherHa;
  final String locationAr;
  final String locationHa;

  ScheduleItem({
    required this.id,
    required this.dayAr,
    required this.dayHa,
    required this.time,
    required this.subjectAr,
    required this.subjectHa,
    required this.teacherAr,
    required this.teacherHa,
    required this.locationAr,
    required this.locationHa,
  });

  String getLocalizedDay(String lang) => lang == 'ar' ? dayAr : dayHa;
  String getLocalizedSubject(String lang) => lang == 'ar' ? subjectAr : subjectHa;
  String getLocalizedTeacher(String lang) => lang == 'ar' ? teacherAr : teacherHa;
  String getLocalizedLocation(String lang) => lang == 'ar' ? locationAr : locationHa;

  Map<String, dynamic> toJson() => {
    'id': id,
    'dayAr': dayAr,
    'dayHa': dayHa,
    'time': time,
    'subjectAr': subjectAr,
    'subjectHa': subjectHa,
    'teacherAr': teacherAr,
    'teacherHa': teacherHa,
    'locationAr': locationAr,
    'locationHa': locationHa,
  };

  factory ScheduleItem.fromJson(Map<String, dynamic> json) => ScheduleItem(
    id: json['id'] ?? '',
    dayAr: json['dayAr'] ?? '',
    dayHa: json['dayHa'] ?? '',
    time: json['time'] ?? '',
    subjectAr: json['subjectAr'] ?? '',
    subjectHa: json['subjectHa'] ?? '',
    teacherAr: json['teacherAr'] ?? '',
    teacherHa: json['teacherHa'] ?? '',
    locationAr: json['locationAr'] ?? '',
    locationHa: json['locationHa'] ?? '',
  );
}
