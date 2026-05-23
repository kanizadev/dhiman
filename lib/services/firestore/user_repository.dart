import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/user_profile.dart';
import '../firebase/firebase_service.dart';

class UserRepository {
  UserRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ??
            (FirebaseService.isInitialized ? FirebaseFirestore.instance : null);

  final FirebaseFirestore? _firestore;

  CollectionReference<Map<String, dynamic>>? get _users =>
      _firestore?.collection('users');

  Stream<UserProfile?> watchProfile(String uid) {
    if (_users == null) return Stream.value(null);
    return _users!.doc(uid).snapshots().map((doc) {
      if (!doc.exists) return null;
      return UserProfile.fromMap(doc.data()!, uid);
    });
  }

  Future<UserProfile?> getProfile(String uid) async {
    if (_users == null) return null;
    final doc = await _users!.doc(uid).get();
    if (!doc.exists) return null;
    return UserProfile.fromMap(doc.data()!, uid);
  }

  Future<void> saveProfile(UserProfile profile) async {
    if (_users == null) return;
    final data = profile.toMap();
    data['createdAt'] ??= DateTime.now().toIso8601String();
    await _users!.doc(profile.uid).set(data, SetOptions(merge: true));
  }

  Future<void> updateXp(String uid, int xpDelta) async {
    if (_users == null) return;
    await _users!.doc(uid).update({
      'xpPoints': FieldValue.increment(xpDelta),
      'updatedAt': DateTime.now().toIso8601String(),
    });
  }
}
