import 'package:flutter/material.dart';

class UsuarioPage extends StatelessWidget {
  const UsuarioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Usuário')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Tela do Usuário'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/configuracao');
              },
              child: Text('Ir para Configurações'),
            ),
          ],
        ),
      ),
    );
  }
}
