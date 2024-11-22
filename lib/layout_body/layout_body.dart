import "package:app2/centered_view.dart";
import "package:app2/homie.dart";
import "package:flutter/material.dart";

class LayoutTemplate extends StatelessWidget {
  const LayoutTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return const CenteredView(child: Homie());
      },
    );
  }
}