import 'package:flutter/material.dart';

class DotsIndicator extends StatelessWidget {
  final int currentPage;

  const DotsIndicator({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        int pageIndex = index + 1; 

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: currentPage == pageIndex ? 16 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: currentPage == pageIndex
                ? const Color(0xFF0E3A99)
                : Colors.grey,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
