import 'package:flutter/material.dart';
import 'package:viajes_app/models/pais.dart';
import 'package:viajes_app/screens/viaje_form_screen.dart';

class DetalleScreen extends StatelessWidget {
  final Pais pais;
  const DetalleScreen({super.key, required this.pais});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(pais.nombre)),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Image.network(
            pais.bandera,
            height: 180,
            errorBuilder: (_, _, _) => Icon(Icons.flag, size: 120),
          ),
          SizedBox(height: 16),
          Text(
            pais.nombreOficial,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 8),
          Text(
            'Capital: ${pais.capital}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            'Población: ${pais.poblacion} habitantes',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViajeFormScreen(pais: pais.nombre),
              ),
            ),
            label: Text('Planificar viaje'),
            icon: Icon(Icons.flight_takeoff),
          ),
        ],
      ),
    );
  }
}
