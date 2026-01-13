import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/recipe_provider.dart';
import '../widgets/recipe_card.dart';
import '../widgets/pantry_background.dart';

class RecipeListScreen extends StatelessWidget {
  const RecipeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Hasil Pencarian',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87), // Icon back jadi gelap
      ),
      body: PantryBackground(
        child: Consumer<RecipeProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator(color: Colors.orangeAccent));
            }

            return SafeArea(
              child: provider.recipes.isEmpty
                  ? const Center(
                      child: Text('Tidak ada resep ditemukan.', 
                      style: TextStyle(color: Colors.black54)))
                  : ListView.builder(
                      padding: const EdgeInsets.only(top: 10, bottom: 20),
                      itemCount: provider.recipes.length,
                      itemBuilder: (context, index) {
                        final recipe = provider.recipes[index];
                        return RecipeCard(
                          recipe: recipe,
                          isFavorite: provider.isFavorite(recipe.id),
                          onFavoriteToggle: () => provider.toggleFavorite(recipe),
                          onTap: () {
                            Navigator.pushNamed(context, '/detail', arguments: recipe);
                          },
                        );
                      },
                    ),
            );
          },
        ),
      ),
    );
  }
}