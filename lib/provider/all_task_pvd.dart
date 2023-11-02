import 'package:flutter/material.dart';
import 'package:testtask/models/task.dart';
import 'package:testtask/provider/helper%20mixins/state_notifier.dart';
import 'package:testtask/repo/task_repo.dart';

import 'helper mixins/map_timing_mixin.dart';

class AllTaskPvd with ChangeNotifier, MapTimingMixin, StateNotifier {
  final TaskRepo _repo = TaskRepo();

  @override
  DateTime date4mListItem(listItem) => (listItem as Task).startTime;

  AllTaskPvd() {
    init();
  }

  void init() {
    initTimingSections(DateTime.now());
    dataByTimings?.clear();
    try {
      currentState = States.loading;
      List<Task> allTasks = _repo.getAllTask().toList();
      mapTimings(allTasks);
      currentState = allTasks.isEmpty ? States.empty : States.success;
    } catch (err) {
      currentState = States.error;
    }
  }
}
