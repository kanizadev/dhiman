import '../../core/constants/app_constants.dart';
import '../../models/exam_model.dart';
import '../../models/learning_content.dart';
import '../../models/productivity_models.dart';
import '../../models/social_post.dart';
import '../../models/user_profile.dart';

/// Demo data when Firebase is not configured
abstract final class MockData {
  static const demoProfile = UserProfile(
    uid: 'demo_user',
    fullName: 'রাহাত হাসান',
    email: 'arif@example.com',
    phone: '+8801712345678',
    institution: 'ঢাকা কলেজ',
    examLevel: ExamLevel.hsc,
    department: 'Science',
    board: 'ঢাকা',
    academicYear: '2026',
    bio: 'HSC Science — Physics lover 📚',
    favoriteSubjects: ['Physics', 'Higher Math'],
    xpPoints: 2450,
    streakDays: 12,
  );

  static final subjects = AppConstants.subjects
      .map(
        (name) => SubjectModel(
          id: name.toLowerCase().replaceAll(' ', '_'),
          name: name,
          nameBn: AppConstants.subjectNamesBn[name] ?? name,
          chapterCount: 8 + name.hashCode % 6,
          questionCount: 120 + name.hashCode % 80,
        ),
      )
      .toList();

  static final liveExams = [
    ExamModel(
      id: 'exam_1',
      title: 'Physics Model Test 01',
      subject: 'Physics',
      durationMinutes: 60,
      totalMarks: 100,
      status: ExamStatus.live,
      questionCount: 30,
      participantCount: 342,
    ),
    ExamModel(
      id: 'exam_2',
      title: 'Chemistry Board Pattern',
      subject: 'Chemistry',
      durationMinutes: 45,
      totalMarks: 50,
      status: ExamStatus.scheduled,
      scheduledAt: DateTime.now().add(const Duration(hours: 3)),
      questionCount: 25,
    ),
  ];

  static final socialPosts = [
    SocialPost(
      id: 'post_1',
      authorId: 'u1',
      authorName: 'সাদিয়া রহমান',
      content: '১২ দিনের স্টাডি স্ট্রিক! 🔥 আজ ৩ ঘণ্টা পদার্থ পড়েছি।',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      type: PostType.streak,
      reactions: {'👏': 24, '🔥': 18},
      commentCount: 5,
    ),
    SocialPost(
      id: 'post_2',
      authorId: 'u2',
      authorName: 'রাফি আহমেদ',
      content: 'HSC Physics Model Test এ ৯৫% স্কোর! ধীমানের প্রশ্ন ব্যাংক অনেক কাজে লাগল।',
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      type: PostType.achievement,
      reactions: {'🎉': 42, '💪': 15},
      commentCount: 12,
    ),
  ];

  static final studyGoals = [
    StudyGoal(
      id: 'g1',
      title: 'Physics Chapter 5 সম্পূর্ণ',
      targetDate: DateTime.now().add(const Duration(days: 3)),
      progress: 0.65,
      subject: 'Physics',
    ),
    StudyGoal(
      id: 'g2',
      title: 'Weekly 20 MCQ practice',
      targetDate: DateTime.now().add(const Duration(days: 7)),
      progress: 0.4,
    ),
  ];

  static final weeklyStudyMinutes = [45, 90, 60, 120, 75, 100, 85];
}
