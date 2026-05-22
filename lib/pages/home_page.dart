import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const Color primaryPurple = Color(0xFF6A1B9A);
  static const Color darkPurple = Color(0xFF4A148C);

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'title': 'Jogos', 'icon': Icons.videogame_asset},
      {'title': 'HQs', 'icon': Icons.book},
      {'title': 'Comunidade', 'icon': Icons.forum},
      {'title': 'Explorações', 'icon': Icons.explore},
    ];

    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      appBar: AppBar(
        backgroundColor: darkPurple,
        title: const Text("NERDLAND", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              await auth.signOut();
              if (!context.mounted) return;

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginPage()),
              );
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  categories[index]['icon'] as IconData,
                  size: 50,
                  color: primaryPurple,
                ),
                const SizedBox(height: 15),
                Text(categories[index]['title'].toString()),
              ],
            ),
          );
        },
      ),
    );
  }
}