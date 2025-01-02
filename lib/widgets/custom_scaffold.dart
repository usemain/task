import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:usemain/shares/colors.dart';
import 'package:usemain/widgets/custom_icon_button.dart';

class CustomScaffold extends StatefulWidget {
  final String title;
  final Widget body;
  final List<Widget> actions;
  final VoidCallback? onBack;
  final bool interceptBack;
  final String interceptMessage;

  const CustomScaffold({
    super.key,
    required this.title,
    required this.body,
    this.actions = const [],
    this.onBack,
    this.interceptBack = false,
    this.interceptMessage = "您确定关闭吗?",
  });

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontFamily: 'dingding',
            color: commonColor,
          ),
        ),
        leadingWidth: 39,
        leading: SizedBox(
          width: 39,
          child: Center(
            child: CustomIconButton(
              padding: const EdgeInsets.only(left: 15),
              icon: FontAwesomeIcons.xmark,
              iconColor: const Color(0xFF8B1A10),
              bgColor: const Color(0xFFEC6A5E),
              onTap: () {
                if (FocusScope.of(context).hasFocus) {
                  FocusScope.of(context).unfocus();
                }
                if (widget.interceptBack) {
                  showDialog(
                    context: context,
                    builder: (BuildContext ctx) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        title: const Text("提示"),
                        content: Text(widget.interceptMessage),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: const Text("取消"),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.red,
                            ),
                            onPressed: () {
                              Navigator.of(ctx).pop();
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              "确定",
                              style: TextStyle(
                                color: Color(0xFFEC6A5E),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  if (widget.onBack != null) {
                    widget.onBack!();
                  } else {
                    Navigator.pop(context);
                  }
                }
              },
            ),
          ),
        ),
        actions: widget.actions,
      ),
      body: widget.body,
    );
  }
}
