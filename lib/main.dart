import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'tela_detalhes.dart';
import 'tela_concluidas.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do App',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  List<String> _tasks = [];
  List<String> _completedTasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  _loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _tasks = prefs.getStringList('tasks') ?? [];
      _completedTasks = prefs.getStringList('completedTasks') ?? [];
    });
  }

  // Adicionar tarefa
  _addTask(String task) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _tasks.add(task);
    });
    prefs.setStringList('tasks', _tasks);
  }

  // Marcar tarefa como concluída
  _markAsCompleted(String task) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _tasks.remove(task);
      _completedTasks.add(task);
    });
    prefs.setStringList('tasks', _tasks);
    prefs.setStringList('completedTasks', _completedTasks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("To Do App")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              String? task = await showDialog<String>(
                context: context,
                builder: (context) {
                  TextEditingController controller = TextEditingController();
                  return AlertDialog(
                    title: Text('Adicionar Tarefa'),
                    content: TextField(
                      controller: controller,
                      decoration: InputDecoration(hintText: 'Nome da tarefa'),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, controller.text);
                        },
                        child: Text('Adicionar'),
                      ),
                    ],
                  );
                },
              );
              if (task != null && task.isNotEmpty) {
                _addTask(task);
              }
            },
            child: Text('Adicionar Tarefa'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_tasks[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.check_circle_outline),
                    onPressed: () {
                      _markAsCompleted(_tasks[index]);
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TelaDetalhes(
                          task: _tasks[index],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaConcluidas(
                    completedTasks: _completedTasks,
                  ),
                ),
              );
            },
            child: Text('Ver Tarefas Concluídas'),
          ),
        ],
      ),
    );
  }
}
