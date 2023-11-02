import 'package:testtask/models/task.dart';
import 'package:testtask/utils/service_locator.dart';

class TaskRepo {
  final _taskBox = getIt<HiveUtil>().taskBox!;

  Future<int> addNewTask(Task newTask) async {
    return (await _taskBox.add(newTask));
  }

  Future<void> deleteTask(Task task) async {
    return (await _taskBox.delete(task.key));
  }

  Iterable<Task> getAllTask() {
    return _taskBox.values.toList();
  }
}
