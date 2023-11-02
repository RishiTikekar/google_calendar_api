import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtask/UI/widgets/task_card.dart';
import 'package:testtask/provider/helper%20mixins/state_notifier.dart';
import 'package:testtask/provider/recent_task_pvd.dart';

class RecentTaskScreen extends StatelessWidget {
  const RecentTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecentTaskPvd()),
      ],
      child: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final taskListPvd = context.watch<RecentTaskPvd>();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Recent Task'),
        ),
        body: switch (taskListPvd.currentState) {
          States.loading || States.none => const _LoadingState(),
          States.empty => const _EmptyState(),
          States.success => const _SuccessState(),
          States.error => const _ErrorState(),
        });
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
    final taskListPvd = context.watch<RecentTaskPvd>();
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      shrinkWrap: true,
      itemCount: taskListPvd.recentTasks.length,
      itemBuilder: (context, index) {
        return TaskCard(task: taskListPvd.recentTasks[index]);
      },
    );
  }
}
