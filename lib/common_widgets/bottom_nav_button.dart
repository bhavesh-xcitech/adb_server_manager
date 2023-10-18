import 'package:flutter/material.dart';

class BottomNavButton extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final String text;
  final IconData iconData;
  final Function? onTap;

  const BottomNavButton({
    this.onTap,
    super.key,
    required this.index,
    required this.selectedIndex,
    required this.text,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    final color = index == selectedIndex ? Colors.blue : Colors.white;

    return GestureDetector(
      onTap: () => onTap?.call(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            iconData,
            color: color,
          ),
          Text(
            text,
            style: TextStyle(color: color),
          ),
        ],
      ),
    );
  }
}
