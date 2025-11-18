import 'package:flutter/material.dart';

class ScheduleEntry {
  final String produtoId;
  final DateTime hora;

  ScheduleEntry({required this.produtoId, required this.hora});
}

class ScheduleProvider extends ChangeNotifier {
  final List<ScheduleEntry> entries = [];

  void addEntry(ScheduleEntry e) {
    entries.add(e);
    notifyListeners();
  }

  void removeEntry(ScheduleEntry e) {
    entries.remove(e);
    notifyListeners();
  }
}
