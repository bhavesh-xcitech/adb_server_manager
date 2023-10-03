import 'package:flutter/material.dart';

class GapH extends StatelessWidget {
  final double gap;
  const GapH(this.gap, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: gap);
  }
}
