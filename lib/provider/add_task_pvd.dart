import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:testtask/models/task.dart';
import 'package:testtask/provider/helper%20mixins/state_notifier.dart';
import 'package:testtask/provider/helper%20mixins/validator_mixin.dart';
import 'package:testtask/repo/calendar_repo.dart';
import 'package:testtask/repo/task_repo.dart';

class AddTaskPvd with ChangeNotifier, Validators, StateNotifier {
  DateTime startTime = DateTime.now().add(const Duration(days: 1));
  double durationInMin = 5;
  double maxDuration = 60;
  double minDuration = 5;
  int sliderDivision = 12;

  TextEditingController titleCtrl = TextEditingController();
  TextEditingController descCtrl = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final CalenderRepo _calenderRepo = CalenderRepo();
  final TaskRepo _taskRepo = TaskRepo();

  void onDurationChanged(double duration) {
    durationInMin = duration.floor().toDouble();
    notifyListeners();
  }

  void selectStartDate(DateTime time) {
    startTime = startTime.copyWith(
      day: time.day,
      month: time.month,
      year: time.year,
    );

    notifyListeners();
  }

  void selectStartTime(TimeOfDay time) {
    startTime = startTime.copyWith(
      hour: time.hour,
      minute: time.minute,
    );

    notifyListeners();
  }

  Future<void> createTask(Function() onSuccess) async {
    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }

    try {
      currentState = States.loading;

      Task newTask = Task(
        title: titleCtrl.text.trim(),
        description: descCtrl.text.trim(),
        duration: durationInMin.floor(),
        startTime: startTime,
      );
      final authHeader = await _calenderRepo.googleSignIn();

      await _calenderRepo.createCalenderEvent(newTask, authHeader!);

      await _taskRepo.addNewTask(newTask);

      onSuccess.call();

      currentState = States.success;
    } catch (err) {
      currentState = States.error;
    }
  }

  @override
  void dispose() {
    titleCtrl.dispose();
    descCtrl.dispose();
    super.dispose();
  }
}
