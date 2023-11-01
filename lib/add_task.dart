import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => AddTaskState();

}

final TextEditingController _todoController = TextEditingController();


class AddTaskState extends State<AddTask> {

  String task = "";

  @override
  Widget build (BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text( "Ajouter une tâche"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

      ),
      body: Center(
        child: Column(
          children: [
                    TextField(
          controller: _todoController,
          decoration: const InputDecoration(
            labelText: "Ajouter une tâche",
          ),
          onChanged: (value) {
            task = value;
          },
        ),
        ElevatedButton(
          onPressed: () => {
            if (task == "") {

            } else 
            Navigator.pop(context,task)
          },
          child: const Text("Ajouter"),)
          ],
        )
      ),
    );
  }
}