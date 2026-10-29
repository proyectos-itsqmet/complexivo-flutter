import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:viajes_app/models/viaje.dart';
import 'package:viajes_app/services/viajes_service.dart';

class ViajeFormScreen extends StatefulWidget {
  final String pais;
  final Viaje? viaje;

  const ViajeFormScreen({super.key, required this.pais, this.viaje});

  @override
  State<ViajeFormScreen> createState() => _ViajeFormScreenState();
}

class _ViajeFormScreenState extends State<ViajeFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nota = TextEditingController();
  final _service = ViajesService();
  DateTime? _fecha;
  bool _guardando = false;

  bool get _editando => widget.viaje != null;

  @override
  void initState() {
    super.initState();
    _nota.text = widget.viaje?.nota ?? '';
    _fecha = widget.viaje?.fecha;
  }

  @override
  void dispose() {
    _nota.dispose();
    super.dispose();
  }

  Future<void> _elegirFecha() async {
    final elegida = await showDatePicker(
      context: context,
      initialDate: _fecha ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2035),
    );

    if (elegida != null) setState(() => _fecha = elegida);
  }

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate()) return;
    if (_fecha == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Elegí una fecha')));
      return;
    }

    setState(() => _guardando = true);
    try {
      if (_editando) {
        await _service.editar(widget.viaje!.id, _fecha!, _nota.text.trim());
      } else {
        await _service.crear(widget.pais, _fecha!, _nota.text.trim());
      }
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Viaje guardado')));
      Navigator.pop(context, true);
    } on PostgrestException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    } finally {
      if (mounted) setState(() => _guardando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_editando ? 'Editar viaje' : 'Planificar viaje'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'País: ${widget.pais}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.calendar_month),
              title: Text(
                _fecha == null
                    ? 'Elegir fecha'
                    : '${_fecha!.day}/${_fecha!.month}/${_fecha!.year}',
              ),
              onTap: _elegirFecha,
            ),
            TextFormField(
              controller: _nota,
              decoration: const InputDecoration(labelText: 'Nota'),
              maxLines: 3,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Escribí una nota' : null,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _guardando ? null : _guardar,
              child: Text(_guardando ? 'Guardando...' : 'Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
