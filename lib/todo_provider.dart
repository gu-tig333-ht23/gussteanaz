import 'package:flutter/material.dart';

class ToDoProvider extends ChangeNotifier {
  final List<ToDo> _homeList = ToDo.todoList();

  List<ToDo> get homeList => _homeList;

  void addTask(String task) {
    String newId = UniqueKey().toString();
    _homeList.add(
      ToDo(
        id: newId,
        todoText: task,
        isDone: false,
      ),
    );
    notifyListeners();
  }

  void toggleTask(ToDo todo) {
    todo.isDone = !todo.isDone;
    notifyListeners();
  }

  void removeTask(ToDo todo) {
    _homeList.removeWhere((item) => item.id == todo.id);
    notifyListeners();
  }

  List<ToDo> filterTasks(FilterOption option) {
    switch (option) {
      case FilterOption.alla:
        return _homeList;
      case FilterOption.gjorda:
        return _homeList.where((task) => task.isDone).toList();
      case FilterOption.ejGjorda:
        return _homeList.where((task) => !task.isDone).toList();
      default:
        return _homeList;
    }
  }
  
  FilterOption _selectedFilterOption = FilterOption.alla;

  FilterOption get selectedFilterOption => _selectedFilterOption;

  void updateFilter(FilterOption option) {
    _selectedFilterOption = option;
    notifyListeners();
  }
}

class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [];
  }
}

enum FilterOption {
  alla,
  gjorda,
  ejGjorda,
}
