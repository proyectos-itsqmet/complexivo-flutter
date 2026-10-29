import 'package:flutter/material.dart';
import 'package:lugares_app/screens/login_screen.dart';
import 'package:lugares_app/services/auth_service.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();

    final usuario = authService.usuario!;

    final nombre = usuario.userMetadata?['nombre'] ?? 'Sin nombre';

    return Padding(
      padding: EdgeInsetsGeometry.all(16),
      child: Column(
        children: [
          CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
          SizedBox(height: 16),
          Text('$nombre', style: Theme.of(context).textTheme.titleLarge),
          Text(usuario.email ?? ''),
          SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () async {
              await authService.logout();
              if (!context.mounted) return;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (_) => false,
              );
            },
            icon: Icon(Icons.logout),
            label: Text("Cerrar sesion"),
          ),
        ],
      ),
    );
  }
}
