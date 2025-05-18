import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/src/common_widgets/custom_text_fild.dart';
import 'package:flutter_application/src/config/app_data.dart' as appData;

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do Usuario'),

        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.logout))],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        children: [
          //email
          CustomTextFild(
            readOnly: true,
            initialvalue: appData.user.email,
            icon: Icons.email,
            label: 'Email',
          ),
          //nome
          CustomTextFild(
            readOnly: true,
            initialvalue: appData.user.name,
            icon: Icons.person,
            label: 'Nome',
          ),
          //celular
          CustomTextFild(
            readOnly: true,
            initialvalue: appData.user.phone,
            icon: Icons.phone,
            label: 'Celular',
          ),
          //cpf
          CustomTextFild(
            readOnly: false,
            initialvalue: appData.user.cpf,
            icon: Icons.file_copy,
            label: 'CPF',
            isSecret: true,
          ),

          //botao para atualizar a senha
          SizedBox(
            height: 50,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.blueAccent),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                updatePassword();
              },
              child: const Text('Atualizar senha'),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> updatePassword() {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //titulo
                    const Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: const Text(
                        'Atualizaçâo de Senha',

                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // senha atual
                    const CustomTextFild(
                      isSecret: true,
                      icon: Icons.lock,
                      label: 'Senha Atual',
                    ),
                    // nova senha
                    const CustomTextFild(
                      isSecret: true,
                      icon: Icons.lock_outline,
                      label: 'Nova Senha',
                    ),
                    // confirmacao nova senha
                    const CustomTextFild(
                      isSecret: true,
                      icon: Icons.lock_outline,
                      label: 'Confirmar nova senha',
                    ),

                    // botao de confirmacao
                    SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text('Atualizar'),
                      ),
                    ),
                  ],
                ),
              ),

              Positioned(
                top: 5,
                right: 5,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
