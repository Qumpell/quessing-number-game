import 'package:flutter/material.dart';
import 'answers.dart';

class listView extends StatefulWidget {
  List<Answer> answers = <Answer>[];
  listView({super.key, required this.answers});

  @override
  State<listView> createState() => _ListViewState();
}

class _ListViewState extends State<listView> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          //reverse: true,
          itemCount: widget.answers.length,
          itemBuilder: (context, index) {
            return Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: DecoratedBox(
                  decoration: BoxDecoration(border: Border.all(color: const Color.fromARGB(100, 44, 66, 200))),
                  child: ListTile(
                    title: Text(
                      widget.answers[index].number,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    trailing: Text(widget.answers[index].description,
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 25,
                        ),
                        textAlign: TextAlign.center),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
