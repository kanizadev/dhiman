import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_borders.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../services/firebase/firebase_service.dart';
import '../../../widgets/blob_background.dart';
import '../../../widgets/dhiman_button.dart';
import '../../../widgets/dhiman_logo.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  int _tab = 1; // 0 email, 1 phone
  bool _obscure = true;
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (FirebaseService.isDemoMode) {
      context.go('/home');
      return;
    }
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      if (_tab == 0) {
        await ref.read(authServiceProvider).signInWithEmail(
              _emailController.text,
              _passwordController.text,
            );
        if (mounted) context.go('/home');
      } else {
        context.push(
          '/phone-login?phone=${Uri.encodeComponent(_phoneController.text)}',
        );
      }
    } catch (_) {
      setState(() => _error = 'লগইন ব্যর্থ');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _googleSignIn() async {
    if (FirebaseService.isDemoMode) {
      context.go('/home');
      return;
    }
    setState(() => _loading = true);
    try {
      await ref.read(authServiceProvider).signInWithGoogle();
      if (mounted) context.go('/home');
    } catch (_) {
      setState(() => _error = 'Google সাইন-ইন ব্যর্থ');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: BlobBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                const Center(child: DhimanLogo(size: 40, showSubtitle: true)),
                const SizedBox(height: 40),
                OutlinedButton.icon(
                  onPressed: _loading ? null : _googleSignIn,
                  icon: const Icon(Icons.g_mobiledata, size: 28),
                  label: const Text('Google দিয়ে এগিয়ে যান'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: AppColors.cream,
                  ),
                ),
                const SizedBox(height: 28),
                Row(
                  children: [
                    Expanded(child: Divider(color: AppColors.caramel)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'অথবা',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    Expanded(child: Divider(color: AppColors.caramel)),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: AppBorders.box(
                    context: context,
                    backgroundColor: Theme.of(context).cardTheme.color,
                    radius: 20,
                  ),
                  child: Row(
                    children: [
                      _TabChip(
                        label: 'ইমেইল',
                        selected: _tab == 0,
                        onTap: () => setState(() => _tab = 0),
                      ),
                      _TabChip(
                        label: 'মোবাইল',
                        selected: _tab == 1,
                        onTap: () => setState(() => _tab = 1),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                if (_error != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      _error!,
                      style: const TextStyle(color: AppColors.coffeeBrown),
                    ),
                  ),
                if (_tab == 0) ...[
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'ইমেইল ঠিকানা',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscure,
                    decoration: InputDecoration(
                      hintText: 'পাসওয়ার্ড',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscure ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () => setState(() => _obscure = !_obscure),
                      ),
                    ),
                  ),
                ] else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 18,
                        ),
                        decoration: AppBorders.box(
                          context: context,
                          backgroundColor: AppColors.peach,
                          radius: 20,
                        ),
                        child: Text(
                          AppConstants.countryCode,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            hintText: '1XXXXXXXXX',
                          ),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 24),
                DhimanButton(
                  label: _tab == 0 ? 'লগইন' : 'OTP পাঠান',
                  onPressed: _login,
                  isLoading: _loading,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('অ্যাকাউন্ট নেই? '),
                    TextButton(
                      onPressed: () => context.push('/register'),
                      child: const Text('রেজিস্টার'),
                    ),
                  ],
                ),
                if (FirebaseService.isDemoMode)
                  TextButton(
                    onPressed: () => context.go('/home'),
                    child: const Text('ডেমো মোডে প্রবেশ'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TabChip extends StatelessWidget {
  const _TabChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: selected
              ? AppBorders.box(
                  context: context,
                  backgroundColor: AppColors.coffeeBrown,
                  radius: 16,
                )
              : null,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: selected ? AppColors.cream : AppColors.latte,
            ),
          ),
        ),
      ),
    );
  }
}
