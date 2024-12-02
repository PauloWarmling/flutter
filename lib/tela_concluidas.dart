import 'package:flutter/material.dart';

class TelaConcluidas extends StatelessWidget {
  final List<String> completedTasks;

  TelaConcluidas({required this.completedTasks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tarefas Concluídas"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: completedTasks.isEmpty
            ? Center(
                child: Text(
                  "Nenhuma tarefa concluída ainda.",
                  style: TextStyle(fontSize: 18.0),
                ),
              )
            : ListView.builder(
                itemCount: completedTasks.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4.0,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16.0),
                      title: Text(
                        completedTasks[index],
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
