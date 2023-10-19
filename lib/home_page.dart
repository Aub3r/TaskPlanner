import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_task_page.dart';
import './todo_filter.dart';
import './todo_task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    Provider.of<TodoListModel>(context, listen: false).loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "TaskHandler",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
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
      backgroundColor: Colors.green[100],
      body: Consumer<TodoListModel>(
        builder: (context, model, child) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return _item(context, model.tasks[index]);
              },
              itemCount: model.tasks.length,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final taskName = await Navigator.push<String>(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskPage(),
            ),
          );
          if (taskName != null) {
            Provider.of<TodoListModel>(context, listen: false)
                .addTask(taskName);
          }
        },
        label: const Text('Add Task'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget _item(BuildContext context, TodoTask task) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: ListTile(
        leading: Checkbox(
          value: task.isDone,
          activeColor: Colors.green,
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
