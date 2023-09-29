class TodoTask {
  final String id;
  String taskName;
  bool isDone;

  TodoTask(this.taskName, {this.id = '', this.isDone = false});

  TodoTask.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        taskName = json['title'],
        isDone = json['done'];

  Map<String, dynamic> toJson() => {
        'title': taskName,
        'done': isDone,
      };
}
