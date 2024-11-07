// lib/screens/add_task_screen.dart
import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/task_database.dart';

class AddTaskScreen extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final newTask = Task(
                  title: titleController.text,
                  description: descriptionController.text,
                );
                TaskDatabase.instance.createTask(newTask);
                Navigator.pop(context);
              },
              child: Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}
