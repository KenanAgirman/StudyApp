import 'package:flutter/material.dart';
import 'package:studdyapp/components/header_home.dart';
import 'package:studdyapp/components/my_buttton.dart';
import 'package:studdyapp/components/my_drawer.dart';
import 'package:studdyapp/components/my_task.dart';
import 'package:studdyapp/model/task.dart';
import 'package:studdyapp/styles/constants.dart';

class Home extends StatelessWidget {
  static const routeName = '/home';

  const Home({super.key});

  void addTask(){
    print('JE FAIS UNE TACHE');
  }
  @override
  Widget build(BuildContext context) {
    final List<Task> tasks = [
      Task(title: 'Faire les courses',
          description: 'Acheter du lait et du pain',
          isDone: false),
      Task(title: 'Réviser Flutter',
          description: 'Widgets, State, Navigation',
          isDone: false),
      Task(title: 'TFE', description: 'Avancer sur la maquette', isDone: false),
    ];

    return Scaffold(
      backgroundColor: kPrimaryColor,
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              HeaderHome(),
              const SizedBox(height: 16),
              ...tasks.map((task) => MyTask(task: task)).toList(),

              const SizedBox(height: kVerticalPaddingL,),

              MyButton(text: "Crée une tâche",onTap: addTask),
              const SizedBox(height: kVerticalPaddingL,),

            ],
          ),
        ),
      ),
    );
  }
}