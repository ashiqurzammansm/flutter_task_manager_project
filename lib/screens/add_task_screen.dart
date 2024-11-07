import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime selectedStartDate = DateTime.now();
  TimeOfDay selectedStartTime = TimeOfDay.now();
  DateTime selectedCompletionDate = DateTime.now();
  TimeOfDay selectedCompletionTime = TimeOfDay.now();

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedStartDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedStartDate) {
      setState(() {
        selectedStartDate = picked;
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedStartTime,
    );
    if (picked != null && picked != selectedStartTime) {
      setState(() {
        selectedStartTime = picked;
      });
    }
  }

  Future<void> _selectCompletionDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedCompletionDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedCompletionDate) {
      setState(() {
        selectedCompletionDate = picked;
      });
    }
  }

  Future<void> _selectCompletionTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedCompletionTime,
    );
    if (picked != null && picked != selectedCompletionTime) {
      setState(() {
        selectedCompletionTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Task', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Task Title', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 8),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter task title',
              ),
            ),
            SizedBox(height: 16),
            Text('Description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 8),
            TextField(
              controller: descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter task description',
              ),
            ),
            SizedBox(height: 16),
            Text('Start Date and Time', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 8),
            Row(
              children: [
                TextButton(
                  onPressed: () => _selectStartDate(context),
                  child: Text('Pick Date: ${DateFormat.yMd().format(selectedStartDate)}', style: TextStyle(color: Colors.teal)),
                ),
                SizedBox(width: 16),
                TextButton(
                  onPressed: () => _selectStartTime(context),
                  child: Text('Pick Time: ${selectedStartTime.format(context)}', style: TextStyle(color: Colors.teal)),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text('Completion Date and Time', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 8),
            Row(
              children: [
                TextButton(
                  onPressed: () => _selectCompletionDate(context),
                  child: Text('Pick Date: ${DateFormat.yMd().format(selectedCompletionDate)}', style: TextStyle(color: Colors.teal)),
                ),
                SizedBox(width: 16),
                TextButton(
                  onPressed: () => _selectCompletionTime(context),
                  child: Text('Pick Time: ${selectedCompletionTime.format(context)}', style: TextStyle(color: Colors.teal)),
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (titleController.text.isEmpty || descriptionController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill out all fields')),
                    );
                    return;
                  }

                  final DateTime startDateTime = DateTime(
                    selectedStartDate.year,
                    selectedStartDate.month,
                    selectedStartDate.day,
                    selectedStartTime.hour,
                    selectedStartTime.minute,
                  );

                  final DateTime completionDateTime = DateTime(
                    selectedCompletionDate.year,
                    selectedCompletionDate.month,
                    selectedCompletionDate.day,
                    selectedCompletionTime.hour,
                    selectedCompletionTime.minute,
                  );

                  final newTask = Task(
                    title: titleController.text,
                    description: descriptionController.text,
                    startDateTime: startDateTime,
                    completionDateTime: completionDateTime,
                  );

                  Navigator.pop(context, newTask); // Return the new task
                },
                child: Text('Add Task', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
