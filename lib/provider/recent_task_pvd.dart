import 'package:flutter/foundation.dart';
import 'package:testtask/models/task.dart';
import 'package:testtask/provider/helper%20mixins/state_notifier.dart';
import 'package:testtask/repo/task_repo.dart';

class RecentTaskPvd with ChangeNotifier, StateNotifier {
  List<Task> recentTasks = [];
  final TaskRepo _repo = TaskRepo();

  RecentTaskPvd() {
    init();
  }

  void init() async {
    try {
      currentState = States.loading;

      List<Task> allTask = _repo.getAllTask().toList();

      (await upComingTask(allTask)).sort(
        (a, b) => a.startTime.compareTo(b.startTime),
      );

      recentTasks = allTask.take(5).toList();

      currentState =
          recentTasks.isEmpty ? States.empty : currentState = States.success;
    } catch (err) {
      currentState = States.error;
    }
  }

  Future<List<Task>> upComingTask(List<Task> allTasks) async {
    bool isTaskExpired;
    for (int i = 0; i < allTasks.length;) {
      isTaskExpired = allTasks[i].endTime.isBefore(DateTime.now());

      if (isTaskExpired) {
        await _repo.deleteTask(allTasks[i]);
        allTasks.removeAt(i);
      } else {
        i++;
      }
    }

    return allTasks;
  }
}
