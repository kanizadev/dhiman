import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_providers.dart';
import '../../../services/firebase/firebase_service.dart';
import '../../../widgets/dhiman_button.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool _sent = false;
  bool _loading = false;

  Future<void> _reset() async {
    if (FirebaseService.isDemoMode) {
      setState(() => _sent = true);
      return;
    }
    setState(() => _loading = true);
    try {
      await ref
          .read(authServiceProvider)
          .sendPasswordReset(_emailController.text);
      setState(() => _sent = true);
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('রিসেট লিংক পাঠানো যায়নি')),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('পাসওয়ার্ড রিসেট')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: _sent
            ? Column(
                children: [
                  const Icon(Icons.mark_email_read_outlined, size: 64),
                  const SizedBox(height: 16),
                  Text(
                    'রিসেট লিংক পাঠানো হয়েছে',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              )
            : Column(
                children: [
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(labelText: 'ইমেইল'),
                  ),
                  const SizedBox(height: 24),
                  DhimanButton(
                    label: 'রিসেট লিংক পাঠান',
                    onPressed: _reset,
                    isLoading: _loading,
                  ),
                ],
              ),
      ),
    );
  }
}
