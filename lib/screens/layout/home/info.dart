import 'package:flutter/material.dart';
import 'package:usemain/shares/colors.dart';
import 'package:usemain/widgets/Progress/circle.dart';

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
      ),
      child: Container(
        width: double.infinity,
        height: 150,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: commonGradient,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 25,
            horizontal: 35,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProgressCircle(
                progress: 65,
                width: 80,
                radius: 40,
                strokeWidth: 11,
                fontSize: 11,
                titleSize: 8,
                titleShow: false,
                progressColor: Colors.white,
                titleColor: Colors.white,
                progressStartColor: Colors.white,
                progressEndColor: Colors.white,
                backgroundColor: Color.fromARGB(119, 255, 255, 255),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 25,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Textbox(title: '标题', text: '12', type: '条'),
                    Textbox(title: '标题', text: '4', type: '条'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Textbox extends StatelessWidget {
  const Textbox({
    super.key,
    required this.title,
    required this.text,
    required this.type,
  });

  final String title;
  final String text;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 15,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Align(
          alignment: Alignment.center,
          child: Text(
            "$text$type",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}
