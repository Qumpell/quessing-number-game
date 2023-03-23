import 'package:flutter/material.dart';
import 'answers.dart';

class listView extends StatefulWidget {
  List<Answer> answers = <Answer>[];
  listView({super.key, required this.answers});

  @override
  State<listView> createState() => _listViewState();
}

class _listViewState extends State<listView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          //reverse: true,
          itemCount: widget.answers.length,
          itemBuilder: (context, index) {
            return Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: ListTile(
                  title: Text(
                    widget.answers[index].number,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  trailing: Text(widget.answers[index].description),
                ),
              ),
            );
          }),
    );
  }
}
