import 'package:flutter/material.dart';

class ThemeButton extends StatelessWidget {
  final bool isDark;
  final bool isSelected;
  final VoidCallback onTap;

  const ThemeButton({
    super.key,
    required this.isDark,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 32,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0E3A99) : Colors.white,
          border: Border.all(color: const Color(0xFF0E3A99)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          isDark ? Icons.nightlight_round : Icons.wb_sunny,
          size: 18,
          color: isSelected ? Colors.white : Colors.blue,
        ),
      ),
    );
  }
}
