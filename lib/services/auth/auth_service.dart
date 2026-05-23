import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../core/utils/phone_utils.dart';
import '../firebase/firebase_service.dart';

class AuthService {
  AuthService({FirebaseAuth? auth})
      : _auth = auth ?? (FirebaseService.isInitialized ? FirebaseAuth.instance : null);

  final FirebaseAuth? _auth;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  bool _googleInitialized = false;

  String? _verificationId;
  int? _resendToken;

  Stream<User?> get authStateChanges =>
      _auth?.authStateChanges() ?? const Stream.empty();

  User? get currentUser => _auth?.currentUser;

  bool get isLoggedIn => currentUser != null;

  Future<UserCredential> signInWithEmail(String email, String password) async {
    _ensureAuth();
    return _auth!.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }

  Future<UserCredential> registerWithEmail(
    String email,
    String password,
  ) async {
    _ensureAuth();
    return _auth!.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }

  Future<void> sendPasswordReset(String email) async {
    _ensureAuth();
    await _auth!.sendPasswordResetEmail(email: email.trim());
  }

  Future<void> verifyPhone({
    required String phoneNumber,
    required void Function(String verificationId) onCodeSent,
    required void Function(PhoneAuthCredential credential) onAutoVerify,
    required void Function(String message) onError,
    void Function(String verificationId)? onAutoRetrievalTimeout,
  }) async {
    _ensureAuth();
    final normalized = normalizeBdPhone(phoneNumber);
    if (!isValidBdPhone(phoneNumber) && !isValidBdPhone(normalized)) {
      onError('সঠিক বাংলাদেশি মোবাইল নম্বর দিন (01XXXXXXXXX)');
      return;
    }

    await _auth!.verifyPhoneNumber(
      phoneNumber: normalized,
      timeout: const Duration(seconds: 60),
      verificationCompleted: onAutoVerify,
      verificationFailed: (e) => onError(e.message ?? 'যাচাইকরণ ব্যর্থ'),
      codeSent: (verificationId, resendToken) {
        _verificationId = verificationId;
        _resendToken = resendToken;
        onCodeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (verificationId) {
        _verificationId = verificationId;
        onAutoRetrievalTimeout?.call(verificationId);
      },
      forceResendingToken: _resendToken,
    );
  }

  Future<UserCredential> verifyOtp(String smsCode) async {
    _ensureAuth();
    final verificationId = _verificationId;
    if (verificationId == null) {
      throw FirebaseAuthException(
        code: 'missing-verification-id',
        message: 'প্রথমে OTP পাঠান',
      );
    }
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode.trim(),
    );
    return _auth!.signInWithCredential(credential);
  }

  Future<void> _ensureGoogleSignIn() async {
    if (!_googleInitialized) {
      await _googleSignIn.initialize();
      _googleInitialized = true;
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    _ensureAuth();
    await _ensureGoogleSignIn();
    final googleUser = await _googleSignIn.authenticate();
    final googleAuth = googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );
    return _auth!.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth?.signOut();
    _verificationId = null;
    _resendToken = null;
  }

  void _ensureAuth() {
    if (_auth == null) {
      throw StateError(
        'Firebase Auth unavailable. Run flutterfire configure and enable Auth.',
      );
    }
  }
}
