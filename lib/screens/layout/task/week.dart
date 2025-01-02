import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usemain/providers/config.dart';
import 'package:usemain/shares/colors.dart';

const weekMap = ['一', '二', '三', '四', '五', '六', '日'];

class Week extends StatefulWidget {
  final int active;
  final Function(int) onWeekChange;

  const Week({
    super.key,
    required this.active,
    required this.onWeekChange,
  });

  @override
  State<Week> createState() => _WeekState();
}

class _WeekState extends State<Week> {
  late List<Map<String, dynamic>> weekData;
  late DateTime now = DateTime.now();
  late DateTime startOfWeek;

  DateTime currentDay(int index) {
    return startOfWeek.add(Duration(days: index));
  }

  bool isToday(int index) {
    return currentDay(index).day == now.day &&
        currentDay(index).month == now.month &&
        currentDay(index).year == now.year;
  }

  @override
  void initState() {
    startOfWeek = now.subtract(Duration(days: widget.active - 1));
    weekData = getCurrentWeekDays();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (int index = 0; index < weekMap.length; index++) {
        if (isToday(index)) {
          widget.onWeekChange(index);
          break;
        }
      }
    });

    super.initState();
  }

  List<Map<String, dynamic>> getCurrentWeekDays() {
    return List.generate(weekMap.length, (index) {
      return {
        'week': '周${weekMap[index]}',
        'date': currentDay(index).day,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isBackgroundColor(Provider.of<ConfigProvider>(context)),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: weekData.asMap().entries.map((entry) {
          int index = entry.key;
          Map<String, dynamic> day = entry.value;
          bool isActive = index == widget.active;

          return Expanded(
            child: GestureDetector(
              onTap: () => widget.onWeekChange(index),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        day['week'],
                        style: TextStyle(
                          fontSize: 10,
                          color: isActive ? commonColor : Color(0xFF959595),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${day['date']}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isActive ? commonColor : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
