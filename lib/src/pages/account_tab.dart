import 'package:flutter/material.dart';

class AccountTab extends StatelessWidget {
  const AccountTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Perfil',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const ListTile(
          leading: Icon(Icons.person),
          title: Text('Nome do Usuário'),
          subtitle: Text('usuario@email.com'),
        ),
        const Divider(),
        const Text(
          'Configurações',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SwitchListTile(
          title: const Text('Notificações'),
          value: true,
          onChanged: (value) {
            // lógica do switch
          },
        ),
        ListTile(
          leading: const Icon(Icons.security),
          title: const Text('Privacidade'),
          onTap: () {
            // ação de navegação
          },
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Sair'),
          onTap: () {
            // lógica para logout
          },
        ),
      ],
    );
  }
}
