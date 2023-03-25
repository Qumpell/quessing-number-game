import 'dart:math';

import 'package:flutter/material.dart';
import 'list_tile.dart';
import 'answers.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

int randomNumberInRange(int min, int max) {
  return min + Random().nextInt(max - min);
}

int number = randomNumberInRange(1, 100);
bool endOfGame = false;
bool textFieldEnabled = true;

int resetGameState(List<Answer> ans) {
  ans.clear();
  endOfGame = false;
  return randomNumberInRange(1, 100);
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
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

  List<Answer> answers = <Answer>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Guess number game'),
        ),
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.end,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (!endOfGame) ...{
              Card(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _numberController,
                      decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Your guess'),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: Text('Take a guess'),
                      onPressed: () {
                        if (_numberController.text.isNotEmpty) {
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
                            endOfGame = true;
                          }
                          setState(() {
                            answers.add(Answer(
                              number: _numberController.text,
                              description: desc,
                              date: DateTime.now(),
                            ));
                          });

                          _numberController.clear();
                        }
                      },
                    ),
                  ),
                ],
              )),
            },
            Card(
              elevation: 6,
              child: Container(
                  color: Colors.blueAccent,
                  width: double.infinity,
                  child: const Text(
                    'Answers',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                    textAlign: TextAlign.center,
                  )),
            ),
            if (endOfGame) ...{
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    number = resetGameState(answers);
                  });
                  //listView(answers: answers);
                },
                child: Text("Restart game"),
              )
            },
            listView(answers: answers.reversed.toList()),
            // ...answers.map((e) {

            //   return listTile();
            // })
          ],
        ));
  }
}
