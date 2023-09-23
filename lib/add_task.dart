import 'package:flutter/material.dart';

class AddTask extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final Function(String) onTaskAdded;

  AddTask({required this.onTaskAdded});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'What do you need to do?',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  onTaskAdded(_controller.text);
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
            )
          ],
        ),
      ),
    );
  }
}
