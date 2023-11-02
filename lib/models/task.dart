import 'package:hive/hive.dart';
part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final DateTime startTime;
  @HiveField(3)
  final int duration;
  @HiveField(4)
  final DateTime endTime;

  Task({
    required this.title,
    required this.description,
    required this.startTime,
    required this.duration,
  }) : endTime = startTime.add(Duration(minutes: duration));
}
