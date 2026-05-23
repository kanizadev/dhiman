import 'package:flutter/material.dart';

import '../../../core/theme/app_borders.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/learning_content.dart';
import '../../../shared/data/mock_data.dart';
import '../../../widgets/dhiman_card.dart';
import '../../../widgets/subject_icon.dart';

class SubjectDetailScreen extends StatefulWidget {
  const SubjectDetailScreen({super.key, required this.subjectId});

  final String subjectId;

  @override
  State<SubjectDetailScreen> createState() => _SubjectDetailScreenState();
}

class _SubjectDetailScreenState extends State<SubjectDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabs;

  static const _chapterTitles = [
    'ভৌত রাশি ও পরিমাপ',
    'গতি',
    'নিউটনের সূত্র',
    'কাজ ও শক্তি',
    'পদার্থের অবস্থা',
    'তাপ ও তাপগতিবিদ্যা',
  ];

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final subject = MockData.subjects.firstWhere(
      (s) => s.id == widget.subjectId,
      orElse: () => MockData.subjects.first,
    );

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (_, __) => [
          SliverAppBar(
            expandedHeight: 140,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(subject.nameBn),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: AppColors.accentGradient,
                ),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SubjectIcon(subject: subject.name, size: 56),
                  ),
                ),
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _TabBarDelegate(
              TabBar(
                controller: _tabs,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                labelColor: AppColors.coffeeBrown,
                tabs: const [
                  Tab(text: 'অধ্যায়'),
                  Tab(text: 'বোর্ড প্রশ্ন'),
                  Tab(text: 'নোট'),
                  Tab(text: 'ভিডিও'),
                ],
              ),
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabs,
          children: [
            _ChapterList(subject: subject),
            const Center(child: Text('বোর্ড প্রশ্ন ব্যাংক')),
            const Center(child: Text('PDF নোট')),
            const Center(child: Text('ভিডিও লেকচার')),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.quiz_outlined),
            label: const Text('মডেল টেস্ট দিন'),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: AppColors.coffeeBrown,
            ),
          ),
        ),
      ),
    );
  }
}

class _ChapterList extends StatelessWidget {
  const _ChapterList({required this.subject});

  final SubjectModel subject;

  @override
  Widget build(BuildContext context) {
    final count = subject.chapterCount.clamp(1, 6);

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: count,
      itemBuilder: (_, i) {
        final locked = i > 3;
        final completed = i < 2;
        final inProgress = i == 2;
        final title = i < _SubjectDetailScreenState._chapterTitles.length
            ? _SubjectDetailScreenState._chapterTitles[i]
            : 'অধ্যায় ${i + 1}';

        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: DhimanCard(
            padding: const EdgeInsets.all(16),
            onTap: locked ? null : () {},
            child: Row(
              children: [
                Builder(
                  builder: (context) {
                    final badgeColor = completed
                        ? AppColors.softGreen
                        : inProgress
                            ? AppColors.peach
                            : AppColors.cream;
                    return Container(
                      width: 40,
                      height: 40,
                      decoration: AppBorders.box(
                        context: context,
                        backgroundColor: badgeColor,
                        radius: 12,
                        borderWidth: AppBorders.widthThin,
                      ),
                      child: Icon(
                        locked
                            ? Icons.lock_outline
                            : completed
                                ? Icons.check_rounded
                                : Icons.menu_book_outlined,
                        color: AppBorders.iconOn(badgeColor, context),
                        size: 22,
                      ),
                    );
                  },
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      if (inProgress) ...[
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: 0.45,
                            minHeight: 5,
                            color: AppBorders.iconOn(AppColors.peach, context),
                            backgroundColor: AppColors.caramel,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (!locked) const Icon(Icons.chevron_right),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  _TabBarDelegate(this.tabBar);
  final TabBar tabBar;

  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
