import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/database/database.dart';
import 'package:todoapp/widgets/custom_alert_dialog.dart';
import 'package:todoapp/widgets/custom_textfield.dart';
import 'package:todoapp/widgets/custom_todo_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    if (myBox.get('todos') == null) {
      db.initialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  var myBox = Hive.box('myBox');
  TextEditingController controller = TextEditingController();
  Database db = Database();
  void addTodoItem(String item) {
    setState(() => db.todos.add([item, false]));
    db.updateData();
  }

  void removeTodoItem(int index) {
    setState(() => db.todos.removeAt(index));
    db.updateData();
  }

  void toggleTodoItem(int index) {
    setState(() => db.todos[index][1] = !db.todos[index][1]);
    db.updateData();
  }

  void showAddTodoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomAlertDialog(
        content: CustomTextfield(
          hintText: 'Enter a todo item here...',
          controller: controller,
        ),
        onPressed: () {
          String todoItem = controller.text;
          if (todoItem.isNotEmpty) {
            addTodoItem(todoItem);
            controller.clear();
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade300,
      appBar: AppBar(
        centerTitle: true,
        title: Text('T O D O'),
        backgroundColor: Colors.yellow,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddTodoDialog(),
        shape: CircleBorder(),
        backgroundColor: Colors.yellow,
        child: Icon(Icons.add),
      ),
      body: db.todos.isEmpty
          ? Center(
              child: Text(
                'No todos yet!\nAdd one by clicking the + button',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: db.todos.length,
              itemBuilder: (BuildContext context, int index) {
                return CustomTodoTile(
                  text: db.todos[index][0],
                  value: db.todos[index][1],
                  onChanged: (_) => toggleTodoItem(index),
                  onPressed: (_) => removeTodoItem(index),
                );
              },
            ),
    );
  }
}
