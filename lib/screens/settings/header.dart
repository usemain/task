import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 0, 149, 255),
            Color.fromARGB(255, 6, 188, 255),
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/logo.svg',
                  width: 20,
                  height: 20,
                ),
                SizedBox(width: 15),
                Text(
                  "会员剩余 13天",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          _buildLevel(),
        ],
      ),
    );
  }

  Widget _buildLevel() {
    return Container(
      height: 25,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFF2C3B4E),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text(
        'VIP',
        style: TextStyle(
          fontSize: 14,
          color: Colors.white,
          fontFamily: "dingding",
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
