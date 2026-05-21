import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../theme/nerdland_theme.dart';
import '../widgets/nerdland_logo.dart';

import 'product_form_page.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  Future<bool> isAdmin() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return false;

    final doc = await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(user.uid)
        .get();

    if (!doc.exists) return false;

    final data = doc.data();

    return data?['tipo'] == 'admin';
  }

  Future<void> deleteProduct(BuildContext context, String productId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: NerdLandTheme.surface,
          title: const Text('Excluir produto'),
          content: const Text(
            'Tem certeza que deseja excluir este produto?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );

    if (confirm != true) return;

    await FirebaseFirestore.instance
        .collection('produtos')
        .doc(productId)
        .delete();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Produto excluído com sucesso!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NerdLandTheme.background,
      appBar: AppBar(
        title: const NerdLandLogo(size: 38),
      ),
      body: FutureBuilder<bool>(
        future: isAdmin(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final admin = snapshot.data ?? false;

          if (!admin) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'Acesso negado.\nEsta área é exclusiva para administradores.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }

          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('produtos')
                .snapshots(),
            builder: (context, productSnapshot) {
              if (productSnapshot.hasError) {
                return const Center(
                  child: Text(
                    'Erro ao carregar produtos',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }

              if (productSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final produtos = productSnapshot.data!.docs;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Gerenciar Produtos',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.w900,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Área administrativa da NerdLand',
                      style: TextStyle(
                        color: NerdLandTheme.textSecondary,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ProductFormPage(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Cadastrar Produto'),
                      ),
                    ),

                    const SizedBox(height: 24),

                    if (produtos.isEmpty)
                      const Center(
                        child: Text(
                          'Nenhum produto cadastrado ainda',
                          style: TextStyle(
                            color: NerdLandTheme.textSecondary,
                            fontSize: 16,
                          ),
                        ),
                      ),

                    ...produtos.map((doc) {
                      final produto = doc.data() as Map<String, dynamic>;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 14),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: NerdLandTheme.surface,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: NerdLandTheme.border),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                produto['imagem'] ?? '',
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 70,
                                    height: 70,
                                    color: NerdLandTheme.surfaceLight,
                                    child: const Icon(
                                      Icons.image_not_supported_outlined,
                                      color: NerdLandTheme.textSecondary,
                                    ),
                                  );
                                },
                              ),
                            ),

                            const SizedBox(width: 14),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    produto['nome'] ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'R\$ ${(produto['preco'] ?? 0).toString()}',
                                    style: const TextStyle(
                                      color: NerdLandTheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            IconButton(
                              icon: const Icon(Icons.edit_outlined),
                              color: NerdLandTheme.primary,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ProductFormPage(
                                      productId: doc.id,
                                      productData: produto,
                                    ),
                                  ),
                                );
                              },
                            ),

                            IconButton(
                              icon: const Icon(Icons.delete_outline),
                              color: NerdLandTheme.danger,
                              onPressed: () {
                                deleteProduct(context, doc.id);
                              },
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}