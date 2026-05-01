import 'package:flutter/material.dart';

class LanguageButton extends StatelessWidget {
  final String language;
  final bool isSelected;
  final VoidCallback onTap;

  const LanguageButton({
    super.key,
    required this.language,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 32,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0E3A99) : Colors.white,
          border: Border.all(color: const Color(0xFF0E3A99)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            language,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
