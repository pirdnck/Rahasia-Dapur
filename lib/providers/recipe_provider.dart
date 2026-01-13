import 'package:flutter/material.dart';
import '../models/ingredient_model.dart';
import '../models/recipe_model.dart';
import '../database/database_helper.dart';

class RecipeProvider with ChangeNotifier {
  final List<Ingredient> _ingredients = dummyIngredients;
  List<Ingredient> get ingredients => _ingredients;

  List<String> get selectedIngredientNames =>
      _ingredients.where((i) => i.isSelected).map((i) => i.name).toList();

  List<Recipe> _recipes = [];
  List<Recipe> get recipes => _recipes;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  List<Recipe> _favorites = [];
  List<Recipe> get favorites => _favorites;

  RecipeProvider() { loadFavorites(); }

  void toggleIngredient(int index) {
    _ingredients[index].isSelected = !_ingredients[index].isSelected;
    notifyListeners();
  }

  void searchRecipes() async {
    final selected = selectedIngredientNames;
    if (selected.isEmpty) {
      _error = "Pilih setidaknya satu bahan.";
      notifyListeners();
      return;
    }
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(milliseconds: 300));
      _recipes = _getDetailedDummyRecipes().where((recipe) {
        return recipe.ingredients.any((ing) => 
          selected.any((sel) => ing.toLowerCase().contains(sel.toLowerCase())));
      }).toList();
      if (_recipes.isEmpty) _error = "Resep tidak ditemukan.";
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadFavorites() async {
    _favorites = await DatabaseHelper.instance.getFavorites();
    notifyListeners();
  }

  Future<void> toggleFavorite(Recipe recipe) async {
    final isFav = isFavorite(recipe.id);
    if (isFav) {
      await DatabaseHelper.instance.deleteFavorite(recipe.id);
    } else {
      await DatabaseHelper.instance.insertFavorite(recipe);
    }
    await loadFavorites();
  }

  bool isFavorite(int id) => _favorites.any((element) => element.id == id);

  List<Recipe> _getDetailedDummyRecipes() {
    return [
      Recipe(
        id: 1,
        title: 'Nasi Goreng Spesial',
        icon: Icons.rice_bowl,
        ingredients: ['Nasi', 'Telur', 'Bawang Merah', 'Kecap'],
        instructions: '1. Tumis bawang merah.\n2. Masukkan telur kocok.\n3. Campur nasi dan kecap, aduk rata.',
      ),
      Recipe(
        id: 2,
        title: 'Mie Rebus Sayur',
        icon: Icons.ramen_dining,
        ingredients: ['Mie', 'Sawi', 'Telur'],
        instructions: '1. Rebus mie dan sawi.\n2. Tambahkan telur hingga matang.\n3. Sajikan hangat.',
      ),
      Recipe(
        id: 3,
        title: 'Telur Dadar Tomat',
        icon: Icons.egg,
        ingredients: ['Telur', 'Tomat', 'Garam'],
        instructions: '1. Kocok telur dengan garam.\n2. Masukkan potongan tomat.\n3. Goreng hingga kecokelatan.',
      ),
    ];
  }

  Future<Recipe> getRecipeDetail(int id) async {
    return _getDetailedDummyRecipes().firstWhere((r) => r.id == id);
  }
}