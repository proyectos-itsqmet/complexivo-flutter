import 'package:flutter/material.dart';
import 'package:lugares_app/models/lugar.dart';
import 'package:lugares_app/screens/detalles_screen.dart';
import 'package:lugares_app/services/lugar_service.dart';

class LugaresScreen extends StatefulWidget {
  const LugaresScreen({super.key});

  @override
  State<LugaresScreen> createState() => _LugaresScreenState();
}

class _LugaresScreenState extends State<LugaresScreen> {
  final LugarService _lugarService = LugarService();
  late Future<List<Lugar>> _lugares;

  @override
  void initState() {
    super.initState();
    _lugares = _lugarService.listar();
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
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final lugares = snapshot.data!;

        if (lugares.isEmpty) {
          return Center(child: Text("No hay lugares"));
        }

        return ListView.builder(
          itemCount: lugares.length,
          itemBuilder: (context, index) {
            final lugar = lugares[index];

            return ListTile(
              leading: lugar.imagen == null
                  ? Icon(Icons.place)
                  : CircleAvatar(backgroundImage: NetworkImage(lugar.imagen!)),
              title: Text(lugar.nombre),
              subtitle: Text('${lugar.ciudad} - ${lugar.pais}'),
              trailing: Text('\$${lugar.precio.toStringAsFixed(2)}'),
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
