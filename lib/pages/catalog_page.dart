import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../theme/nerdland_theme.dart';
import '../widgets/nerdland_logo.dart';
import '../widgets/product_card.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NerdLandTheme.background,
      appBar: AppBar(title: const NerdLandLogo(size: 38)),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('produtos')
            .where('ativo', isEqualTo: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Erro ao carregar produtos',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final produtos = snapshot.data!.docs;

          if (produtos.isEmpty) {
            return const Center(
              child: Text(
                'Nenhum produto cadastrado ainda',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: produtos.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 0.62,
            ),
            itemBuilder: (context, index) {
              final produto = produtos[index].data() as Map<String, dynamic>;

              return ProductCard(
                nome: produto['nome'] ?? '',
                preco: (produto['preco'] ?? 0).toDouble(),
                imagem: produto['imagem'] ?? '',
                descricao: produto['descricao'] ?? '',
                categorias: produto['categorias'] ?? [],
              );
            },
          );
        },
      ),
    );
  }
}
