import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Agentsearchbarwidget extends StatefulWidget{

  const Agentsearchbarwidget({super.key});

  @override
  State<StatefulWidget> createState() =>_AgentSearchBarWidget();
}

class _AgentSearchBarWidget  extends State<Agentsearchbarwidget>{

  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: 'initial text');
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: CupertinoSearchTextField(
        controller: textController,
        placeholder: 'Search',
      ),

      )
    );
  }
}