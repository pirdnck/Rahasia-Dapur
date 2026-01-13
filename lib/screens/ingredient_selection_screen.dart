import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/recipe_provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/pantry_background.dart';
import 'package:cached_network_image/cached_network_image.dart';

class IngredientSelectionScreen extends StatelessWidget {
  const IngredientSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Rahasia Dapur', 
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.black87),
        actions: [
          IconButton(icon: const Icon(Icons.favorite), onPressed: () => Navigator.pushNamed(context, '/favorites')),
          IconButton(icon: const Icon(Icons.exit_to_app), onPressed: () {
            Provider.of<AuthProvider>(context, listen: false).logout();
            Navigator.pushReplacementNamed(context, '/login');
          }),
        ],
      ),
      body: PantryBackground(
        child: Consumer<RecipeProvider>(
          builder: (context, provider, child) {
            return SafeArea(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('Pilih Bahan yang Tersedia:', 
                      style: TextStyle(color: Colors.black54, fontSize: 18, fontWeight: FontWeight.w500)),
                  ),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, crossAxisSpacing: 12, mainAxisSpacing: 12),
                      itemCount: provider.ingredients.length,
                      itemBuilder: (context, index) {
                        final ing = provider.ingredients[index];
                        return GestureDetector(
                          onTap: () => provider.toggleIngredient(index),
                          child: Container(
                            decoration: BoxDecoration(
                              color: ing.isSelected ? Colors.orangeAccent.withOpacity(0.2) : Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: ing.isSelected ? Colors.orangeAccent : Colors.white),
                              boxShadow: [
                                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CachedNetworkImage(imageUrl: ing.image, height: 40, 
                                  errorWidget: (_, __, ___) => const Icon(Icons.kitchen, color: Colors.grey)),
                                const SizedBox(height: 8),
                                Text(ing.name, style: const TextStyle(color: Colors.black87, fontSize: 12), textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.orangeAccent,
        onPressed: () {
          final p = Provider.of<RecipeProvider>(context, listen: false);
          if (p.selectedIngredientNames.isNotEmpty) {
            p.searchRecipes();
            Navigator.pushNamed(context, '/recipes', arguments: p.selectedIngredientNames);
          }
        },
        label: const Text('CARI RESEP', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        icon: const Icon(Icons.search, color: Colors.white),
      ),
    );
  }
}