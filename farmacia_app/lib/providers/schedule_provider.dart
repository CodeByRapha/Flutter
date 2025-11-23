import 'package:flutter/material.dart';
import '../models/agendamento.dart';

class ScheduleProvider extends ChangeNotifier {
  final List<ScheduleEntry> _entries = [];

  List<ScheduleEntry> get entries => List.unmodifiable(_entries);

  void addEntry(ScheduleEntry e) {
    _entries.add(e);
    notifyListeners();
  }

  void removeEntry(ScheduleEntry e) {
    _entries.remove(e);
    notifyListeners();
  }
}
