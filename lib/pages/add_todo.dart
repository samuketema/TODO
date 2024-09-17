import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo2/provider/todo_provider.dart';

class AddTodo extends ConsumerWidget {
  const AddTodo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController todoController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  controller: todoController,
                  decoration: InputDecoration(border: OutlineInputBorder())),
            ),
            TextButton(onPressed: () {
              ref.read(todoListProvider.notifier).addTodo(todoController.text);
              Navigator.pop(context);
            }, child: Text('Add Todo'))
          ],
        ),
      ),
    );
  }
}
