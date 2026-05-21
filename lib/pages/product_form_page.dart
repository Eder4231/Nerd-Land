import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../theme/nerdland_theme.dart';
import '../widgets/nerdland_button.dart';
import '../widgets/nerdland_input.dart';
import '../widgets/nerdland_logo.dart';

class ProductFormPage extends StatefulWidget {
  final String? productId;
  final Map<String, dynamic>? productData;

  const ProductFormPage({super.key, this.productId, this.productData});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final imageController = TextEditingController();
  final categoriesController = TextEditingController();
  final descriptionController = TextEditingController();

  bool loading = false;

  bool get isEditing => widget.productId != null;

  @override
  void initState() {
    super.initState();

    if (isEditing && widget.productData != null) {
      final data = widget.productData!;

      nameController.text = data['nome'] ?? '';
      priceController.text = (data['preco'] ?? '').toString();
      imageController.text = data['imagem'] ?? '';
      descriptionController.text = data['descricao'] ?? '';

      final categorias = data['categorias'];
      if (categorias is List) {
        categoriesController.text = categorias.join(', ');
      }
    }
  }

  Future<void> saveProduct() async {
    final name = nameController.text.trim();
    final priceText = priceController.text.trim().replaceAll(',', '.');
    final imageUrl = imageController.text.trim();
    final description = descriptionController.text.trim();

    final categories = categoriesController.text
        .split(',')
        .map((e) => e.trim().toLowerCase())
        .where((e) => e.isNotEmpty)
        .toList();

    if (name.isEmpty ||
    priceText.isEmpty ||
    description.isEmpty ||
    categories.isEmpty) {
      showMessage('Preencha todos os campos');
      return;
    }

    final price = double.tryParse(priceText);

    if (price == null) {
      showMessage('Digite um preço válido');
      return;
    }

    try {
      setState(() => loading = true);

      final product = {
        'nome': name,
        'preco': price,
        'imagem': imageUrl.isEmpty
    ? 'https://placehold.co/400x400/png?text=NerdLand'
    : imageUrl,
        'descricao': description,
        'categorias': categories,
        'ativo': true,
        'atualizadoEm': FieldValue.serverTimestamp(),
      };

      if (isEditing) {
        await FirebaseFirestore.instance
            .collection('produtos')
            .doc(widget.productId)
            .update(product);

        showMessage('Produto atualizado com sucesso!');
      } else {
        await FirebaseFirestore.instance.collection('produtos').add({
          ...product,
          'criadoEm': FieldValue.serverTimestamp(),
        });

        showMessage('Produto cadastrado com sucesso!');
      }

      if (!mounted) return;

      Navigator.pop(context);
    } on FirebaseException catch (e) {
      showMessage('Erro no Firebase: ${e.message}');
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
    priceController.dispose();
    imageController.dispose();
    categoriesController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NerdLandTheme.background,
      appBar: AppBar(title: const NerdLandLogo(size: 38)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: NerdLandTheme.surface,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: NerdLandTheme.border),
          ),
          child: Column(
            children: [
              Text(
                isEditing ? 'Editar Produto' : 'Novo Produto',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                isEditing
                    ? 'Atualize as informações do produto'
                    : 'Cadastre um produto no catálogo NerdLand',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: NerdLandTheme.textSecondary,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 28),

              NerdLandInput(
                label: 'Nome do produto',
                hint: 'Ex: Figure Naruto',
                controller: nameController,
                icon: Icons.shopping_bag_outlined,
              ),

              const SizedBox(height: 18),

              NerdLandInput(
                label: 'Preço',
                hint: 'Ex: 99.90',
                controller: priceController,
                icon: Icons.attach_money,
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 18),

              NerdLandInput(
                label: 'URL da imagem',
                hint: 'Cole o link da imagem',
                controller: imageController,
                icon: Icons.image_outlined,
                keyboardType: TextInputType.url,
              ),

              const SizedBox(height: 18),

              NerdLandInput(
                label: 'Categorias',
                hint: 'anime, figure, naruto',
                controller: categoriesController,
                icon: Icons.category_outlined,
              ),

              const SizedBox(height: 18),

              NerdLandInput(
                label: 'Descrição',
                hint: 'Descrição do produto',
                controller: descriptionController,
                icon: Icons.description_outlined,
              ),

              const SizedBox(height: 28),

              loading
                  ? const CircularProgressIndicator()
                  : NerdLandButton(
                      text: isEditing ? 'Salvar Alterações' : 'Salvar Produto',
                      onPressed: saveProduct,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
