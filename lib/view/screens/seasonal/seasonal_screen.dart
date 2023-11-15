import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/constants/theme/colors.dart';
import 'package:flutter_anime_manga_app/view/screens/seasonal/pages/season_archive_page.dart';
import 'package:flutter_anime_manga_app/view/screens/seasonal/pages/season_last_page.dart';
import 'package:flutter_anime_manga_app/view/screens/seasonal/pages/season_now_page.dart';
import 'package:flutter_anime_manga_app/view/screens/seasonal/pages/season_upcoming_page.dart';

class SeasonalScreen extends StatefulWidget {
  const SeasonalScreen({super.key});

  @override
  State<SeasonalScreen> createState() => _SeasonalScreenState();
}

class _SeasonalScreenState extends State<SeasonalScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Tab> _tabs = [
    const Tab(
      text: 'Last',
    ),
    const Tab(
      text: 'This Season',
    ),
    const Tab(
      text: 'Next',
    ),
    const Tab(
      text: 'Archive',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      drawer: const Drawer(),
      appBar: AppBar(
        backgroundColor: MyColors.primary,
        title: const Text(
          'Seasonal',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        bottom: TabBar(
          indicatorColor: MyColors.primary,
          labelColor: Theme.of(context).textTheme.bodySmall!.color,
          labelStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelColor:
              Theme.of(context).textTheme.bodySmall!.color!.withOpacity(0.6),
          physics: const BouncingScrollPhysics(),
          isScrollable: true,
          controller: _tabController,
          tabs: _tabs,
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          physics: const BouncingScrollPhysics(),
          controller: _tabController,
          children: const [
            SeasonLastPage(),
            SeasonNowPage(),
            SeasonUpcomingPage(),
            SeasonArchivePage(),
          ],
        ),
      ),
    );
  }
}
