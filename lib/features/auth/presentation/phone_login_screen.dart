import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/utils/phone_utils.dart';
import '../../../services/firebase/firebase_service.dart';
import '../../../widgets/dhiman_button.dart';

class PhoneLoginScreen extends ConsumerStatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  ConsumerState<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends ConsumerState<PhoneLoginScreen> {
  final _phoneController = TextEditingController();
  bool _loading = false;

  Future<void> _sendOtp() async {
    final phone = _phoneController.text.trim();
    if (!isValidBdPhone(phone)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('সঠিক নম্বর দিন: 01XXXXXXXXX')),
      );
      return;
    }
    if (FirebaseService.isDemoMode) {
      context.push('/otp?phone=${Uri.encodeComponent(phone)}');
      return;
    }
    setState(() => _loading = true);
    await ref.read(authServiceProvider).verifyPhone(
          phoneNumber: phone,
          onCodeSent: (_) {
            if (mounted) {
              context.push('/otp?phone=${Uri.encodeComponent(phone)}');
            }
          },
          onAutoVerify: (_) {
            if (mounted) context.go('/home');
          },
          onError: (msg) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(msg)),
              );
            }
          },
        );
    if (mounted) setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('মোবাইল লগইন')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'বাংলাদেশি মোবাইল নম্বর',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Grameenphone, Robi, Banglalink, Airtel, Teletalk',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                prefixText: '${AppConstants.countryCode} ',
                hintText: '1XXXXXXXXX',
                prefixIcon: const Icon(Icons.phone_android),
              ),
            ),
            const SizedBox(height: 24),
            DhimanButton(
              label: 'OTP পাঠান',
              onPressed: _sendOtp,
              isLoading: _loading,
            ),
          ],
        ),
      ),
    );
  }
}
