import 'package:cloud_firestore/cloud_firestore.dart';

class MedicalDetailDTO {
  String uid;
  String name;
  int age;
  bool hasDiabetes;
  bool smoker;
  String location;
  String gender;
  String bloodType;
  String summary;

  MedicalDetailDTO({
    required this.uid,
    required this.name,
    required this.age,
    required this.hasDiabetes,
    required this.smoker,
    required this.location,
    required this.gender,
    required this.bloodType,
    required this.summary,
  });

  // Convert a User object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'age': age,
      'hasDiabetes': hasDiabetes,
      'smoker':smoker,
      'location':location,
      'gender':gender,
      'bloodType':bloodType,
      'summary':summary
    };
  }

  // Convert a Map object into a User object
  factory MedicalDetailDTO.fromMap(Map<String, dynamic> medicalData) {

    return MedicalDetailDTO(
      uid: medicalData?['uid'] ?? '',
      name: medicalData?['name'] ?? '',
      age: medicalData?['age'] ?? 0,
      hasDiabetes: medicalData?['hasDiabetes'] ?? false,
      smoker: medicalData?['smoker'] ?? false,
      location: medicalData?['location'] ?? 'None',
      gender:  medicalData?['gender'] ?? 'Unk',
      bloodType: medicalData?['bloodType'],
      summary: medicalData?['summary'] ?? ''
    );
  }
}