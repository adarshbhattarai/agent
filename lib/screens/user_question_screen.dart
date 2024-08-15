
import 'package:flutter/widgets.dart';

import '../entity/MedicalDetailDTO.dart';

class UserQuestionScreen extends StatefulWidget {

  final MedicalDetailDTO medicalDetailDTO;
  static String id = 'dental_question_answer_bot';
  const UserQuestionScreen({ Key? key, required this.medicalDetailDTO }) : super(key:key);

  @override
  _UserQuestionScreenState createState() => _UserQuestionScreenState();
}

class _UserQuestionScreenState extends  State<UserQuestionScreen>{

  @override
  Widget build(BuildContext context) {

    print(widget.medicalDetailDTO.name);
    print(widget.medicalDetailDTO.age);
    print(widget.medicalDetailDTO.hasDiabetes);
    print(widget.medicalDetailDTO.location);
    // TODO: implement build
    throw UnimplementedError();
  }
}