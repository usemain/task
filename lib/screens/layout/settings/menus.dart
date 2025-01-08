import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:usemain/providers/config.dart';
import 'package:usemain/shares/colors.dart';
import 'package:usemain/widgets/custom_switch.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final GestureDoubleTapCallback? onTap;

  const MenuItem({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: isBackgroundColor(
            Provider.of<ConfigProvider>(context),
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          height: 40,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Icon(
                FontAwesomeIcons.chevronRight,
                size: 16,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MenuSwitchItem extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool>? onTap;

  const MenuSwitchItem({
    super.key,
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: isBackgroundColor(
          Provider.of<ConfigProvider>(context),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 40,
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            CustomSwitch(
              value: value,
              onChanged: onTap,
            ),
          ],
        ),
      ),
    );
  }
}
