import 'package:flutter/material.dart';

class Recipe {
  final int id;
  final String title;
  final IconData icon; 
  final List<String> ingredients;
  final String instructions;

  Recipe({
    required this.id,
    required this.title,
    required this.icon,
    required this.ingredients,
    required this.instructions,
  });

  // Fungsi untuk update data parsial jika diperlukan
  Recipe copyWith({
    int? id,
    String? title,
    IconData? icon,
    List<String>? ingredients,
    String? instructions,
  }) {
    return Recipe(
      id: id ?? this.id,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      ingredients: ingredients ?? this.ingredients,
      instructions: instructions ?? this.instructions,
    );
  }

  // Konversi dari database (SQLite)
  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'],
      title: map['title'],
      // Mengubah int codePoint kembali menjadi IconData
      icon: IconData(map['icon'], fontFamily: 'MaterialIcons'),
      // Mengubah String database kembali menjadi List
      ingredients: (map['ingredients'] as String).split(','),
      instructions: map['instructions'] ?? '',
    );
  }

  // Konversi ke database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'icon': icon.codePoint, // Menyimpan int codePoint icon
      'ingredients': ingredients.join(','), // Menyimpan List sebagai String
      'instructions': instructions,
    };
  }
}