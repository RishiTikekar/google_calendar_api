import 'package:hive_flutter/hive_flutter.dart';
import 'package:testtask/models/task.dart';

class HiveUtil {
  Future initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TaskAdapter());
    await openBox();
  }

  Box<Task>? taskBox;

  Future openBox() async {
    taskBox ??= await Hive.openBox(HiveConst.taskDB);
  }
}

class HiveConst {
  static const String taskDB = 'task';
}
