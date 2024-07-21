import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/services/MedicalDetailsService.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../entity/MedicalDetailDTO.dart';
import '../util/custom_text_fields.dart';
import  'package:firebase_auth/firebase_auth.dart' as auth;

class MedicalHistoryScreen extends StatefulWidget {
  const MedicalHistoryScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MedicalHistoryScreenWidget();
  }
}

class _MedicalHistoryScreenWidget extends State<MedicalHistoryScreen> {


  late MedicalDetailService medicalDetailService;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  bool _isSmoker = false;
  bool _hasDiabetes = false;
  String _selectedGender = 'Male';
  String _selectedBloodType = 'A+';


  MedicalDetailDTO medicalDetail = MedicalDetailDTO(
    uid: '',
    name: '',
    age: 0,
    hasDiabetes: false,
    smoker: false,
    location: '',
    gender: 'Male',
    bloodType: 'A+',
  );


  void _submitForm() {
    var firebaseUser = auth.FirebaseAuth.instance.currentUser;
    if(firebaseUser==null){
      notify("User Not found, please login");
      return;
    }
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Update the medicalDetail instance with form data
      setState(() {
        medicalDetail = MedicalDetailDTO(
          uid: firebaseUser!.uid,
          name: _nameController.text,
          age: int.parse(_ageController.text),
          hasDiabetes: _hasDiabetes,
          smoker: _isSmoker,
          location: _locationController.text,
          gender: _selectedGender,
          bloodType: _selectedBloodType,
        );
      });
      medicalDetailService.submit(medicalDetail);
    }
  }


  @override
  void initState(){
    super.initState();
    medicalDetailService = MedicalDetailService();
  }
  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey, width: 2.0),
                    ),
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Icon(Icons.account_box_outlined),
                    suffixIcon: Icon(Icons.check_box_outlined),
                    hintText: 'John Doe',
                    labelText: 'Name',
                  ),
                  controller: _nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _ageController,
                  decoration: InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your age';
                    }
                    return null;
                  },
                ),
                // CustomTextField(
                //   controller: _ageController,
                //   prefixIcon: const Icon(
                //     Icons.numbers,
                //     color: themeColorDarkest,
                //   ),
                // ),

                const SizedBox(height: 20),
                TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(labelText: 'Location'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your location';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Text('Gender'),
                DropdownButtonFormField<String>(
                  value: _selectedGender,
                  items: ['Male', 'Female', 'Other']
                      .map((label) => DropdownMenuItem(
                    child: Text(label),
                    value: label,
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Text('Blood Type'),
                DropdownButtonFormField<String>(
                  value: _selectedBloodType,
                  items: ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']
                      .map((label) => DropdownMenuItem(
                    child: Text(label),
                    value: label,
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedBloodType = value!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                CheckboxListTile(
                  title: Text('Smoker'),
                  value: _isSmoker,
                  onChanged: (bool? value) {
                    setState(() {
                      _isSmoker = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text('Diabetes'),
                  value: _hasDiabetes,
                  onChanged: (bool? value) {
                    setState(() {
                      _hasDiabetes = value!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),

    );
  }
}

void notify(String s) {
  print(s);
}
