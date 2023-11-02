import 'package:flutter/material.dart';
import 'package:testtask/models/task.dart';
import 'package:testtask/styles/styles.dart';
import 'package:testtask/utils/util_function.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  const TaskCard({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          title: Text(
            task.title,
            style: TStyle.T_16_400,
          ),
          subtitle: Text(
            task.description,
            style: TStyle.T_14_400,
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Start time: ${UtilFunctions.formatReadableDate(task.startTime)}",
              ),
              const SizedBox(height: 8),
              Text(
                "End time: ${UtilFunctions.formatReadableDate(task.endTime)}",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
