import 'package:flutter/material.dart';
import 'package:todo_app_sqlite_freezed/add_task.dart';
import 'package:todo_app_sqlite_freezed/database.dart';
import 'package:todo_app_sqlite_freezed/models/todo_model.dart';
import 'package:todo_app_sqlite_freezed/update_task.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 44, 200, 52)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'TODO List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String task = "";
  Todo? selectedTodo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(children: [
        FutureBuilder<List<Todo>>(
          future: DatabaseHelper.instance.getAllTodos(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Erreur : ${snapshot.error}');
            }

            final todos = snapshot.data!;
            return Expanded(
                child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return ListTile(
                    title: Text(todo.task),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              DatabaseHelper.instance.delete(todo.id!);
                              setState(() {
                                todos.remove(todo);
                              });
                            },
                            icon: const Icon(Icons.delete)),
                        IconButton(
                            onPressed: () async {
                              selectedTodo = todo;
                              final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        UpdateTask(todo: selectedTodo!),
                                  ));
                              if (result != null) {
                                setState(() {
                                  final updateTodo = Todo(
                                      id: selectedTodo!.id,
                                      task: result,
                                      isCompleted: selectedTodo!.isCompleted);
                                  DatabaseHelper.instance.update(updateTodo);
                                });
                              }
                            },
                            icon: const Icon(Icons.edit))
                      ],
                    ));
              },
            ));
          },
        ),
        ElevatedButton(
            onPressed: (() async {
              final result = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddTask()));

              if (result != null) {
                setState(() {
                  final newTodo = Todo(task: result, isCompleted: 0);
                  DatabaseHelper.instance.insert(newTodo);
                });
              }
            }),
            child: const Text("Ajouter une tâche")),
      ])),
    );
  }
}
