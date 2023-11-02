import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:provider/provider.dart';
import 'package:testtask/UI/screens/add_task_screen.dart';
import 'package:testtask/UI/widgets/task_card.dart';
import 'package:testtask/UI/widgets/timing_header.dart';
import 'package:testtask/models/task.dart';
import 'package:testtask/provider/all_task_pvd.dart';
import 'package:testtask/provider/helper%20mixins/state_notifier.dart';
import 'dart:math' as math;

class AllTaskScreen extends StatelessWidget {
  const AllTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AllTaskPvd()),
      ],
      child: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final taskListPvd = context.watch<AllTaskPvd>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("All tasks"),
        actions: [
          IconButton(
            onPressed: () async {
              bool? hasAddedTask = await Navigator.of(context).push<bool?>(
                MaterialPageRoute(
                  builder: (_) => const AddTaskScreen(),
                ),
              );
              if (hasAddedTask == true) {
                taskListPvd.init();
              }
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: switch (taskListPvd.currentState) {
        States.loading || States.none => const _LoadingState(),
        States.empty => const _EmptyState(),
        States.success => const _SuccessState(),
        States.error => const _ErrorState(),
      },
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Something went wrong! "),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("You have not added tasks yet"),
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _SuccessState extends StatelessWidget {
  const _SuccessState();

  @override
  Widget build(BuildContext context) {
    final taskListPvd = context.watch<AllTaskPvd>();
    return CustomScrollView(
      slivers: [
        for (var tasks in taskListPvd.dataByTimings!.entries)
          if (tasks.value.isNotEmpty)
            SliverStickyHeader(
              header: TimingHeader(headerText: tasks.key),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final int itemIndex = index ~/ 2;
                    if (index.isEven) {
                      Task currentTask = tasks.value[itemIndex];
                      return TaskCard(task: currentTask);
                    }
                    return const Divider(
                      indent: 4,
                      endIndent: 4,
                      color: Color(0x0AFFFFFF),
                    );
                  },
                  childCount: math.max(0, tasks.value.length * 2 - 1),
                ),
              ),
            ),
      ],
    );
  }
}
