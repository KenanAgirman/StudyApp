import 'package:flutter/material.dart';
import 'package:studdyapp/model/task.dart';
import 'package:studdyapp/styles/constants.dart';

class MyTask extends StatelessWidget {
  final Task task;

  const MyTask({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kSecondaryColor,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Icon(
          task.isDone ? Icons.check_circle : Icons.radio_button_unchecked,
          color: task.isDone ? Colors.green : Colors.black,
        ),
        title: Text(
          task.title,
          style: const TextStyle(color: Colors.black),
        ),
        subtitle: Text(task.description),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          // action à définir
        },
      ),
    );

  }
}