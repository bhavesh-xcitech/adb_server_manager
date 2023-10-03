import 'package:flutter/material.dart';

class GapW extends StatelessWidget {
  final double gap;
  const GapW(this.gap, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: gap);
  }
}
