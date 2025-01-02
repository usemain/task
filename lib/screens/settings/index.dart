import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usemain/providers/config.dart';
import 'package:usemain/screens/settings/header.dart';
import 'package:usemain/screens/settings/menus.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late ConfigProvider configProvider;

  @override
  Widget build(BuildContext context) {
    configProvider = Provider.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Header(),
                  MenuSwitchItem(
                    title: '深色',
                    value: !configProvider.isLight,
                    onTap: (value) {
                      configProvider.setTheme(!value);
                    },
                  ),
                  MenuItem(
                    title: '语言',
                    onTap: () {
                      Navigator.pushNamed(context, '/Language');
                    },
                  ),
                  MenuItem(
                    title: '退出',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 10),
            alignment: Alignment.center,
            child: Text(
              'Alova 1.0.0',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: configProvider.isLight
                    ? Colors.grey[400]
                    : Colors.grey[800],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
