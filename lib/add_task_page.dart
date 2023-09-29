import 'package:flutter/material.dart';

class AddTaskPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final Function(String) onTaskAdded;

  AddTaskPage({super.key, required this.onTaskAdded});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'Add Task',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  controller: _controller,
                  cursorColor: Colors.green,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'What do you need to do?',
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  onTaskAdded(_controller.text);
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
              ),
              child: Text(
                'Add',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.green[100],
    );
  }
}
