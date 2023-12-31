import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'todo_provider.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final inputController = TextEditingController();

  void addToDo(BuildContext context, String todo) {
    //Funktionen kör addTask från ToDoProvider, rensar textfältet och navigerar tillbaka till HomePage.
    if (todo.isNotEmpty) {
      final todoProvider = Provider.of<ToDoProvider>(context, listen: false);
      todoProvider.addTask(todo).then((_) {
        inputController.clear();
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //Definierar utseende på vyn AddItem.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('Lägg till ny'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: inputController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: 'Skriv något nytt att göra...',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => addToDo(context, inputController.text),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            child: Text(
              'Lägg Till',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
