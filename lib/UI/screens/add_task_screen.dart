import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtask/provider/add_task_pvd.dart';
import 'package:testtask/utils/util_function.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AddTaskPvd()),
      ],
      child: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final addTaskPvd = context.watch<AddTaskPvd>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add event'),
      ),
      body: Form(
        key: addTaskPvd.formKey,
        child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            TextFormField(
              controller: addTaskPvd.titleCtrl,
              validator: addTaskPvd.emptyValidation,
              decoration: const InputDecoration(
                hintText: 'Task title',
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: addTaskPvd.descCtrl,
              validator: addTaskPvd.emptyValidation,
              decoration: const InputDecoration(
                hintText: 'Task description',
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            const SizedBox(height: 16),
            const Text("Select date and time"),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Event date"),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () => showDatePickerDialog(context),
                        child: const Text("Select Date"),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Event time"),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () => showTimePickerDialog(context),
                        child: const Text("Select Time"),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(UtilFunctions.formatReadableDate(addTaskPvd.startTime)),
            const SizedBox(height: 16),
            Text(
              "Duration of task (in minutes): ${addTaskPvd.durationInMin.round()} min",
            ),
            const SizedBox(height: 10),
            Slider(
              value: addTaskPvd.durationInMin,
              onChanged: addTaskPvd.onDurationChanged,
              divisions: addTaskPvd.sliderDivision,
              min: addTaskPvd.minDuration,
              max: addTaskPvd.maxDuration,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => addTaskPvd.createTask(
                () => Navigator.of(context).pop(true),
              ),
              child: addTaskPvd.isLoading
                  ? const SizedBox.square(
                      dimension: 28,
                      child: CircularProgressIndicator(),
                    )
                  : const Text("Create event"),
            )
          ],
        ),
      ),
    );
  }

  void showDatePickerDialog(BuildContext context) async {
    final addTaskPvd = context.read<AddTaskPvd>();

    DateTime? time = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );

    if (time != null) {
      addTaskPvd.selectStartDate(time);
    }
  }

  void showTimePickerDialog(BuildContext context) async {
    final addTaskPvd = context.read<AddTaskPvd>();

    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      addTaskPvd.selectStartTime(time);
    }
  }
}
