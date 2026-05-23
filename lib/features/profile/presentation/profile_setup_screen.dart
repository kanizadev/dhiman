import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../models/user_profile.dart';
import '../../../widgets/dhiman_button.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _institutionController = TextEditingController();
  ExamLevel? _examLevel = ExamLevel.hsc;
  String? _board = AppConstants.educationBoards.first;
  String? _department = 'Science';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('প্রোফাইল সেটআপ')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const CircleAvatar(radius: 48, child: Icon(Icons.person, size: 48)),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'পূর্ণ নাম'),
                validator: (v) => v?.isNotEmpty == true ? null : 'প্রয়োজন',
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _institutionController,
                decoration: const InputDecoration(labelText: 'প্রতিষ্ঠান'),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<ExamLevel>(
                value: _examLevel,
                decoration: const InputDecoration(labelText: 'SSC / HSC'),
                items: ExamLevel.values
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.name.toUpperCase()),
                        ))
                    .toList(),
                onChanged: (v) => setState(() => _examLevel = v),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _board,
                decoration: const InputDecoration(labelText: 'শিক্ষা বোর্ড'),
                items: AppConstants.educationBoards
                    .map((b) => DropdownMenuItem(value: b, child: Text(b)))
                    .toList(),
                onChanged: (v) => setState(() => _board = v),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _department,
                decoration: const InputDecoration(labelText: 'বিভাগ / গ্রুপ'),
                items: AppConstants.hscGroups
                    .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                    .toList(),
                onChanged: (v) => setState(() => _department = v),
              ),
              const SizedBox(height: 32),
              DhimanButton(
                label: 'সংরক্ষণ করুন',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.go('/home');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
