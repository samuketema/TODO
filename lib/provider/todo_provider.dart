import 'package:todo2/models/todo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
final todoListProvider = StateNotifierProvider<TodoListNotifier,List<Todo>>((ref) {
  return TodoListNotifier();
});

class TodoListNotifier extends StateNotifier<List<Todo>> {
  TodoListNotifier(): super([]);
  
  void addTodo(String content){
    state = [...state ,
    Todo(id: state.isEmpty? 0 : state[state.length - 1].id + 1 , content: content, completed: false)
    ];
  }
  void completeTodo(int id){
      state = [
        for( final todo in state)
          if(todo.id == id)
            Todo(id: todo.id, content: todo.content, completed: true)
          else
          todo
      ];
  }
  void delete(int id){
    state = state.where((todo) => todo.id != id).toList(); 
  }
}   