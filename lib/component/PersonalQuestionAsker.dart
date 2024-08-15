


import 'package:cloud_functions/cloud_functions.dart';
import 'package:e_thela_dental_bot/constants/palette.dart';
import 'package:e_thela_dental_bot/models/api_response.dart';
import 'package:e_thela_dental_bot/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../entity/MedicalDetailDTO.dart';

class PersonalQuestionAsker extends StatefulWidget{
  late MedicalDetailDTO medicalDetailDTO;

  PersonalQuestionAsker({required this.medicalDetailDTO, super.key});


  @override
  State<StatefulWidget> createState() {
    return _PersonalQuestionAsker();
  }
}

class _PersonalQuestionAsker extends State<PersonalQuestionAsker>{
  ApiService get apiService => GetIt.I<ApiService>();
  bool _isLoading =false;

  final List<Map<String, String>> _messages = [];
  final TextEditingController _textController = TextEditingController();


  _fetchData() async{
    setState(() {
      _isLoading=true;
      _messages.add({"role": "user", "text": _textController.text});
    });
    if (_textController.text.isNotEmpty) {
      var _apiresponse = await apiService.askUserQuestion(
          _textController.text
      );
      setState(() {
        _messages.add({"role": "agent", "text": _apiresponse.data});
      });
      _textController.clear();
    }

    setState(() {
      _isLoading=false;
    });
  }
  Future<void> _sendMessage() async {

    _fetchData();
  }

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
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(8.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[_messages.length - 1 - index];
                final isUser = message['role'] == 'user';
                if(_isLoading && index==_messages.length - 1) return Center(child: CircularProgressIndicator()) ;
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
                          controller: _textController,
                          decoration: InputDecoration(
                              hintText: "Ask your question",
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
}

