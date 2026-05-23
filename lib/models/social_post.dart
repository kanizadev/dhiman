import 'package:equatable/equatable.dart';

class SocialPost extends Equatable {
  const SocialPost({
    required this.id,
    required this.authorId,
    required this.authorName,
    required this.content,
    required this.createdAt,
    this.authorPhotoUrl,
    this.type = PostType.achievement,
    this.reactions = const {},
    this.commentCount = 0,
    this.imageUrl,
    this.metadata,
  });

  final String id;
  final String authorId;
  final String authorName;
  final String? authorPhotoUrl;
  final String content;
  final DateTime createdAt;
  final PostType type;
  final Map<String, int> reactions;
  final int commentCount;
  final String? imageUrl;
  final Map<String, dynamic>? metadata;

  factory SocialPost.fromMap(Map<String, dynamic> map, String id) {
    return SocialPost(
      id: id,
      authorId: map['authorId'] as String? ?? '',
      authorName: map['authorName'] as String? ?? 'Student',
      authorPhotoUrl: map['authorPhotoUrl'] as String?,
      content: map['content'] as String? ?? '',
      createdAt: DateTime.tryParse(map['createdAt']?.toString() ?? '') ??
          DateTime.now(),
      type: PostType.values.firstWhere(
        (e) => e.name == map['type'],
        orElse: () => PostType.achievement,
      ),
      reactions: Map<String, int>.from(map['reactions'] as Map? ?? {}),
      commentCount: map['commentCount'] as int? ?? 0,
      imageUrl: map['imageUrl'] as String?,
      metadata: map['metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toMap() => {
        'authorId': authorId,
        'authorName': authorName,
        'authorPhotoUrl': authorPhotoUrl,
        'content': content,
        'createdAt': createdAt.toIso8601String(),
        'type': type.name,
        'reactions': reactions,
        'commentCount': commentCount,
        'imageUrl': imageUrl,
        'metadata': metadata,
      };

  @override
  List<Object?> get props => [id];
}

enum PostType { achievement, streak, goal, progress, motivation }
