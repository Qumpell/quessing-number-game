import 'dart:math';

import 'package:flutter/material.dart';
import 'expenses.dart';
import 'answers.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

int randomNumberInRange(int min, int max) {
  return min + Random().nextInt(max - min);
}

int number = randomNumberInRange(1, 2);

int startGame(List<Answer> ans) {
  int number = randomNumberInRange(1, 100);
  ans.clear();
  return number;
}

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _numberController = TextEditingController();
  final List<Expense> expenses = [
    Expense(id: '1', title: 'Kino', cost: 65.23, date: DateTime.now()),
    Expense(id: '2', title: 'Bilard', cost: 86.23, date: DateTime.now()),
    Expense(id: '3', title: 'Bilard', cost: 286.23, date: DateTime.now()),
  ];

  List<Answer> answers = <Answer>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Demo Home Page'),
        ),
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.end,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _numberController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Your guess',
                    ),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      print('Add');
                      print(_numberController.text);
                      String desc;
                      int numberGiven = int.parse(_numberController.text);
                      if (number < numberGiven) {
                        desc = "Too much";
                      } else if (number > numberGiven) {
                        desc = "Too few";
                      } else {
                        desc = "BINGO";
                        number = startGame(answers);
                      }
                      setState(() {
                        answers.add(Answer(
                          number: _numberController.text,
                          description: desc,
                          date: DateTime.now(),
                        ));
                      });

                      _numberController.clear();
                    },
                    child: Text('Take a guess'),
                  ),
                ),
              ],
            )),
            Card(
              elevation: 6,
              child: Container(
                color: Colors.yellow,
                width: double.infinity,
                child: const Text('Wykres'),
              ),
            ),
            ...answers.map((e) {
              return Card(
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                          width: 2,
                        ),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        '${e.number}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            DateFormat('yyyy-MM-dd').format(e.date),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(e.description),
                        ),
                      ],
                    )
                  ],
                ),
              );
            })
          ],
        ));
  }
}
