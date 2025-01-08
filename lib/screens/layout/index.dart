import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usemain/providers/config.dart';
import 'package:usemain/screens/layout/appbar.dart';
import 'package:usemain/screens/layout/data/index.dart';
import 'package:usemain/screens/layout/settings/index.dart';
import 'package:usemain/screens/layout/task/index.dart';
import 'package:usemain/screens/layout/home/index.dart';
import 'package:usemain/shares/native.dart';

final List<Widget> layoutScreens = [
  const HomeScreen(),
  const TaskScreen(),
  const DataScreen(),
  const SettingsScreen()
];

List<String> layoutLabels = ['发现', '任务', '数据', '设置'];

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, dynamic) async {
        if (Platform.isAndroid) {
          await Native.androidBackDesktop();
        }
      },
      child: Scaffold(
        extendBody: false,
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: false,
        appBar: Appbar(),
        bottomNavigationBar: SizedBox(
          height: 85 + MediaQuery.of(context).padding.bottom,
          child: buildCustomNavigationBar(
            Provider.of<ConfigProvider>(context),
          ),
        ),
        body: IndexedStack(
          index: currentIndex,
          children: layoutScreens,
        ),
      ),
    );
  }

  Widget buildCustomNavigationBar(ConfigProvider configProvider) {
    Color selectColor = configProvider.isLight ? Colors.black : Colors.white;
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: layoutLabels.map((label) {
          final index = layoutLabels.indexOf(label);
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              setState(() {
                currentIndex = index;
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.25,
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 16,
                      color: index == currentIndex ? selectColor : Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Container(
                    width: 30,
                    height: 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1),
                      color: index == currentIndex
                          ? selectColor
                          : Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
