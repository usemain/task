import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usemain/providers/config.dart';
import 'package:usemain/screens/layout/appbar.dart';
import 'package:usemain/screens/layout/task/index.dart';
import 'package:usemain/screens/layout/home/index.dart';
import 'package:usemain/shares/native.dart';

final List<Widget> tabBarScreens = [
  const HomeScreen(),
  const TaskScreen(),
];

List<String> tabBarLabels = ['发现', '任务', '统计', '设置'];

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int currentIndex = 0;
  String tabBarLabel = tabBarLabels[0];

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
          children: tabBarScreens,
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
        children: tabBarLabels.map((label) {
          final index = tabBarLabels.indexOf(label);
          final isSelected = index == currentIndex;
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              setState(() {
                currentIndex = index;
                tabBarLabel = tabBarLabels[index];
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.4,
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 16,
                      color: isSelected ? selectColor : Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Container(
                    height: 2,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1),
                      color: isSelected ? selectColor : Colors.transparent,
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
