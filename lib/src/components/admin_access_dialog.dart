import 'package:flutter/material.dart';
import 'package:flutter_application/src/common_widgets/custom_text_fild.dart';

class AdminAccessDialog extends StatefulWidget {
  const AdminAccessDialog({super.key});

  @override
  State<AdminAccessDialog> createState() => _AdminAccessDialogState();
}

class _AdminAccessDialogState extends State<AdminAccessDialog> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Estilo compartilhado para os botões do diálogo
  final ButtonStyle adminButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.blueAccent,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    textStyle: const TextStyle(fontWeight: FontWeight.bold),
  );

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Acesso Administrativo',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Você tem certeza que deseja acessar como administrador?',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                CustomTextFild(
                  icon: Icons.email,
                  label: 'Email',
                  controller: emailController,
                  textInputType: TextInputType.emailAddress,
                  // validator: emailValidator,
                ),
                CustomTextFild(
                  icon: Icons.lock,
                  label: 'Senha',
                  controller: passwordController,
                  isSecret: true,
                  // validator: passwordValidator,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      style: adminButtonStyle,
                      child: const Text('Cancelar'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.of(context).pop(true);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Corrija os erros para continuar'),
                            ),
                          );
                        }
                      },
                      style: adminButtonStyle,
                      child: const Text('Confirmar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
