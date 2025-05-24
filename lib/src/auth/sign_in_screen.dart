import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/src/common_widgets/custom_text_fild.dart';
import 'package:flutter_application/src/components/admin_access_dialog.dart';
import 'package:flutter_application/src/components/forgot_password_dialog.dart';
import 'package:flutter_application/src/pages_routes/app_pages.dart';
import 'package:flutter_application/src/services/validators.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Column(
        children: [
          // ─────── LOGO + ANIMAÇÃO ───────
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text.rich(
                  TextSpan(
                    style: TextStyle(fontSize: 50),
                    children: [
                      TextSpan(
                        text: 'Presence',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: ' +', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: 30,
                  child: DefaultTextStyle(
                    style: const TextStyle(fontSize: 25, color: Colors.white),
                    child: AnimatedTextKit(
                      pause: Duration.zero,
                      repeatForever: true,
                      animatedTexts: [
                        FadeAnimatedText('Detecção de Movimento'),
                        FadeAnimatedText('App inteligente'),
                        FadeAnimatedText('Sensor de Presença'),
                        FadeAnimatedText('Mais segurança'),
                        FadeAnimatedText('Ultra Rápido'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ─────── FORMULÁRIO ───────
          Flexible(
            flex: 1,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 24,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(45),
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Email
                              CustomTextFild(
                                controller: emailController,
                                icon: Icons.email,
                                label: 'Email',
                                //validator: emailValidator,
                                textInputType: TextInputType.emailAddress,
                              ),

                              // Senha
                              CustomTextFild(
                                controller: passwordController,
                                icon: Icons.lock,
                                label: 'Senha',
                                isSecret: true,
                                //validator: passwordValidator,
                              ),

                              const SizedBox(height: 16),

                              // Botão “Acessar”
                              SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.blueAccent,
                                    side: const BorderSide(
                                      color: Colors.blueAccent,
                                      width: 2.3,
                                    ),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      Get.toNamed(PagesRoutes.BaseRoute);
                                    }
                                  },
                                  child: const Text(
                                    'Acessar',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),

                              // “Esqueceu a senha?”
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder:
                                          (_) => const ForgotPasswordDialog(),
                                    );
                                  },
                                  child: const Text(
                                    'Esqueceu a senha?',
                                    style: TextStyle(color: Colors.blueAccent),
                                  ),
                                ),
                              ),

                              // Divisor “ou”
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Divider(
                                        color: Colors.grey.withAlpha(90),
                                        thickness: 3,
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 15,
                                      ),
                                      child: Text('ou'),
                                    ),
                                    Expanded(
                                      child: Divider(
                                        color: Colors.grey.withAlpha(90),
                                        thickness: 3,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Botão “Criar conta”
                              SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueAccent,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                  ),
                                  onPressed: () {
                                    Get.toNamed(PagesRoutes.signUpRoute);
                                  },
                                  child: const Text(
                                    'Criar conta',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 10),

                              // Botão Admin
                              SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueAccent,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                  ),
                                  onPressed: () async {
                                    final result = await showDialog<bool>(
                                      context: context,
                                      builder: (_) => const AdminAccessDialog(),
                                    );
                                    if (result == true) {
                                      Get.toNamed(PagesRoutes.adminTabRoute);
                                    }
                                  },
                                  child: const Text(
                                    'Admin',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
