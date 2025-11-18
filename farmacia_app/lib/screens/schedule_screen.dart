import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/schedule_provider.dart';
import '../providers/products_provider.dart';
import 'package:intl/intl.dart';
import '../models/produto.dart';


class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});
  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  Produto? selected;
  DateTime? chosen;

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsProvider>(context);
    final schedule = Provider.of<ScheduleProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Agendamentos')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          DropdownButtonFormField<Produto>(
            value: selected,
            hint: const Text('Selecione um medicamento'),
            items: products.items.map((p) => DropdownMenuItem(value: p, child: Text(p.nome))).toList(),
            onChanged: (v) => setState(() => selected = v),
          ),
          const SizedBox(height: 8),
          Row(children: [
            Expanded(
              child: Text(chosen == null ? 'Nenhuma hora escolhida' : DateFormat('dd/MM/yyyy HH:mm').format(chosen!)),
            ),
            TextButton(
              onPressed: () async {
                final d = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now().subtract(const Duration(days: 0)), lastDate: DateTime.now().add(const Duration(days: 365)));
                if (d == null) return;
                final t = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                if (t == null) return;
                final full = DateTime(d.year, d.month, d.day, t.hour, t.minute);
                setState(() => chosen = full);
              },
              child: const Text('Escolher data/hora'),
            )
          ]),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: (selected != null && chosen != null) ? () {
              Provider.of<ScheduleProvider>(context, listen: false).addEntry(ScheduleEntry(produtoId: selected!.id, hora: chosen!));
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Agendamento salvo')));
            } : null,
            child: const Text('Salvar agendamento'),
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 10),
          const Text('Próximos agendamentos:', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: ListView.builder(itemCount: schedule.entries.length, itemBuilder: (ctx, i) {
            final e = schedule.entries[i];
            final p = products.items.firstWhere((x) => x.id == e.produtoId, orElse: () => products.items.first);
            return ListTile(
              title: Text(p.nome),
              subtitle: Text(DateFormat('dd/MM/yyyy HH:mm').format(e.hora)),
              trailing: IconButton(icon: const Icon(Icons.delete), onPressed: () => Provider.of<ScheduleProvider>(context, listen: false).removeEntry(e)),
            );
          }))
        ]),
      ),
    );
  }
}
