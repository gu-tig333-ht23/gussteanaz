import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ToDoProvider extends ChangeNotifier {
  final String apiKey = '8c752429-26ec-400a-8283-6d6b6c250a5c';
  final String apiUrl = 'https://todoapp-api.apps.k8s.gu.se';
  List<ToDo> _homeList = [];

  List<ToDo> get homeList => _homeList;

  ToDoProvider() {
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    final response = await http.get(Uri.parse('$apiUrl/todos?key=$apiKey'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      _homeList = data.map((task) => ToDo.fromJson(task)).toList();
      notifyListeners();
    }
  }

  Future<void> addTask(String task) async {
    final response = await http.post(
      Uri.parse('$apiUrl/todos?key=$apiKey'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'title': task, 'done': false}),
    );

    if (response.statusCode == 200) {
      await fetchTasks(); //Hämtar den uppdaterade listan från API:t.
    }
  }

  Future<void> toggleTask(ToDo todo) async {
    todo.isDone = !todo.isDone;
    final response = await http.put(
      Uri.parse('$apiUrl/todos/${todo.id}?key=$apiKey'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(todo.toJson()),
    );

    if (response.statusCode == 200) {
      await fetchTasks(); //Hämtar den uppdaterade listan från API:t.
    }
  }

  Future<void> removeTask(ToDo todo) async {
    final response = await http.delete(Uri.parse('$apiUrl/todos/${todo.id}?key=$apiKey'));
    if (response.statusCode == 200) {
      await fetchTasks(); //Hämtar den uppdaterade listan från API:t.
    }
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
  final String id;
  final String title;
  bool isDone;

  ToDo({
    required this.id,
    required this.title,
    this.isDone = false,
  });

  factory ToDo.fromJson(Map<String, dynamic> json) {
    return ToDo(
      id: json['id'],
      title: json['title'],
      isDone: json['done'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'done': isDone,
    };
  }
}

enum FilterOption {
  alla,
  gjorda,
  ejGjorda,
}