import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:usemain/providers/config.dart';
import 'package:usemain/shares/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: isBackgroundColor(
                Provider.of<ConfigProvider>(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
