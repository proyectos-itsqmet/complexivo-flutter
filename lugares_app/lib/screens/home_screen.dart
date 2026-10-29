import 'package:flutter/material.dart';
import 'package:lugares_app/screens/lugares_screen.dart';
import 'package:lugares_app/screens/mis_lugares_screen.dart';
import 'package:lugares_app/screens/perfil_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _indice = 0;

  final _titulos = ["Lugares", "Mis lugares", "Perfil"];

  final _pantallas = [LugaresScreen(), MisLugaresScreen(), PerfilScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titulos[_indice])),
      body: _pantallas[_indice],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indice,
        onDestinationSelected: (i) => setState(() => _indice = i),
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: "Inicio"),
          NavigationDestination(
            icon: Icon(Icons.bookmark),
            label: "Mis lugares",
          ),
          NavigationDestination(icon: Icon(Icons.person), label: "Perfil"),
        ],
      ),
    );
  }
}
