import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/nerdland_button.dart';
import '../widgets/nerdland_input.dart';
import '../widgets/nerdland_logo.dart';
import '../widgets/theme_toggle_button.dart';

import 'start_page.dart';
import 'register_page.dart';
import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showMessage('Preencha e-mail e senha');
      return;
    }

    try {
      setState(() => loading = true);

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => StartPage()),
      );
    } on FirebaseAuthException catch (e) {
      showMessage(e.message ?? 'Erro ao fazer login');
    } catch (e) {
      showMessage('Erro inesperado: $e');
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: colors.outline),
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: ThemeToggleButton(),
                  ),
                  SizedBox(height: 8),
                  NerdLandLogo(showText: false, size: 70),
                  SizedBox(height: 24),

                  Text(
                    'Bem-vindo de volta',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: colors.onSurface,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    'Entre na sua conta NerdLand',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      color: colors.onSurfaceVariant,
                    ),
                  ),

                  SizedBox(height: 32),

                  NerdLandInput(
                    label: 'Email',
                    hint: 'you@example.com',
                    controller: emailController,
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  SizedBox(height: 18),

                  NerdLandInput(
                    label: 'Senha',
                    hint: '••••••••',
                    controller: passwordController,
                    icon: Icons.lock_outline,
                    obscureText: true,
                  ),

                  SizedBox(height: 12),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ForgotPasswordPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Esqueci minha senha',
                        style: TextStyle(
                          color: colors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 16),

                  loading
                      ? CircularProgressIndicator()
                      : NerdLandButton(
                          text: 'Entrar',
                          onPressed: login,
                        ),

                  SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Não tem conta? ',
                        style: TextStyle(color: colors.onSurfaceVariant),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => RegisterPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Criar conta',
                          style: TextStyle(
                            color: colors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}