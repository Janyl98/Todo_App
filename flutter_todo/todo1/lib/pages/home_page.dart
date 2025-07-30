import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo1/models/task.dart';
import 'package:todo1/models/task_data.dart';
import 'package:todo1/services/database_services.dart';

import '../task_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task>? tasks;
  String taskTitle = "";
  getTasks() async {
    tasks = await DatabaseServices.getTasks();
    Provider.of<TasksData>(context, listen: false).tasks = tasks!;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return tasks == null
        ? const Scaffold(body: Center(child: CircularProgressIndicator()))
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green.shade300,
              title: Text(
                'Todo  ${Provider.of<TasksData>(context).tasks.length} tasks',
                style: const TextStyle(color: Colors.white),
              ),
              centerTitle: true,
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Consumer<TasksData>(
                builder: (context, tasksData, child) {
                  return ListView.builder(
                    itemCount: tasksData.tasks.length,
                    itemBuilder: (context, index) {
                      Task task = tasksData.tasks[index];
                      return TaskTile(task: task, tasksData: tasksData);
                    },
                  );
                },
              ),
            ),
            floatingActionButton: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        autofocus: true,
                        onChanged: (val) {
                          taskTitle = val;
                        },
                        decoration: InputDecoration(
                          hintText: 'Add a new todo items',
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.green,
                    child: const Icon(Icons.add, color: Colors.white),
                    onPressed: () {
                      if (taskTitle.isNotEmpty) {
                        Provider.of<TasksData>(
                          context,
                          listen: false,
                        ).addTask(taskTitle);
                      }
                    },
                  ),
                ],
              ),
            ),
          );
  }
}
