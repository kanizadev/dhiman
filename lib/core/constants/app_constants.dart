/// App-wide constants for ধীমান (Dhiman)
abstract final class AppConstants {
  static const String appName = 'ধীমান';
  static const String appNameEn = 'Dhiman';
  static const String appTagline = 'তোমার বন্ধু ডিজিটাল স্টাডি কম্প্যানিয়ন';

  static const String countryCode = '+880';
  static final RegExp bdPhoneRegex = RegExp(r'^(?:\+880|880|0)?1[3-9]\d{8}$');

  static const List<String> educationBoards = [
    'ঢাকা',
    'রাজশাহী',
    'কুমিল্লা',
    'যশোর',
    'চট্টগ্রাম',
    'বরিশাল',
    'সylhet',
    'সিলেট',
    'দিনাজপুর',
    'ময়মনসিংহ',
    'Mymensingh',
  ];

  static const List<String> examLevels = ['SSC', 'HSC'];

  static const List<String> hscGroups = [
    'Science',
    'Commerce',
    'Humanities',
    'বিজ্ঞান',
    'বাণিজ্য',
    'মানবিক',
  ];

  static const List<String> subjects = [
    'Physics',
    'Chemistry',
    'Biology',
    'Higher Math',
    'Bangla',
    'English',
    'ICT',
    'Accounting',
    'Finance',
    'Economics',
  ];

  static const Map<String, String> subjectNamesBn = {
    'Physics': 'পদার্থবিজ্ঞান',
    'Chemistry': 'রসায়ন',
    'Biology': 'জীববিজ্ঞান',
    'Higher Math': 'উচ্চতর গণিত',
    'Bangla': 'বাংলা',
    'English': 'ইংরেজি',
    'ICT': 'তথ্য ও যোগাযোগ প্রযুক্তি',
    'Accounting': 'হিসাববিজ্ঞান',
    'Finance': 'ফাইন্যান্স',
    'Economics': 'অর্থনীতি',
  };

  static const int otpResendSeconds = 60;
  static const int pomodoroWorkMinutes = 25;
  static const int pomodoroBreakMinutes = 5;
}
