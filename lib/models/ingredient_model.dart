class Ingredient {
  final String name;
  final String image;
  bool isSelected;

  Ingredient({required this.name, required this.image, this.isSelected = false});
}

// Predefined list of ingredients for selection
final List<Ingredient> dummyIngredients = [
  Ingredient(name: 'Ayam', image: 'https://img.icons8.com/color/96/chicken.png'),
  Ingredient(name: 'Sapi', image: 'https://img.icons8.com/color/96/cow.png'),
  Ingredient(name: 'Telur', image: 'https://img.icons8.com/color/96/egg.png'),
  Ingredient(name: 'Ikan', image: 'https://img.icons8.com/color/96/fish.png'),
  Ingredient(name: 'Wortel', image: 'https://img.icons8.com/color/96/carrot.png'),
  Ingredient(name: 'Tomat', image: 'https://img.icons8.com/color/96/tomato.png'),
  Ingredient(name: 'Kentang', image: 'https://img.icons8.com/color/96/potato.png'),
  Ingredient(name: 'Bawang', image: 'https://img.icons8.com/color/96/onion.png'),
  Ingredient(name: 'Cabai', image: 'https://img.icons8.com/color/96/chili-pepper.png'),
  Ingredient(name: 'Nasi', image: 'https://img.icons8.com/color/96/rice-bowl.png'),
  Ingredient(name: 'Pasta', image: 'https://img.icons8.com/color/96/spaghetti.png'),
  Ingredient(name: 'Keju', image: 'https://img.icons8.com/color/96/cheese.png'),
];
