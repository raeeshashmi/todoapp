import 'package:hive_flutter/hive_flutter.dart';

class Database {
  List todos = [];

  var myBox = Hive.box('mybox');

  void initialData() {
    todos = [
      ['Go gym', false],
      ['Drink Water', false],
    ];
  }

  void loadData() {
    todos = myBox.get('todos');
  }

  void updateData() {
    myBox.put('todos', todos);
  }
}
