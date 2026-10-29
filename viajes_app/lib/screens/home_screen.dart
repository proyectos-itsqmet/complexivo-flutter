import 'package:flutter/material.dart';
import 'package:viajes_app/screens/buscar_screen.dart';
import 'package:viajes_app/screens/mis_viajes_screen.dart';
import 'package:viajes_app/screens/perfil_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _indice = 0;
  static const List<String> _titulos = ['Buscar pais', 'Mis viajes', 'Perfil'];
  static const List<Widget> _pantallas = [
    BuscarScreen(),
    MisViajesScreen(),
    PerfilScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titulos[_indice])),
      body: _pantallas[_indice],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indice,
        onDestinationSelected: (value) => setState(() => _indice = value),
        destinations: [
          NavigationDestination(icon: Icon(Icons.search), label: 'Buscar'),
          NavigationDestination(icon: Icon(Icons.luggage), label: 'Mis viajes'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}
