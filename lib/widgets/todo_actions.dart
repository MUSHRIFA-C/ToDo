import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/todo_provider.dart';

class TodoAction extends StatelessWidget {
  const TodoAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final task = Provider.of<TodoProvider>(context);

    return ListView.builder(
      itemCount: task.allTasks.length,
      itemBuilder: ((context, index) {
        final todo = task.allTasks[index];
        return ListTile(
          leading: Checkbox(
            value: todo.completed,
            onChanged: ((_) => task.toggleTask(todo)),
          ),
          title: Text(
            todo.todoTitle,
            style: TextStyle(
              decoration: todo.completed
                  ? TextDecoration.lineThrough
                  : null,
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              task.deleteTask(todo);
            },
            icon: const Icon(Icons.delete),
          ),
        );
      }),
    );
  }
}
