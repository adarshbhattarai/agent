class MedicalDetailDTO {
  String uid;
  String name;
  int age;
  bool hasDiabetes;
  bool smoker;
  String location;
  String gender;
  String bloodType;

  MedicalDetailDTO({
    required this.uid,
    required this.name,
    required this.age,
    required this.hasDiabetes,
    required this.smoker,
    required this.location,
    required this.gender,
    required this.bloodType,
  });
}