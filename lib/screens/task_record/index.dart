import 'package:flutter/material.dart';
import 'package:usemain/widgets/custom_scaffold.dart';

class TaskRecordScreen extends StatelessWidget {
  const TaskRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      title: "打卡记录",
      body: Center(child: Text("TaskRecord Screen")),
    );
  }
}
