import 'package:flutter/material.dart';
import 'package:flutter_application/src/common_widgets/custom_text_fild.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // Cabeçalho azul
          Container(
            decoration: const BoxDecoration(color: Colors.blueAccent),
            padding: const EdgeInsets.all(11),
            child: Row(
              children: const [
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Presence +',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Histórico
          ListTile(
            leading: const Icon(Icons.history, color: Colors.black),
            title: const Text(
              'Histórico',
              style: TextStyle(color: Colors.black),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
            onTap: () {
              // TODO: navegar para histórico
            },
          ),
          const Divider(),

          // Excluir Conta
          ListTile(
            leading: const Icon(Icons.delete, color: Colors.black),
            title: const Text(
              'Excluir Conta',
              style: TextStyle(color: Colors.black),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
            onTap: () => _showDeleteAccountDialog(context),
          ),
          const Divider(),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog<bool>(
      context: context,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Form(
            key: formKey,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 12),
                      const Text(
                        'Excluir Conta',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 16),
                      const Text(
                        'Para confirmar, digite sua senha:',
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 12),

                      // campo de senha usando CustomTextFild
                      CustomTextFild(
                        controller: passwordController,
                        isSecret: true,
                        icon: Icons.lock,
                        label: 'Senha',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira a senha';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),
                      SizedBox(
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              // TODO: implementar exclusão de conta
                              Navigator.of(ctx).pop(true);
                            }
                          },
                          child: const Text('Excluir Conta'),
                        ),
                      ),
                    ],
                  ),
                ),

                // botão X de fechar
                Positioned(
                  top: 5,
                  right: 5,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(ctx).pop(false),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
