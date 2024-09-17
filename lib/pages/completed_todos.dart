import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo2/models/todo.dart';
import 'package:todo2/pages/add_todo.dart';
import 'package:todo2/provider/todo_provider.dart';

class CompletedTodos extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todos = ref.watch(todoListProvider);
    List<Todo> activeTodos =
        todos.where((todo) => todo.completed == false).toList();
    List<Todo> completedTodos =
        todos.where((todo) => todo.completed == true).toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Todo App"),
      ),
      body: ListView.builder(
        itemCount: activeTodos.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == activeTodos.length) {
            if (completedTodos.isEmpty) {
              return Container();
            } else {
              return Center(
                child: TextButton(
                  child: Text('Completed Todos'),
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CompletedTodos())),
                ),
              );
            }
          }
          else {
          return Slidable(
            startActionPane: ActionPane(motion: ScrollMotion(), children: [
              SlidableAction(
                onPressed: (context) =>
                    ref.watch(todoListProvider.notifier).delete(index),
                icon: Icons.delete,
                backgroundColor: Colors.red,
                borderRadius: BorderRadius.circular(15),
              )
            ]),
            endActionPane: ActionPane(motion: ScrollMotion(), children: [
              SlidableAction(
                onPressed: (context) =>
                    ref.watch(todoListProvider.notifier).completeTodo(index),
                icon: Icons.check_box,
                backgroundColor: Colors.green,
                borderRadius: BorderRadius.circular(15),
              )
            ]),
            child: ListTile(
              title: Text(activeTodos[index].content),
            ),
          );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddTodo()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
