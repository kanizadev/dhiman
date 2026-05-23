import 'package:equatable/equatable.dart';

class SubjectModel extends Equatable {
  const SubjectModel({
    required this.id,
    required this.name,
    required this.nameBn,
    this.iconName = 'science',
    this.colorHex = '6F4E37',
    this.chapterCount = 0,
    this.questionCount = 0,
  });

  final String id;
  final String name;
  final String nameBn;
  final String iconName;
  final String colorHex;
  final int chapterCount;
  final int questionCount;

  @override
  List<Object?> get props => [id];
}

class ChapterModel extends Equatable {
  const ChapterModel({
    required this.id,
    required this.subjectId,
    required this.title,
    required this.titleBn,
    this.order = 0,
    this.mcqCount = 0,
    this.cqCount = 0,
    this.hasNotes = false,
    this.hasVideos = false,
  });

  final String id;
  final String subjectId;
  final String title;
  final String titleBn;
  final int order;
  final int mcqCount;
  final int cqCount;
  final bool hasNotes;
  final bool hasVideos;

  @override
  List<Object?> get props => [id];
}

class BoardQuestion extends Equatable {
  const BoardQuestion({
    required this.id,
    required this.subjectId,
    required this.chapterId,
    required this.year,
    required this.board,
    required this.type,
    required this.text,
    this.options = const [],
    this.correctIndex,
    this.explanation,
    this.examLevel = 'SSC',
  });

  final String id;
  final String subjectId;
  final String chapterId;
  final int year;
  final String board;
  final String type; // MCQ or CQ
  final String text;
  final List<String> options;
  final int? correctIndex;
  final String? explanation;
  final String examLevel;

  @override
  List<Object?> get props => [id];
}
