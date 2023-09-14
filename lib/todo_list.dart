import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './add_task.dart';
import './todo_filter.dart';

class TodoTask {
  String taskName;
  bool isDone;

  TodoTask(this.taskName) : isDone = false;
}

class TodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To-Do List"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 23.0),
            child: PopupMenuButton<TaskFilter>(
              onSelected: (filter) {
                Provider.of<TodoListModel>(context, listen: false).filter =
                    filter;
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<TaskFilter>>[
                const PopupMenuItem<TaskFilter>(
                  value: TaskFilter.all,
                  child: Text('All'),
                ),
                const PopupMenuItem<TaskFilter>(
                  value: TaskFilter.done,
                  child: Text('Done'),
                ),
                const PopupMenuItem<TaskFilter>(
                  value: TaskFilter.undone,
                  child: Text('Undone'),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Consumer<TodoListModel>(
        builder: (context, model, child) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return _item(context, model.tasks[index]);
            },
            itemCount: model.tasks.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTask(
                onTaskAdded: (taskName) {
                  Provider.of<TodoListModel>(context, listen: false)
                      .addTask(taskName);
                },
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _item(BuildContext context, TodoTask task) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: ListTile(
        leading: Checkbox(
          value: task.isDone,
          onChanged: (bool? value) {
            if (value != null) {
              Provider.of<TodoListModel>(context, listen: false)
                  .toggleDone(task);
            }
          },
        ),
        title: Text(
          task.taskName,
          style: TextStyle(
            decoration: task.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Provider.of<TodoListModel>(context, listen: false).removeTask(task);
          },
        ),
      ),
    );
  }
}
