import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/pantry_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  void _navigateToNext() async {
    // Menunggu 3 detik agar user bisa melihat logo
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    
    final auth = Provider.of<AuthProvider>(context, listen: false);
    
    // Logic navigasi setelah splash
    if (auth.isLoggedIn) {
      Navigator.pushReplacementNamed(context, '/ingredients');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // MENGGUNAKAN PANTRYBACKGROUND AGAR WARNA SAMA DENGAN MENU LAIN
      body: PantryBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Lingkaran putih halus di belakang icon agar terlihat premium
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                      spreadRadius: 5,
                    )
                  ],
                ),
                child: const Icon(
                  Icons.restaurant_menu, 
                  size: 80, 
                  color: Colors.orangeAccent
                ),
              ),
              const SizedBox(height: 24),
              // Teks menggunakan warna hitam lembut (black87) sesuai konsistensi menu
              const Text(
                'Rahasia Dapur',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Solusi Masak dari Dapurmu',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 50),
              // Loading indicator warna orange agar matching dengan FAB di menu utama
              const CircularProgressIndicator(
                color: Colors.orangeAccent,
                strokeWidth: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
} 