import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/src/common_widgets/custom_text_fild.dart';
import 'package:flutter_application/src/auth/sign_up_screen.dart';
import 'package:flutter_application/src/base/base_screen.dart';
import 'package:flutter_application/src/pages_routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Expanded(
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
                          TextSpan(
                            text: ' +',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      child: DefaultTextStyle(
                        style: const TextStyle(fontSize: 25),
                        child: AnimatedTextKit(
                          pause: Duration.zero,
                          repeatForever: true,
                          animatedTexts: [
                            FadeAnimatedText('Detecção de Movimento'),
                            FadeAnimatedText('App inteligente'),
                            FadeAnimatedText('Sensor de Presença '),
                            FadeAnimatedText('Mais segurança'),
                            FadeAnimatedText('Ultra Rapido'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 40,
                ),

                decoration: const BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      
                      CustomTextFild(
                        controller: emailController,
                        icon: Icons.email,
                        label: 'Email',
                        validator: (email) {
                          if (email == null || email.isEmpty) {
                            return 'Digite seu email!';
                          }

                          if (!email.isEmail) return 'Digite um email valido';

                          return null;
                        },
                      ),
                     
                      CustomTextFild(
                        controller: passwordController,
                        icon: Icons.lock,
                        label: 'Senha',
                        isSecret: true,
                        validator: (password) {
                          if (password == null || password.isEmpty) {
                            return 'Digite sua Senha!';
                          }

                          if (password.length < 7) {
                            return 'Digite uma senha com pelo menos 7 caracteres.';
                          }

                          return null;
                        },
                      ),

                      
                      SizedBox(
                        height: 50,

                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),

                          
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              String email = emailController.text;
                              String password = passwordController.text;

                              print('Email: $email - Senha : $password');
                            } else {
                              print('Campos não validos!');
                            }
                             Get.toNamed(PagesRoutes.BaseRoute);
                          },

                          child: const Text(
                            'Acessar',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),

                     
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Esqueceu a senha?',
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                        ),
                      ),

                      
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
                              padding: EdgeInsets.symmetric(horizontal: 15),
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

                      
                      SizedBox(
                        height: 50,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            side: BorderSide(
                              width: 2.3,
                              color: Colors.blueAccent,
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
