import 'package:flutter/material.dart';
import '../theme/nerdland_theme.dart';
import '../widgets/nerdland_button.dart';
import '../widgets/nerdland_logo.dart';
import 'catalog_page.dart';
import 'admin_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  Future<bool> isAdmin() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return false;

    final doc = await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(user.uid)
        .get();

    if (!doc.exists) return false;

    return doc.data()?['tipo'] == 'admin';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NerdLandTheme.background,
      appBar: AppBar(
        title: const NerdLandLogo(size: 38),

        actions: [
          FutureBuilder<bool>(
            future: isAdmin(),
            builder: (context, snapshot) {
              final admin = snapshot.data ?? false;

              if (!admin) {
                return const SizedBox();
              }

              return IconButton(
                icon: const Icon(Icons.admin_panel_settings_outlined),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AdminPage()),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: NerdLandTheme.surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: NerdLandTheme.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Seu universo anime favorito',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Encontre figures, mangás, roupas e acessórios nerds em um só lugar.',
                    style: TextStyle(
                      color: NerdLandTheme.textSecondary,
                      fontSize: 17,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 24),
                  NerdLandButton(
                    text: 'Explorar catálogo',
                    icon: Icons.arrow_forward,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CatalogPage()),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Row(
              children: const [
                Expanded(
                  child: _InfoCard(
                    icon: Icons.local_shipping_outlined,
                    title: 'Entrega',
                    text: 'Envio rápido',
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _InfoCard(
                    icon: Icons.star_outline,
                    title: 'Produtos',
                    text: 'Itens exclusivos',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: const [
                Expanded(
                  child: _InfoCard(
                    icon: Icons.security_outlined,
                    title: 'Compra segura',
                    text: 'Firebase ativo',
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _InfoCard(
                    icon: Icons.bolt_outlined,
                    title: 'Novidades',
                    text: 'Sempre atualizado',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: NerdLandTheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: NerdLandTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: NerdLandTheme.primary, size: 28),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            text,
            style: const TextStyle(
              color: NerdLandTheme.textSecondary,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
