import 'package:flutter/material.dart';

void main() {
  runApp(const NerdlandApp());
}

class NerdlandApp extends StatelessWidget {
  const NerdlandApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nerdland',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: NerdlandTheme.primaryPurple,
        fontFamily: 'Roboto', // Substitua pela sua fonte personalizada se tiver
      ),
      home: const LoginPage(),
    );
  }
}

// ==========================================
// TEMA E ESTILOS GERAIS
// ==========================================
class NerdlandTheme {
  static const Color primaryPurple = Color(0xFF6A1B9A);
  static const Color darkPurple = Color(0xFF4A148C);
  
  static BoxDecoration mainGradient() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.purple[100]!, darkPurple],
      ),
    );
  }

  static InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      filled: true,
      fillColor: Colors.white.withOpacity(0.2),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    );
  }
}

// ==========================================
// TELA DE LOGIN
// ==========================================
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: NerdlandTheme.mainGradient(),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logotipo com fallback de erro para evitar quebras antes de adicionar a imagem
              Image.asset(
                'assets/logo_nerdland.png', 
                height: 120,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 100, color: Colors.white54),
              ),
              const SizedBox(height: 40),
              TextField(decoration: NerdlandTheme.inputDecoration("Login")),
              const SizedBox(height: 20),
              TextField(
                obscureText: true,
                decoration: NerdlandTheme.inputDecoration("Senha"),
              ),
              Row(
                children: [
                  Switch(value: true, onChanged: (v) {}, activeColor: Colors.white),
                  const Text("Lembrar de mim", style: TextStyle(color: Colors.white)),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: NerdlandTheme.darkPurple,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {
                  // Navega para a Home, substituindo a tela de login na pilha
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                child: const Text("Login", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordPage()));
                },
                child: const Text("Esqueceu a senha?", style: TextStyle(color: Colors.white70)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
                },
                child: const Text("Criar Nova Conta", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// TELA DE REGISTRO
// ==========================================
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, 
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: NerdlandTheme.mainGradient(),
        height: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              const SizedBox(height: 60),
              Image.asset(
                'assets/logo_nerdland.png', 
                height: 80,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 60, color: Colors.white54),
              ),
              const SizedBox(height: 10),
              const Text("Criar Nova Conta", style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),
              TextField(decoration: NerdlandTheme.inputDecoration("Nome Completo")),
              const SizedBox(height: 15),
              TextField(decoration: NerdlandTheme.inputDecoration("E-mail")),
              const SizedBox(height: 15),
              TextField(obscureText: true, decoration: NerdlandTheme.inputDecoration("Senha")),
              const SizedBox(height: 15),
              TextField(obscureText: true, decoration: NerdlandTheme.inputDecoration("Confirmar Senha")),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: NerdlandTheme.darkPurple,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {
                  // Aqui você faria o registro e voltaria pro login ou iria pra home
                  Navigator.pop(context); 
                },
                child: const Text("Registrar", style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Já tem uma conta? Login", style: TextStyle(color: Colors.white70)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// TELA DE RECUPERAÇÃO DE SENHA
// ==========================================
class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, 
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: NerdlandTheme.mainGradient(),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo_nerdland.png', 
                height: 100,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 80, color: Colors.white54),
              ),
              const SizedBox(height: 20),
              const Text("Recuperar Senha", style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "Insira seu e-mail para receber um código de redefinição.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ),
              TextField(decoration: NerdlandTheme.inputDecoration("E-mail")),
              const SizedBox(height: 25),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: NerdlandTheme.darkPurple,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Código enviado para o e-mail!')),
                  );
                  Navigator.pop(context); // Volta para a tela de login
                },
                child: const Text("Enviar Código", style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// HOME PAGE
// ==========================================
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {'title': 'Jogos', 'icon': Icons.videogame_asset},
      {'title': 'HQs', 'icon': Icons.book},
      {'title': 'Comunidade', 'icon': Icons.forum},
      {'title': 'Explorações', 'icon': Icons.explore},
    ];

    return Scaffold(
      backgroundColor: Colors.purple[50], // Fundo claro para contraste com os cards
      appBar: AppBar(
        title: Image.asset(
          'assets/logo_nerdland.png', 
          height: 35,
          errorBuilder: (context, error, stackTrace) => const Text("NERDLAND", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        centerTitle: true,
        backgroundColor: NerdlandTheme.darkPurple,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white), 
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
            }
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(25.0),
            child: Text("Olá, Nerd!", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: NerdlandTheme.darkPurple)),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1.1, // Ajusta a proporção dos cards
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(categories[index]['icon'], size: 50, color: NerdlandTheme.primaryPurple),
                      const SizedBox(height: 15),
                      Text(categories[index]['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: NerdlandTheme.primaryPurple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Explorar'),
          BottomNavigationBarItem(icon: Icon(Icons.library_books), label: 'Biblioteca'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}