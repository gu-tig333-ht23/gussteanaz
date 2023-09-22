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
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Consumer<ToDoProvider>(
                builder: (context, todoProvider, child) {
                  final filteredList =
                      todoProvider.filterTasks(todoProvider.selectedFilterOption);

                  return ListView(
                    children: [
                      for (ToDo item in filteredList)
                        ToDoItem(
                          todo: item,
                          setDone: todoProvider.toggleTask,
                          deleteItem: todoProvider.removeTask,
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: const Icon(Icons.add),
        onPressed: () {
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
  final Function(ToDo) deleteItem;
  final Function(ToDo) setDone;
  final ToDo todo;

  const ToDoItem({
    Key? key,
    required this.todo,
    required this.setDone,
    required this.deleteItem,
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
        leading: Container(
          child: IconButton(
            padding: EdgeInsets.zero,
            color: Colors.black,
            iconSize: 21,
            icon: Icon(
                todo.isDone ? Icons.check_box_rounded : Icons.check_box_outline_blank_rounded),
            onPressed: () {
              setDone(todo);
            },
          ),
        ),
        title: Text(
          todo.todoText!,
          style: TextStyle(
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          child: IconButton(
            padding: EdgeInsets.zero,
            color: Colors.black,
            iconSize: 21,
            icon: Icon(Icons.block),
            onPressed: () {
              deleteItem(todo);
            },
          ),
        ),
      ),
    );
  }
}
