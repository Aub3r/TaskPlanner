import 'dart:convert';
import 'package:http/http.dart' as http;
import './todo_task.dart';

String? apiKey = 'a3dc35d8-d594-4bde-9a8a-a140e9bf8d4e';

Future<void> register() async {
  if (apiKey != null && apiKey!.isNotEmpty) {
    return;
  }

  final response =
      await http.get(Uri.parse('https://todoapp-api.apps.k8s.gu.se/register'));
  if (response.statusCode == 200) {
    apiKey = response.body;
  } else {
    throw Exception('Failed to register and get API key');
  }
}

Future<List<TodoTask>> fetchTasks() async {
  final response = await http
      .get(Uri.parse('https://todoapp-api.apps.k8s.gu.se/todos?key=$apiKey'));
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((task) => TodoTask.fromJson(task)).toList();
  } else {
    throw Exception('Failed to load tasks');
  }
}

Future<List<TodoTask>> addTaskToApi(TodoTask task) async {
  final response = await http.post(
    Uri.parse('https://todoapp-api.apps.k8s.gu.se/todos?key=$apiKey'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(task.toJson()),
  );
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((task) => TodoTask.fromJson(task)).toList();
  } else {
    throw Exception('Failed to add task');
  }
}

Future<void> updateTask(TodoTask task) async {
  final response = await http.put(
    Uri.parse(
        'https://todoapp-api.apps.k8s.gu.se/todos/${task.id}?key=$apiKey'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(task.toJson()),
  );
  if (response.statusCode != 200) {
    throw Exception('Failed to update task');
  }
}

Future<void> deleteTask(String id) async {
  final response = await http.delete(
    Uri.parse('https://todoapp-api.apps.k8s.gu.se/todos/$id?key=$apiKey'),
  );
  if (response.statusCode != 200) {
    throw Exception('Failed to delete task');
  }
}
