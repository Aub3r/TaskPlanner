import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodoList(),
    );
  }
}

class AddTask extends StatelessWidget {
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
              decoration: InputDecoration(
                labelText: 'What do you need to do?',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Add'),
            )
          ],
        ),
      ),
    );
  }
}

class TodoTask {
  String taskName;
  String description;

  TodoTask(this.taskName, this.description);
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<TodoTask> tasks = [
    TodoTask('Ladda telefon', 'Kom ihåg att ladda din telefon!'),
    TodoTask('Laga mat', 'Pannkakor med sylt och grädde.'),
    TodoTask('Kör 100 armhävningar', 'Annars blir du svag!'),
    TodoTask('Köp mjölk', 'Vi har inget kvar i kylskåpet!'),
    TodoTask('Träna löpning', 'Spring 5 km i parken.'),
    TodoTask('Städa rummet', 'Det börjar bli rörigt.'),
    TodoTask('Läs en bok', 'Avsluta kapitel 5 av den där boken du påbörjade.'),
    TodoTask('Skriv i dagboken', 'Skriv ner dina tankar från dagen.'),
    TodoTask('Vattna blommorna', 'De behöver mer vatten, särskilt orkidén.'),
    TodoTask(
        'Betala räkningar', 'El- och vattenräkningen förfaller nästa vecka.'),
    TodoTask('Boka tid hos tandläkaren', 'Du har skjutit upp det länge nog!'),
    TodoTask('Köp en födelsedagspresent', 'Mammas födelsedag är nästa vecka.'),
    TodoTask('Laga cykeln', 'Byt ut det punkterade hjulet.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("August's To-Do List")),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return _item(context, tasks[index]);
        },
        itemCount: tasks.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddTask()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _item(BuildContext context, TodoTask task) {
    return ListTile(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => OtherView(task.taskName)));
      },
      leading: Checkbox(
        value: false,
        onChanged: null,
      ),
      title: Text(task.taskName),
      subtitle: Text(task.description),
      trailing: Icon(Icons.close),
    );
  }
}

class OtherView extends StatelessWidget {
  final String taskName;
  OtherView(this.taskName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(taskName)),
      body: Center(child: Text('Description')),
    );
  }
}
