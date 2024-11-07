import 'package:flutter/material.dart';
import 'add_task_screen.dart';
import '../widgets/task_list.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task Manager')),
      body: TaskList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddTaskScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
