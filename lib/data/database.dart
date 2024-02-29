import 'package:expense_tracker/models/expence.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Database {
  final _myBox = Hive.box("myBox");
  List<Expence> registeredExpences = [];

  void loadData() {
    registeredExpences = _myBox.get("RegisteredExpences");
  }

  void updateData() {
    _myBox.put("RegisteredExpences", registeredExpences);
  }
}
