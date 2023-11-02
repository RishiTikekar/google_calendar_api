import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtask/UI/screens/all_task_screen.dart';
import 'package:testtask/UI/screens/recent_task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ValueNotifier<int>(0))],
      child: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();
  final List<Widget> tabs = const [RecentTaskScreen(), AllTaskScreen()];
  @override
  Widget build(BuildContext context) {
    final currentTabIndex = context.watch<ValueNotifier<int>>().value;

    return Scaffold(
      body: tabs[currentTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'Recent'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'All')
        ],
        currentIndex: currentTabIndex,
        onTap: (value) => context.read<ValueNotifier<int>>().value = value,
      ),
    );
  }
}
