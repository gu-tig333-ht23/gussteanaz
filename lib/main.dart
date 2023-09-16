import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 255, 200, 98)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Att Göra'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        
        backgroundColor: Theme.of(context).colorScheme.primary,
        
        title: Text(widget.title), 

        actions: <Widget>[IconButton(onPressed: (){}, color: Colors.black, icon: Icon(Icons.checklist_rounded,))],

        
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ToDoItem(), //Kör "ToDoItem" flera gånger för att se hur emulatorn ser ut med fler rutor.
            ToDoItem(),
            ToDoItem(),
            ToDoItem(),
            ToDoItem(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add),
        onPressed: () {
        },
      ),
    );
  }
}


class ToDoItem extends StatelessWidget {
    const ToDoItem({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Container(
        margin: const EdgeInsets.all(10),
        child: ListTile(
          onTap: () {},
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          tileColor: Theme.of(context).colorScheme.inversePrimary,
          leading: Container(child: IconButton(padding: EdgeInsets.zero,
           color: Colors.black,
            iconSize: 21,
             icon: Icon(Icons.check_box_rounded),
              onPressed: () {
            
          },),),
          title: Text('Boka Tvättid'),
          trailing: Container(child: IconButton(padding: EdgeInsets.zero,
           color: Colors.black,
            iconSize: 21,
             icon: Icon(Icons.block),
              onPressed: () {
            
          },),),
        ),
      );
    }
}