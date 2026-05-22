import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../theme/nerdland_theme.dart';
import '../widgets/theme_toggle_button.dart';
import 'login_page.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();
  bool loading = false;

  Future<void> resetPassword() async {
    try {
      setState(() => loading = true);

      await auth.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("E-mail de recuperação enviado!"),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginPage()),
      );
    } on FirebaseAuthException {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro ao enviar e-mail de recuperação"),
        ),
      );
    } finally {
      setState(() => loading = false);
    }
  }

  InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.2),
      labelStyle: TextStyle(color: NerdLandTheme.textSecondary),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
    );
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: const ThemeToggleButton(),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Recuperar Senha",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: NerdLandTheme.textPrimary,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    "Digite seu e-mail para receber o link de recuperação.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: NerdLandTheme.textSecondary),
                  ),

                  const SizedBox(height: 30),

                  TextField(
                    controller: emailController,
                    decoration: inputDecoration("E-mail"),
                  ),

                  const SizedBox(height: 25),

                  ElevatedButton(
                    onPressed: loading ? null : resetPassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: NerdLandTheme.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: loading
                        ? const CircularProgressIndicator()
                        : const Text("Enviar link"),
                  ),

                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => LoginPage()),
                      );
                    },
                    child: Text(
                      "Voltar para login",
                      style: TextStyle(color: NerdLandTheme.primary),
                    ),
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