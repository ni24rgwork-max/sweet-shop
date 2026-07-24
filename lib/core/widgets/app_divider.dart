import 'package:flutter/material.dart';

/// Hairline rule. Colour and thickness come from `dividerTheme`.
class AppDivider extends StatelessWidget {
  const AppDivider({
    super.key,
    this.height,
    this.thickness,
    this.indent,
    this.endIndent,
  });

  final double? height;
  final double? thickness;
  final double? indent;
  final double? endIndent;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height ?? 0,
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
    );
  }
}
