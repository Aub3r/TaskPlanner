import 'package:flutter/material.dart';
import './api.dart';
import './todo_task.dart';

enum TaskFilter { all, done, undone }

class TodoListModel extends ChangeNotifier {
  List<TodoTask> _tasks = [];
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

  Future<void> loadTasks() async {
    try {
      List<TodoTask> tasks = await fetchTasks();
      _tasks = tasks;
      notifyListeners();
    } catch (e) {
      print("Error loading tasks: $e");
    }
  }

  Future<void> addTask(String taskName) async {
    try {
      TodoTask newTask = TodoTask(taskName);
      List<TodoTask> updatedTasks = await addTaskToApi(newTask);
      _tasks = updatedTasks;
      notifyListeners();
    } catch (e) {
      print("Error adding task: $e");
    }
  }

  Future<void> toggleDone(TodoTask task) async {
    bool originalStatus = task.isDone;
    task.isDone = !task.isDone;
    try {
      await updateTask(task);
      notifyListeners();
    } catch (e) {
      print("Error toggling task: $e");
      task.isDone = originalStatus; // revert the change if API call fails
      notifyListeners();
    }
  }

  Future<void> removeTask(TodoTask task) async {
    try {
      await deleteTask(task.id);
      _tasks.remove(task);
      notifyListeners();
    } catch (e) {
      print("Error removing task: $e");
    }
  }
}
