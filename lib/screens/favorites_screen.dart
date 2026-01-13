import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/recipe_provider.dart';
import '../widgets/recipe_card.dart';
import '../widgets/pantry_background.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  void _confirmDelete(BuildContext context, dynamic provider, dynamic recipe) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Favorit?'),
        content: Text('Yakin ingin menghapus ${recipe.title} dari daftar?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          TextButton(
            onPressed: () {
              provider.toggleFavorite(recipe);
              Navigator.pop(context);
            },
            child: const Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Resep Favorit', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: PantryBackground(
        child: Consumer<RecipeProvider>(
          builder: (context, provider, child) {
            if (provider.favorites.isEmpty) {
              return const Center(child: Text('Belum ada favorit tersimpan.'));
            }
            return ListView.builder(
              padding: const EdgeInsets.only(top: 100),
              itemCount: provider.favorites.length,
              itemBuilder: (context, index) {
                final recipe = provider.favorites[index];
                return RecipeCard(
                  recipe: recipe,
                  isFavorite: true,
                  onFavoriteToggle: () => _confirmDelete(context, provider, recipe),
                  onTap: () => Navigator.pushNamed(context, '/detail', arguments: recipe),
                );
              },
            );
          },
        ),
      ),
    );
  }
}