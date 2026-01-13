import 'package:flutter/material.dart';

class PantryBackground extends StatelessWidget {
  final Widget child;
  const PantryBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Gradasi Terang (Light Mode Style)
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFF5F7FA), // Putih kebiruan segar
                  Color(0xFFE4E7EB), // Abu-abu sangat muda
                  Color(0xFFF9F0E6), // Sedikit aksen krem hangat
                ],
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}