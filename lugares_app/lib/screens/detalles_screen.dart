import 'package:flutter/material.dart';
import 'package:lugares_app/models/clima.dart';
import 'package:lugares_app/models/lugar.dart';
import 'package:lugares_app/services/clima_service.dart';
import 'package:lugares_app/services/lugar_service.dart';

class DetallesScreen extends StatefulWidget {
  final Lugar lugar;
  const DetallesScreen({super.key, required this.lugar});

  @override
  State<DetallesScreen> createState() => _DetallesScreenState();
}

class _DetallesScreenState extends State<DetallesScreen> {
  final ClimaService _climaService = ClimaService();
  final LugarService _lugarService = LugarService();
  late Future<Clima> _clima;
  bool _guardado = false;
  bool _cargando = true;

  @override
  void initState() {
    super.initState();
    _clima = _climaService.obtener(widget.lugar.latitud, widget.lugar.longitud);
    _cargarGuardado();
  }

  Future<void> _cargarGuardado() async {
    final guardado = await _lugarService.estaGuardado(widget.lugar.id);
    if (!mounted) return;
    setState(() {
      _guardado = guardado;
      _cargando = false;
    });
  }

  Future<void> alternarGuardado() async {
    setState(() => _cargando = true);

    try {
      if (_guardado) {
        await _lugarService.quitar(widget.lugar.id);
      } else {
        await _lugarService.guardar(widget.lugar.id);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _cargando = false);
      _cargarGuardado();
    }
  }

  @override
  Widget build(BuildContext context) {
    final lugar = widget.lugar;

    return Scaffold(
      appBar: AppBar(title: Text(lugar.nombre)),
      body: ListView(
        children: [
          if (lugar.imagen != null)
            Image.network(
              lugar.imagen!,
              height: 220,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => SizedBox(
                height: 220,
                child: Icon(Icons.broken_image, size: 64),
              ),
            ),
          Padding(
            padding: EdgeInsetsGeometry.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${lugar.ciudad} - ${lugar.pais}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text('Precio: \$${lugar.precio.toStringAsFixed(2)}'),
                SizedBox(height: 16),
                FutureBuilder<Clima>(
                  future: _clima,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return LinearProgressIndicator();
                    }

                    if (snapshot.hasError) {
                      return Text("No se pudo obtener el clima");
                    }

                    final clima = snapshot.data!;

                    return Card(
                      child: ListTile(
                        leading: Icon(Icons.thermostat),
                        title: Text(
                          '${clima.temperatura}°C - ${clima.description}',
                        ),
                        subtitle: Text('Viento ${clima.viento}Km/h'),
                      ),
                    );
                  },
                ),
                SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: _cargando ? null : alternarGuardado,
                  icon: Icon(
                    _guardado ? Icons.bookmark_remove : Icons.bookmark_add,
                  ),
                  label: Text(
                    _guardado ? "Quitar de mis lugares" : "Guardar lugar",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
