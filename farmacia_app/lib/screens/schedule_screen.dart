import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/schedule_provider.dart';
import '../providers/products_provider.dart';
import '../models/produto.dart';
import '../models/agendamento.dart';
import '../widgets/bottom_navbar.dart';
import 'package:intl/intl.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  Produto? selected;
  DateTime? chosen;
  int navIndex = 2;

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsProvider>(context);
    final schedule = Provider.of<ScheduleProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Agendamentos")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<Produto>(
              value: selected,
              hint: const Text("Selecione um medicamento"),
              items: products.items.map((p) => DropdownMenuItem(value: p, child: Text(p.nome))).toList(),
              onChanged: (v) => setState(() => selected = v),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: Text(chosen == null ? "Nenhuma data escolhida" : DateFormat("dd/MM/yyyy HH:mm").format(chosen!))),
                TextButton(
                  onPressed: () async {
                    final date = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 365)));
                    if (date == null) return;
                    final time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                    if (time == null) return;
                    setState(() => chosen = DateTime(date.year, date.month, date.day, time.hour, time.minute));
                  },
                  child: const Text("Escolher data/hora"),
                )
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: (selected != null && chosen != null)
                  ? () {
                      schedule.addEntry(ScheduleEntry(produtoId: selected!.id, hora: chosen!));
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Agendamento salvo")));
                    }
                  : null,
              child: const Text("Salvar Agendamento"),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 10),
            const Text("Próximos agendamentos:", style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: schedule.entries.length,
                itemBuilder: (_, i) {
                  final e = schedule.entries[i];
                  final p = products.items.firstWhere((x) => x.id == e.produtoId);
                  return ListTile(
                    title: Text(p.nome),
                    subtitle: Text(DateFormat("dd/MM/yyyy HH:mm").format(e.hora)),
                    trailing: IconButton(icon: const Icon(Icons.delete), onPressed: () => schedule.removeEntry(e)),
                  );
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: navIndex,
        onTap: (i) {
          if (i == navIndex) return;
          if (i == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (i == 1) {
            Navigator.pushReplacementNamed(context, '/products');
          } else if (i == 3) {
            Navigator.pushReplacementNamed(context, '/admin');
          }
        },
      ),
    );
  }
}
