import 'package:flutter/material.dart';

class OptionRow extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const OptionRow({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Poppins',
              color: Color(0xFF0E3A99),
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          ...children,
        ],
      ),
    );
  }
}
