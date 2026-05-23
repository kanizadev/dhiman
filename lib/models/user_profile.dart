import 'package:equatable/equatable.dart';

enum UserRole { student, teacher, admin }

enum ExamLevel { ssc, hsc }

class UserProfile extends Equatable {
  const UserProfile({
    required this.uid,
    required this.fullName,
    required this.email,
    this.phone,
    this.institution,
    this.examLevel,
    this.department,
    this.board,
    this.academicYear,
    this.photoUrl,
    this.bio,
    this.studyGoals = const [],
    this.favoriteSubjects = const [],
    this.dreamUniversity,
    this.role = UserRole.student,
    this.xpPoints = 0,
    this.streakDays = 0,
    this.createdAt,
    this.updatedAt,
  });

  final String uid;
  final String fullName;
  final String email;
  final String? phone;
  final String? institution;
  final ExamLevel? examLevel;
  final String? department;
  final String? board;
  final String? academicYear;
  final String? photoUrl;
  final String? bio;
  final List<String> studyGoals;
  final List<String> favoriteSubjects;
  final String? dreamUniversity;
  final UserRole role;
  final int xpPoints;
  final int streakDays;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  bool get isProfileComplete =>
      fullName.isNotEmpty &&
      institution != null &&
      examLevel != null &&
      board != null;

  factory UserProfile.fromMap(Map<String, dynamic> map, String uid) {
    return UserProfile(
      uid: uid,
      fullName: map['fullName'] as String? ?? '',
      email: map['email'] as String? ?? '',
      phone: map['phone'] as String?,
      institution: map['institution'] as String?,
      examLevel: _parseExamLevel(map['examLevel'] as String?),
      department: map['department'] as String?,
      board: map['board'] as String?,
      academicYear: map['academicYear'] as String?,
      photoUrl: map['photoUrl'] as String?,
      bio: map['bio'] as String?,
      studyGoals: List<String>.from(map['studyGoals'] as List? ?? []),
      favoriteSubjects: List<String>.from(map['favoriteSubjects'] as List? ?? []),
      dreamUniversity: map['dreamUniversity'] as String?,
      role: _parseRole(map['role'] as String?),
      xpPoints: map['xpPoints'] as int? ?? 0,
      streakDays: map['streakDays'] as int? ?? 0,
      createdAt: _parseDate(map['createdAt']),
      updatedAt: _parseDate(map['updatedAt']),
    );
  }

  Map<String, dynamic> toMap() => {
        'fullName': fullName,
        'email': email,
        'phone': phone,
        'institution': institution,
        'examLevel': examLevel?.name,
        'department': department,
        'board': board,
        'academicYear': academicYear,
        'photoUrl': photoUrl,
        'bio': bio,
        'studyGoals': studyGoals,
        'favoriteSubjects': favoriteSubjects,
        'dreamUniversity': dreamUniversity,
        'role': role.name,
        'xpPoints': xpPoints,
        'streakDays': streakDays,
        'updatedAt': DateTime.now().toIso8601String(),
      };

  UserProfile copyWith({
    String? fullName,
    String? email,
    String? phone,
    String? institution,
    ExamLevel? examLevel,
    String? department,
    String? board,
    String? academicYear,
    String? photoUrl,
    String? bio,
    List<String>? studyGoals,
    List<String>? favoriteSubjects,
    String? dreamUniversity,
    UserRole? role,
    int? xpPoints,
    int? streakDays,
  }) {
    return UserProfile(
      uid: uid,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      institution: institution ?? this.institution,
      examLevel: examLevel ?? this.examLevel,
      department: department ?? this.department,
      board: board ?? this.board,
      academicYear: academicYear ?? this.academicYear,
      photoUrl: photoUrl ?? this.photoUrl,
      bio: bio ?? this.bio,
      studyGoals: studyGoals ?? this.studyGoals,
      favoriteSubjects: favoriteSubjects ?? this.favoriteSubjects,
      dreamUniversity: dreamUniversity ?? this.dreamUniversity,
      role: role ?? this.role,
      xpPoints: xpPoints ?? this.xpPoints,
      streakDays: streakDays ?? this.streakDays,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }

  static ExamLevel? _parseExamLevel(String? value) {
    if (value == null) return null;
    return ExamLevel.values.firstWhere(
      (e) => e.name == value.toLowerCase(),
      orElse: () => ExamLevel.ssc,
    );
  }

  static UserRole _parseRole(String? value) {
    if (value == null) return UserRole.student;
    return UserRole.values.firstWhere(
      (e) => e.name == value,
      orElse: () => UserRole.student,
    );
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    return DateTime.tryParse(value.toString());
  }

  @override
  List<Object?> get props => [uid, email, fullName];
}
