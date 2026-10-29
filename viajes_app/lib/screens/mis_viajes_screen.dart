import 'package:flutter/material.dart';
import 'package:viajes_app/models/viaje.dart';
import 'package:viajes_app/screens/viaje_form_screen.dart';
import 'package:viajes_app/services/viajes_service.dart';

class MisViajesScreen extends StatefulWidget {
  const MisViajesScreen({super.key});

  @override
  State<MisViajesScreen> createState() => _MisViajesScreenState();
}

class _MisViajesScreenState extends State<MisViajesScreen> {
  final _service = ViajesService();
  late Future<List<Viaje>> _viajes;

  @override
  void initState() {
    super.initState();
    _viajes = _service.listar();
  }

  void _recargar() {
    setState(() {
      _viajes = _service.listar();
    });
  }

  Future<void> _editar(Viaje viaje) async {
    final guardado = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => ViajeFormScreen(pais: viaje.pais, viaje: viaje),
      ),
    );
    if (guardado == true) _recargar();
  }

  Future<void> _eliminar(Viaje viaje) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar viaje'),
        content: Text('¿Eliminar el viaje a ${viaje.pais}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
    if (confirmar != true) return;

    await _service.eliminar(viaje.id);
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Viaje eliminado')));
    _recargar();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Viaje>>(
      future: _viajes,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final viajes = snapshot.data!;
        if (viajes.isEmpty) {
          return const Center(child: Text('Todavía no planificaste viajes'));
        }
        return ListView.builder(
          itemCount: viajes.length,
          itemBuilder: (context, i) {
            final v = viajes[i];
            return ListTile(
              leading: const Icon(Icons.flight),
              title: Text(v.pais),
              subtitle: Text(
                '${v.fecha.day}/${v.fecha.month}/${v.fecha.year} · ${v.nota ?? ''}',
              ),
              onTap: () => _editar(v),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: () => _eliminar(v),
              ),
            );
          },
        );
      },
    );
  }
}
