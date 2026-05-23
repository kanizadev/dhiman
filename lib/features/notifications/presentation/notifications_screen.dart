import 'package:flutter/material.dart';

import '../../../widgets/blob_background.dart';
import '../../../widgets/dhiman_card.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  static const _items = [
    ('পরীক্ষা রিমাইন্ডার', 'Physics Model Test আজ সন্ধ্যা ৬টায়', Icons.quiz),
    ('স্ট্রিক', '১২ দিনের স্ট্রিক চালিয়ে যান! 🔥', Icons.local_fire_department),
    ('সামাজিক', 'সাদিয়া আপনার পোস্টে রিঅ্যাক্ট করেছে', Icons.favorite_outline),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('নোটিফিকেশন')),
      body: BlobBackground(
        child: ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: _items.length,
          itemBuilder: (_, i) {
            final item = _items[i];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: DhimanCard(
                child: ListTile(
                  leading: Icon(item.$3),
                  title: Text(item.$1),
                  subtitle: Text(item.$2),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
