import 'package:flutter/material.dart';

import 'models/todo_model.dart';

class UpdateTask extends StatefulWidget {
  final Todo todo;
  const UpdateTask({required this.todo, super.key});

  @override
  State<UpdateTask> createState() => UpdateTaskState();
}

final TextEditingController _todoController = TextEditingController();

class UpdateTaskState extends State<UpdateTask> {

  String task = "";

  @override
  void initState() {
    super.initState();
    task = widget.todo.task;
  }
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Modifier une tâche"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: _todoController..text = task,
              decoration: const InputDecoration(
                labelText: "Modifier une tâche"
              ),
              onChanged: (value) {
                task = value;
              },
            ),
            ElevatedButton(
                onPressed: () => {
                  if (task == "") {

                  } else {
                    Navigator.pop(context, task)
                  }
                },
                child: const Text("Modifier"))
          ],
        ),
      ),
    );
  }
}