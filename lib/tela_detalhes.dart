import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaDetalhes extends StatefulWidget {
  final String task;

  TelaDetalhes({required this.task});

  @override
  _TelaDetalhesState createState() => _TelaDetalhesState();
}

class _TelaDetalhesState extends State<TelaDetalhes> {
  bool _isCompleted = false; 

  @override
  void initState() {
    super.initState();
    _loadCompletionStatus();
  }

  // Carregar o status de conclusão da tarefa
  _loadCompletionStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isCompleted = prefs.getBool(widget.task) ?? false;
    });
  }

  // Atualiza o status da tarefa no SharedPreferences
  _toggleCompletion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isCompleted = !_isCompleted;
    });
    // Salva o novo status no SharedPreferences
    prefs.setBool(widget.task, _isCompleted);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes da Tarefa"),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Exibe o título da tarefa
            Text(
              widget.task,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                decoration: _isCompleted ? TextDecoration.lineThrough : null,  // Risca a tarefa se concluída
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Esta é uma tarefa.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleCompletion,
              child: Text(_isCompleted ? "Marcar como Pendente" : "Marcar como Concluída"),
              style: ElevatedButton.styleFrom(
                backgroundColor: _isCompleted ? Colors.grey : Colors.green,  // Alterar cor se concluída
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                textStyle: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
