import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/task_database.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
      future: TaskDatabase.instance.readAllTasks(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final tasks = snapshot.data!;
        return ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return ListTile(
              title: Text(task.title),
              subtitle: Text(task.description),
              trailing: IconButton(
                icon: Icon(task.isCompleted ? Icons.check_circle : Icons.circle),
                onPressed: () {
                  Task updatedTask = Task(
                    id: task.id,
                    title: task.title,
                    description: task.description,
                    isCompleted: !task.isCompleted,
                  );
                  TaskDatabase.instance.updateTask(updatedTask);
                },
              ),
            );
          },
        );
      },
    );
  }
}
