import 'package:equatable/equatable.dart';

enum ExamType { mcq, cq, mixed }
enum ExamStatus { draft, scheduled, live, completed }

class ExamModel extends Equatable {
  const ExamModel({
    required this.id,
    required this.title,
    required this.subject,
    required this.durationMinutes,
    required this.totalMarks,
    this.description,
    this.examLevel = 'SSC',
    this.type = ExamType.mcq,
    this.status = ExamStatus.scheduled,
    this.negativeMarking = false,
    this.negativeMarkValue = 0.25,
    this.questionCount = 0,
    this.scheduledAt,
    this.createdBy,
    this.participantCount = 0,
  });

  final String id;
  final String title;
  final String subject;
  final int durationMinutes;
  final int totalMarks;
  final String? description;
  final String examLevel;
  final ExamType type;
  final ExamStatus status;
  final bool negativeMarking;
  final double negativeMarkValue;
  final int questionCount;
  final DateTime? scheduledAt;
  final String? createdBy;
  final int participantCount;

  bool get isLive => status == ExamStatus.live;

  factory ExamModel.fromMap(Map<String, dynamic> map, String id) {
    return ExamModel(
      id: id,
      title: map['title'] as String? ?? '',
      subject: map['subject'] as String? ?? '',
      durationMinutes: map['durationMinutes'] as int? ?? 60,
      totalMarks: map['totalMarks'] as int? ?? 100,
      description: map['description'] as String?,
      examLevel: map['examLevel'] as String? ?? 'SSC',
      type: _parseType(map['type'] as String?),
      status: _parseStatus(map['status'] as String?),
      negativeMarking: map['negativeMarking'] as bool? ?? false,
      negativeMarkValue: (map['negativeMarkValue'] as num?)?.toDouble() ?? 0.25,
      questionCount: map['questionCount'] as int? ?? 0,
      scheduledAt: _parseDate(map['scheduledAt']),
      createdBy: map['createdBy'] as String?,
      participantCount: map['participantCount'] as int? ?? 0,
    );
  }

  static ExamType _parseType(String? v) {
    return ExamType.values.firstWhere(
      (e) => e.name == v,
      orElse: () => ExamType.mcq,
    );
  }

  static ExamStatus _parseStatus(String? v) {
    return ExamStatus.values.firstWhere(
      (e) => e.name == v,
      orElse: () => ExamStatus.scheduled,
    );
  }

  static DateTime? _parseDate(dynamic v) {
    if (v == null) return null;
    return DateTime.tryParse(v.toString());
  }

  @override
  List<Object?> get props => [id, title];
}

class QuestionModel extends Equatable {
  const QuestionModel({
    required this.id,
    required this.text,
    required this.options,
    required this.correctIndex,
    this.explanation,
    this.marks = 1,
    this.imageUrl,
  });

  final String id;
  final String text;
  final List<String> options;
  final int correctIndex;
  final String? explanation;
  final int marks;
  final String? imageUrl;

  factory QuestionModel.fromMap(Map<String, dynamic> map, String id) {
    return QuestionModel(
      id: id,
      text: map['text'] as String? ?? '',
      options: List<String>.from(map['options'] as List? ?? []),
      correctIndex: map['correctIndex'] as int? ?? 0,
      explanation: map['explanation'] as String?,
      marks: map['marks'] as int? ?? 1,
      imageUrl: map['imageUrl'] as String?,
    );
  }

  @override
  List<Object?> get props => [id];
}
