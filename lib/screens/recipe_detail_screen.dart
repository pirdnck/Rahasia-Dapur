import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/recipe_model.dart';
import '../providers/recipe_provider.dart';
import '../widgets/pantry_background.dart';

class RecipeDetailScreen extends StatefulWidget {
  const RecipeDetailScreen({super.key});
  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  Recipe? _recipe;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_recipe == null) {
      final args = ModalRoute.of(context)!.settings.arguments as Recipe;
      _loadDetails(args);
    }
  }

  Future<void> _loadDetails(Recipe r) async {
    final p = Provider.of<RecipeProvider>(context, listen: false);
    final detail = await p.getRecipeDetail(r.id);
    if (mounted) setState(() { _recipe = detail; _isLoading = false; });
  }

  void _shareToWhatsApp() async {
    final message = "Halo Chef! Saya tertarik dengan resep ${_recipe!.title}. Bisakah bantu jelaskan lebih lanjut?";
    final url = "https://wa.me/628123456789?text=${Uri.encodeComponent(message)}";
    if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal membuka WhatsApp')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: PantryBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 100, 20, 20),
          child: Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Icon(_recipe!.icon, size: 80, color: Colors.orangeAccent)),
                const SizedBox(height: 20),
                Text(_recipe!.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const Divider(height: 40),
                const Text('Bahan:', style: TextStyle(color: Colors.orangeAccent, fontSize: 18, fontWeight: FontWeight.bold)),
                ..._recipe!.ingredients.map((i) => Text('• $i', style: const TextStyle(fontSize: 16))),
                const SizedBox(height: 25),
                const Text('Instruksi:', style: TextStyle(color: Colors.orangeAccent, fontSize: 18, fontWeight: FontWeight.bold)),
                Text(_recipe!.instructions, style: const TextStyle(fontSize: 16, height: 1.5)),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _shareToWhatsApp,
                    icon: const Icon(Icons.message),
                    label: const Text('Tanya Chef via WhatsApp'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}