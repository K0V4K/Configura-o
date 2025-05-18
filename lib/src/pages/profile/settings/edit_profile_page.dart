import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String _nome = 'Usuário';
  String _email = 'usuario@exemplo.com';
  bool _notificacoes = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Perfil')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _nome,
                decoration: const InputDecoration(labelText: 'Nome'),
                onChanged: (value) => _nome = value,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _email,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) => _email = value,
              ),
              const SizedBox(height: 24),
              SwitchListTile(
                title: const Text('Receber notificações'),
                value: _notificacoes,
                onChanged: (value) {
                  setState(() => _notificacoes = value);
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Perfil atualizado com sucesso!'),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.save),
                label: const Text('Salvar Alterações'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
