import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/todo_provider.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/utilities/constants.dart';
import 'package:todo/view/widgets/custom_text.dart'; // Import the CustomText widget

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _textFieldController = TextEditingController();
  String newTask = '';
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _textFieldController.addListener(() {
      newTask = _textFieldController.text;
    });
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  void _submit() {
    Provider.of<TodoProvider>(context, listen: false).addTask(newTask);
    Navigator.pop(context);
    _textFieldController.clear();
    setState(() {
      searchQuery = '';
    });
  }

  List<TodoModel> filteredTasks() {
    return Provider.of<TodoProvider>(context)
        .allTasks
        .where((task) =>
        task.todoTitle.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  Future<void> _showAddTextDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add a new Task"),
          content: TextField(
            autofocus: true,
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: "Add New Task"),
            onSubmitted: (_) => _submit(),
          ),
          actions: [
            ElevatedButton(
              onPressed: _submit,
              child: const Text("Submit"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(120, 40),
              ),
            )
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          actionsAlignment: MainAxisAlignment.center,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ToDo App"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                searchQuery = '';
              });
            },
            icon: Icon(Icons.clear),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(
                hintText: "Search tasks",
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (query) {
                setState(() {
                  searchQuery = query;
                });
              },
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: filteredTasks().length,
        itemBuilder: (context, index) {
          final task = filteredTasks()[index];

          return ListTile(
            leading: Checkbox(
              value: task.completed,
              onChanged: (_) {
                Provider.of<TodoProvider>(context, listen: false)
                    .toggleTask(task);
              },
            ),
            title: Text(
              task.todoTitle,
              style: TextStyle(
                decoration: task.completed
                    ? TextDecoration.lineThrough
                    : null,
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                Provider.of<TodoProvider>(context, listen: false)
                    .deleteTask(task);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTextDialog();
        },
        child: const Icon(Icons.add),
        tooltip: "Add a todo",
      ),
    );
  }
}
