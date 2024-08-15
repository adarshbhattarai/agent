
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/palette.dart';
import '../entity/MedicalDetailDTO.dart';
import 'MedicalSummary.dart';
import 'PersonalQuestionAsker.dart';

class PersonInfoContainer extends StatefulWidget{

  final MedicalDetailDTO medicalDetailDTO;

  const PersonInfoContainer( { required this.medicalDetailDTO, super.key});

  @override
  State<StatefulWidget> createState() =>_PersonInfoContainerState();
}

class _PersonInfoContainerState extends State<PersonInfoContainer>{

  late TextEditingController personNameController;
  late TextEditingController medicalSummaryController;
  late int age;
  late bool smoker;


  @override
  void initState() {
    super.initState();
    personNameController = TextEditingController(text: widget.medicalDetailDTO.name);
    medicalSummaryController = TextEditingController(text: "Summary");
    age = widget.medicalDetailDTO.age;
    smoker = widget.medicalDetailDTO.smoker;
  }

  @override
  void dispose() {
    personNameController.dispose();
    medicalSummaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('images/pp.jpg'),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    personNameController.text,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text('Age: $age'),
                  Row(
                    children: [
                      Text('Smoker:'),
                      Checkbox(
                        value: smoker,
                        onChanged: (bool? value) {
                          setState(() {
                            smoker = value ?? false;
                          });
                        },
                      ),
                      ],
                    ),
                ],
               ),
        ],
      ),

          Divider(
            color: Palette.activeColor,  // The color of the line
            thickness: 2,        // The thickness of the line
            indent: 20,          // The left indent of the line
            endIndent: 20,       // The right indent of the line
          ),
          SizedBox(height: 10,),
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Past Summary',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,  // Optional: Set the font size
                ),
              ),
            ),
          ),
          MedicalSummary(
            description:
            widget.medicalDetailDTO.summary
          ),
          SizedBox(height:10),
          Divider(
            color: Palette.activeColor,  // The color of the line
            thickness: 2,        // The thickness of the line
            indent: 20,          // The left indent of the line
            endIndent: 20,       // The right indent of the line
          ),
          SizedBox(height:3),
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              'Need Counseling? Let\'s chat.',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16,  // Optional: Set the font size
              ),
            ),
          ),
          SizedBox(height: 3,),
          Padding(padding: EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.bottomLeft,
                  child: PersonalQuestionAsker( medicalDetailDTO:  widget.medicalDetailDTO)))
        ]
    )

    );
  }

}




/**
 *
 *
 *
    @override
    Widget build(BuildContext context) {

    return Container(
    constraints: BoxConstraints.expand(
    height: Theme.of(context).textTheme.headlineMedium!.fontSize! * 1.1 + 297.0,
    ),
    // constraints: BoxConstraints.expand(),
    padding: const EdgeInsets.all(8.0),
    color: Palette.backgroundColor,
    alignment: Alignment.bottomCenter,
    // transform: Matrix4.rotationZ(0.1),
    child: Column(
    children: [
    Expanded(
    child: _isLoading? Center(child: CircularProgressIndicator()) :ListView.builder(
    reverse: true,
    padding: const EdgeInsets.all(8.0),
    itemCount: _messages.length,
    itemBuilder: (context, index) {
    final message = _messages[_messages.length - 1 - index];
    final isUser = message['role'] == 'user';
    return Container(
    margin: const EdgeInsets.symmetric(vertical: 4.0),
    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
    child: Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
    color: isUser ? Colors.blue[100] : Colors.grey[300],
    borderRadius: BorderRadius.circular(8.0),
    ),
    child: Text(message['text'] ?? ''),
    ),
    );
    },
    ),
    ),
    Stack(
    children: <Widget>[
    Align(
    alignment: Alignment.bottomLeft,
    child: Container(
    padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
    height: 60,
    color: Colors.white,
    child: Row(
    children: <Widget>[
    GestureDetector(
    onTap: (){
    },
    child: Container(
    height: 30,
    width: 30,
    decoration: BoxDecoration(
    color:Palette.iconColor,
    borderRadius: BorderRadius.circular(30),
    ),
    child: Icon(Icons.add, color: Colors.white, size: 20, ),
    ),
    ),
    SizedBox(width: 15,),
    Expanded(
    child: TextField(
    decoration: InputDecoration(
    hintText: "Write message...",
    hintStyle: TextStyle(color: Colors.black54),
    border: InputBorder.none
    ),
    ),
    ),
    SizedBox(width: 15,),
    FloatingActionButton(
    onPressed: _sendMessage,
    child: Icon(Icons.send,color: Colors.white,size: 18,),
    backgroundColor: Palette.iconColor,
    elevation: 0,
    ),
    ],

    ),
    ),
    ),
    ],
    ),
    ],
    )
    );
    }
 */
/**
 *
 *
 *
 * Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
    children: [
    Expanded(
    child: TextField(
    controller: _textController,
    decoration: InputDecoration(
    hintText: 'Type your question...',
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    ),
    ),
    ),
    ),
    SizedBox(width: 8.0),
    IconButton(
    icon: Icon(Icons.send),
    onPressed: _sendMessage,
    ),
    ],
    ),
    ),

 */