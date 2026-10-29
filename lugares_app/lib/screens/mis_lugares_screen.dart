import 'package:flutter/material.dart';
import 'package:lugares_app/models/lugar.dart';
import 'package:lugares_app/screens/detalles_screen.dart';
import 'package:lugares_app/services/lugar_service.dart';

class MisLugaresScreen extends StatefulWidget {
  const MisLugaresScreen({super.key});

  @override
  State<MisLugaresScreen> createState() => _MisLugaresScreenState();
}

class _MisLugaresScreenState extends State<MisLugaresScreen> {
  final LugarService _lugarService = LugarService();
  late Future<List<Lugar>> _lugares;

  @override
  void initState() {
    super.initState();
    _lugares = _lugarService.misLugares();
  }

  void _recargar() {
    setState(() {
      _lugares = _lugarService.misLugares();
    });
  }

  Future<void> _quitar(Lugar lugar) async {
    await _lugarService.quitar(lugar.id);

    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("${lugar.nombre} quitado")));

    _recargar();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _lugares,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text("Aun no guardaste lugares"));
        }

        final lugares = snapshot.data!;

        if (lugares.isEmpty) {
          return Center(child: Text("Aun no guardaste lugares"));
        }

        return ListView.builder(
          itemCount: lugares.length,
          itemBuilder: (BuildContext context, int index) {
            final lugar = lugares[index];

            return ListTile(
              leading: Icon(Icons.bookmark),
              title: Text(lugar.nombre),
              subtitle: Text('${lugar.ciudad} - ${lugar.pais}'),
              trailing: IconButton(
                onPressed: () => _quitar(lugar),
                icon: Icon(Icons.delete),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetallesScreen(lugar: lugar),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
