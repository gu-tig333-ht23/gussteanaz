import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'todo_provider.dart';
import 'additem.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key, required this.title});
  final FilterOption selectedFilterOption = FilterOption.alla;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(title),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              //Öppnar en dialogruta med de olika filteralternativen, valt filteralternativ uppdaterar selectedFilterOption samt bockar i vald ruta.
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    scrollable: true,
                    title: Text('Filter'),
                    content: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Provider.of<ToDoProvider>(context, listen: false)
                                      .updateFilter(FilterOption.alla);
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Provider.of<ToDoProvider>(context).selectedFilterOption ==
                                          FilterOption.alla
                                      ? Icons.check_box_rounded
                                      : Icons.check_box_outline_blank_rounded,
                                ),
                              ),
                              Text('Alla'),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Provider.of<ToDoProvider>(context, listen: false)
                                      .updateFilter(FilterOption.gjorda);
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Provider.of<ToDoProvider>(context).selectedFilterOption ==
                                          FilterOption.gjorda
                                      ? Icons.check_box_rounded
                                      : Icons.check_box_outline_blank_rounded,
                                ),
                              ),
                              Text('Gjorda'),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Provider.of<ToDoProvider>(context, listen: false)
                                      .updateFilter(FilterOption.ejGjorda);
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Provider.of<ToDoProvider>(context).selectedFilterOption ==
                                          FilterOption.ejGjorda
                                      ? Icons.check_box_rounded
                                      : Icons.check_box_outline_blank_rounded,
                                ),
                              ),
                              Text('Ej gjorda'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            color: Colors.black,
            icon: Icon(Icons.checklist_rounded),
          ),
        ],
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Consumer<ToDoProvider>(
                builder: (context, todoProvider, child) {
                  final filteredList =
                      todoProvider.filterTasks(todoProvider.selectedFilterOption);
                    //filteredList bestämmer vilka föremål i listan som skall visas på HomePage baserat på selectedFilterOption.
                  return ListView(
                    //Bygger en ListView bestående av ListTiles från klassen ToDoItem baserat på föremålen i filteredList.
                    children: [
                      for (ToDo item in filteredList)
                        ToDoItem(
                          todo: item,
                          toggleTask: todoProvider.toggleTask,
                          removeTask: todoProvider.removeTask,
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(side: BorderSide(width: 3,color: Theme.of(context).colorScheme.background),borderRadius: BorderRadius.circular(20)),
        child: const Icon(Icons.add),
        onPressed: () {
          //Knappen navigerar till vyn "AddItem".
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddItem()),
          );
        },
      ),
    );
  }
}

class ToDoItem extends StatelessWidget {  
  //Klassen ToDoItem definierar hur ListTiles som visas på HomePage ska se ut.
  final Function(ToDo) removeTask;
  final Function(ToDo) toggleTask;
  final ToDo todo;

  const ToDoItem({
    Key? key,
    required this.todo,
    required this.toggleTask,
    required this.removeTask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
            padding: EdgeInsets.zero,
            color: Colors.black,
            iconSize: 21,
            icon: Icon(
                //Om föremålet har done:true så är ikonen en ibockad ruta, annars är det en tom ruta.
                todo.isDone ? Icons.check_box_rounded : Icons.check_box_outline_blank_rounded),
            onPressed: () {
              toggleTask(todo);
            },
          ),
        
        title: Text(
          todo.title,
          style: TextStyle(
            ////Om föremålet har done:true så är texten genomstruken, annars inte.
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: IconButton(
            padding: EdgeInsets.zero,
            color: Colors.black,
            iconSize: 21,
            icon: Icon(Icons.block),
            onPressed: () {
              removeTask(todo);
            },
          ),
        
      ),
    );
  }
}
