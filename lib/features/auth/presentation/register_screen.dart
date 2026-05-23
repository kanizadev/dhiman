import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/providers/app_providers.dart';
import '../../../services/firebase/firebase_service.dart';
import '../../../widgets/blob_background.dart';
import '../../../widgets/dhiman_button.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    if (FirebaseService.isDemoMode) {
      context.push('/profile-setup');
      return;
    }
    setState(() => _loading = true);
    try {
      await ref.read(authServiceProvider).registerWithEmail(
            _emailController.text,
            _passwordController.text,
          );
      if (mounted) context.push('/profile-setup');
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('রেজিস্ট্রেশন ব্যর্থ')),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('রেজিস্টার')),
      body: BlobBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'পূর্ণ নাম'),
                  validator: (v) =>
                      v != null && v.isNotEmpty ? null : 'নাম প্রয়োজন',
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'ইমেইল'),
                  validator: (v) =>
                      v != null && v.contains('@') ? null : 'সঠিক ইমেইল',
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'পাসওয়ার্ড'),
                  validator: (v) =>
                      v != null && v.length >= 6 ? null : 'কমপক্ষে ৬ অক্ষর',
                ),
                const SizedBox(height: 32),
                DhimanButton(
                  label: 'অ্যাকাউন্ট তৈরি করুন',
                  onPressed: _register,
                  isLoading: _loading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
