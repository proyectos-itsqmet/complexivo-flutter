import 'package:flutter/material.dart';
import 'package:viajes_app/screens/login_screen.dart';
import 'package:viajes_app/services/auth_service.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();
    final usuario = auth.usuario;
    final nombre =
        (usuario?.userMetadata?['nombre'] as String?) ?? 'Sin nombre';

    return Padding(
      padding: EdgeInsetsGeometry.all(16),
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
          SizedBox(height: 16),
          Text(
            nombre,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(usuario?.email ?? '', textAlign: TextAlign.center),
          SizedBox(height: 24),
          FilledButton(
            onPressed: () async {
              await auth.logout();
              if (!context.mounted) return;

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false,
              );
            },
            child: Text('Cerrar sesión'),
          ),
        ],
      ),
    );
  }
}
