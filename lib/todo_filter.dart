import 'package:flutter/material.dart';
import 'todo_list.dart';

enum TaskFilter { all, done, undone }

class TodoListModel extends ChangeNotifier {
  final List<TodoTask> _tasks = [];
  TaskFilter _filter = TaskFilter.all;

  List<TodoTask> get tasks {
    switch (_filter) {
      case TaskFilter.all:
        return _tasks;
      case TaskFilter.done:
        return _tasks.where((task) => task.isDone).toList();
      case TaskFilter.undone:
        return _tasks.where((task) => !task.isDone).toList();
    }
  }

  set filter(TaskFilter filter) {
    _filter = filter;
    notifyListeners();
  }

  void addTask(String taskName) {
    _tasks.add(TodoTask(taskName));
    notifyListeners();
  }

  void toggleDone(TodoTask task) {
    task.isDone = !task.isDone;
    notifyListeners();
  }

  void removeTask(TodoTask task) {
    _tasks.remove(task);
    notifyListeners();
  }
}
