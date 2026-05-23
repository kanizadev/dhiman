import 'package:equatable/equatable.dart';

class StudyGoal extends Equatable {
  const StudyGoal({
    required this.id,
    required this.title,
    required this.targetDate,
    this.completed = false,
    this.progress = 0.0,
    this.subject,
  });

  final String id;
  final String title;
  final DateTime targetDate;
  final bool completed;
  final double progress;
  final String? subject;

  @override
  List<Object?> get props => [id];
}

class TodoTask extends Equatable {
  const TodoTask({
    required this.id,
    required this.title,
    this.completed = false,
    this.dueDate,
    this.priority = TaskPriority.medium,
  });

  final String id;
  final String title;
  final bool completed;
  final DateTime? dueDate;
  final TaskPriority priority;

  @override
  List<Object?> get props => [id];
}

enum TaskPriority { low, medium, high }

class HabitTracker extends Equatable {
  const HabitTracker({
    required this.id,
    required this.name,
    this.streak = 0,
    this.completedToday = false,
    this.weeklyProgress = const [],
  });

  final String id;
  final String name;
  final int streak;
  final bool completedToday;
  final List<bool> weeklyProgress;

  @override
  List<Object?> get props => [id];
}

class StudySession extends Equatable {
  const StudySession({
    required this.id,
    required this.subject,
    required this.durationMinutes,
    required this.date,
  });

  final String id;
  final String subject;
  final int durationMinutes;
  final DateTime date;

  @override
  List<Object?> get props => [id];
}
