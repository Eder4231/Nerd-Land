import 'package:flutter/material.dart';
import '../theme/nerdland_theme.dart';

class ProductCard extends StatelessWidget {
  final String nome;
  final double preco;
  final String imagem;
  final String descricao;
  final List categorias;

  const ProductCard({
    super.key,
    required this.nome,
    required this.preco,
    required this.imagem,
    required this.descricao,
    required this.categorias,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: NerdLandTheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: NerdLandTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
            child: Image.network(
              imagem,
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 140,
                  color: NerdLandTheme.surfaceLight,
                  child: Center(
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      color: NerdLandTheme.textSecondary,
                      size: 40,
                    ),
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nome,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  'R\$ ${preco.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: NerdLandTheme.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  descricao,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: NerdLandTheme.textSecondary,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 10),

                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: categorias.take(2).map((categoria) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: NerdLandTheme.surfaceLight,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        categoria.toString(),
                        style: TextStyle(
                          color: NerdLandTheme.textSecondary,
                          fontSize: 11,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
