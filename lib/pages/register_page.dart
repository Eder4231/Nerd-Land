import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../theme/nerdland_theme.dart';
import '../widgets/nerdland_button.dart';
import '../widgets/nerdland_input.dart';
import '../widgets/nerdland_logo.dart';

import 'start_page.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool loading = false;

  Future<void> register() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      showMessage('Preencha todos os campos');
      return;
    }

    if (password != confirmPassword) {
      showMessage('As senhas não são iguais');
      return;
    }

    if (password.length < 6) {
      showMessage('A senha precisa ter pelo menos 6 caracteres');
      return;
    }

    try {
      setState(() => loading = true);

      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final uid = credential.user!.uid;

      await FirebaseFirestore.instance.collection('usuarios').doc(uid).set({
        'uid': uid,
        'nome': name,
        'email': email,
        'tipo': 'usuario',
        'criadoEm': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      showMessage('Conta criada com sucesso!');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const StartPage()),
      );
    } on FirebaseAuthException catch (e) {
      showMessage(e.message ?? 'Erro ao criar conta');
    } on FirebaseException catch (e) {
      showMessage('Erro no Firestore: ${e.message}');
    } catch (e) {
      showMessage('Erro inesperado: $e');
    } finally {
      if (mounted) {
        setState(() => loading = false);
      }
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NerdLandTheme.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: NerdLandTheme.surface,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: NerdLandTheme.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const NerdLandLogo(showText: false, size: 70),
                  const SizedBox(height: 24),
                  const Text(
                    'Criar conta',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Entre para o universo NerdLand',
                    style: TextStyle(
                      fontSize: 17,
                      color: NerdLandTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 32),

                  NerdLandInput(
                    label: 'Nome',
                    hint: 'Seu nome',
                    controller: nameController,
                    icon: Icons.person_outline,
                  ),

                  const SizedBox(height: 18),

                  NerdLandInput(
                    label: 'Email',
                    hint: 'you@example.com',
                    controller: emailController,
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 18),

                  NerdLandInput(
                    label: 'Senha',
                    hint: '••••••••',
                    controller: passwordController,
                    icon: Icons.lock_outline,
                    obscureText: true,
                  ),

                  const SizedBox(height: 18),

                  NerdLandInput(
                    label: 'Confirmar senha',
                    hint: '••••••••',
                    controller: confirmPasswordController,
                    icon: Icons.lock_outline,
                    obscureText: true,
                  ),

                  const SizedBox(height: 28),

                  loading
                      ? const CircularProgressIndicator()
                      : NerdLandButton(
                          text: 'Criar conta',
                          onPressed: register,
                        ),

                  const SizedBox(height: 18),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Já tem uma conta? ',
                        style: TextStyle(color: NerdLandTheme.textSecondary),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginPage(),
                            ),
                          );
                        },
                        child: const Text(
                          'Entrar',
                          style: TextStyle(
                            color: NerdLandTheme.primary,
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

