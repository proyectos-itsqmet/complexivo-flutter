import 'package:flutter/material.dart';
import 'package:viajes_app/models/pais.dart';
import 'package:viajes_app/screens/detalle_screen.dart';
import 'package:viajes_app/services/pais_service.dart';

class BuscarScreen extends StatefulWidget {
  const BuscarScreen({super.key});

  @override
  State<BuscarScreen> createState() => _BuscarScreenState();
}

class _BuscarScreenState extends State<BuscarScreen> {
  final _service = PaisService();
  final _texto = TextEditingController();
  Future<List<Pais>>? _busqueda;

  @override
  void dispose() {
    _texto.dispose();
    super.dispose();
  }

  Future<void> _buscar() async {
    final texto = _texto.text.trim();
    if (texto.isEmpty) return;
    setState(() {
      _busqueda = _service.buscar(texto);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsetsGeometry.all(16),
          child: TextField(
            controller: _texto,
            decoration: InputDecoration(
              labelText: "Nombre del pais",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              suffixIcon: IconButton(
                onPressed: _buscar,
                icon: Icon(Icons.search),
              ),
            ),
            onSubmitted: (_) => _buscar(),
          ),
        ),
        Expanded(
          child: _busqueda == null
              ? Center(child: Text('Escribe un pais y busca'))
              : FutureBuilder(
                  future: _busqueda,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error al buscar: ${snapshot.error}'),
                      );
                    }

                    final paises = snapshot.data!;

                    if (paises.isEmpty) {
                      return Center(child: Text("No hay paises"));
                    }

                    return ListView.builder(
                      itemCount: paises.length,
                      itemBuilder: (context, index) {
                        final pais = paises[index];

                        return ListTile(
                          leading: Image.network(
                            pais.bandera,
                            width: 48,
                            errorBuilder: (_, _, _) => Icon(Icons.flag),
                          ),
                          title: Text(pais.nombre),
                          subtitle: Text('Capital: ${pais.capital}'),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetalleScreen(pais: pais),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
}
