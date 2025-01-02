import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:usemain/providers/config.dart';
import 'package:usemain/screens/Layout/Task/week.dart';
import 'package:usemain/shares/colors.dart';

class Task {
  final String title;
  final String team;
  final Color color;

  Task({
    required this.title,
    required this.team,
    required this.color,
  });
}

final List<Task> tasks = [
  Task(
    title: 'Exploration of Financial Applications',
    team: 'Iconspace Team',
    color: Colors.orange,
  ),
  Task(
    title: 'Illustration',
    team: 'Iconspace Team',
    color: Colors.purple,
  ),
  Task(
    title: 'Square - S',
    team: 'Iconspace Team',
    color: Colors.pink,
  ),
  Task(
    title: 'Exploration of Financial Applications',
    team: 'Iconspace Team',
    color: Colors.orange,
  ),
  Task(
    title: 'Illustration',
    team: 'Iconspace Team',
    color: Colors.purple,
  ),
  Task(
    title: 'Square - S',
    team: 'Iconspace Team',
    color: Colors.pink,
  ),
  Task(
    title: 'Exploration of Financial Applications',
    team: 'Iconspace Team',
    color: Colors.orange,
  ),
  Task(
    title: 'Illustration',
    team: 'Iconspace Team',
    color: Colors.purple,
  ),
  Task(
    title: 'Square - S',
    team: 'Iconspace Team',
    color: Colors.pink,
  )
];

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  late DateTime now = DateTime.now();
  late int currentWeekday = now.weekday;
  late DateTime startOfWeek = now.subtract(Duration(days: currentWeekday - 1));

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Week(
            active: currentWeekday,
            onWeekChange: (value) {
              setState(() {
                currentWeekday = value;
              });
            },
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: tasks.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10);
                  },
                  itemBuilder: (_, index) {
                    final task = tasks[index];
                    return buildTaskCard(
                      task,
                      Provider.of<ConfigProvider>(context),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTaskCard(Task task, ConfigProvider provider) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/TaskRecord');
      },
      behavior: HitTestBehavior.opaque,
      child: Card(
        color: isBackgroundColor(provider),
        elevation: 0,
        margin: const EdgeInsets.only(top: 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          minLeadingWidth: 5,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          leading: Container(
            width: 5,
            height: double.infinity,
            decoration: BoxDecoration(
              color: task.color,
              borderRadius: BorderRadius.circular(2.5),
            ),
          ),
          trailing: GestureDetector(
            onTap: () {},
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: Icon(
                FontAwesomeIcons.check,
                size: 15,
                color: Colors.white,
              ),
            ),
          ),
          title: Text(
            task.title,
            style: const TextStyle(
              fontSize: 16,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          subtitle: Text(
            task.team,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
