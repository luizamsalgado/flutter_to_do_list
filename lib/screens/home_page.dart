import 'package:flutter/material.dart';

// Import your model and widgets with correct relative paths
import '../models/task.dart'; // <-- for Task class
import '../widgets/add_task_dialog.dart'; // <-- for AddTaskDialog widget
import '../widgets/task_tile.dart'; // <-- for TaskTile widget

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  final List<Task> _todos = [];

  void _addNewItem(String text) {
    setState(() {
      _todos.add(Task(title: text));
    });
  }

  void _showAddItemDialog() {
    showDialog(
      context: context,
      builder: (context) => AddTaskDialog(onAdd: _addNewItem),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "To do list",
                style: TextStyle(
                  color: Colors.pink,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _todos.length,
                  itemBuilder: (context, index) => TaskTile(
                    text: _todos[index],
                    onToggle: () {
                      setState(() {
                        _todos[index].isDone = !_todos[index].isDone;
                      });
                    },
                    onDelete: () {
                      setState(() {
                        _todos.removeAt(index);
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddItemDialog,
        backgroundColor: Colors.pink,
        child: const Icon(Icons.add),
      ),
    );
  }
}
