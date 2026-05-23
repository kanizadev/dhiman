import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/theme/app_borders.dart';
import '../../../core/theme/app_colors.dart';
import '../../../services/firebase/firebase_service.dart';
import '../../../widgets/dhiman_button.dart';

class OtpScreen extends ConsumerStatefulWidget {
  const OtpScreen({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final _pinController = TextEditingController();
  int _secondsLeft = AppConstants.otpResendSeconds;
  Timer? _timer;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _secondsLeft = AppConstants.otpResendSeconds);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsLeft <= 0) {
        t.cancel();
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  Future<void> _verify() async {
    final code = _pinController.text;
    if (code.length < 6) return;
    if (FirebaseService.isDemoMode) {
      context.go('/home');
      return;
    }
    setState(() => _loading = true);
    try {
      await ref.read(authServiceProvider).verifyOtp(code);
      if (mounted) context.go('/home');
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ভুল OTP')),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 48,
      height: 56,
      textStyle: Theme.of(context).textTheme.titleLarge,
      decoration: AppBorders.box(
        context: context,
        backgroundColor: Theme.of(context).cardTheme.color,
        radius: 16,
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('OTP যাচাই')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text('${widget.phoneNumber} নম্বরে কোড পাঠানো হয়েছে'),
            const SizedBox(height: 32),
            Pinput(
              controller: _pinController,
              length: 6,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  border: Border.all(color: AppColors.coffeeBrown, width: 2),
                ),
              ),
              onCompleted: (_) => _verify(),
            ),
            const SizedBox(height: 24),
            DhimanButton(
              label: 'যাচাই করুন',
              onPressed: _verify,
              isLoading: _loading,
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: _secondsLeft > 0 ? null : _startTimer,
              child: Text(
                _secondsLeft > 0
                    ? 'আবার পাঠান ($_secondsLeft সেকেন্ড)'
                    : 'আবার OTP পাঠান',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
