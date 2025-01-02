import 'package:flutter/material.dart';
import 'package:usemain/widgets/custom_scaffold.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      title: "语言",
      body: Center(child: Text("Language Screen")),
    );
  }
}
