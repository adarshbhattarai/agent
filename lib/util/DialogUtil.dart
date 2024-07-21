import 'package:flutter/material.dart';

abstract class DialogUtil {
  static bool _isRegisterPage = false;
  static openLoginPopup(BuildContext context, {bool dismissible = true, bool isRegister = false}) {
    showDialog(
        context: context,
        barrierDismissible: dismissible,
        builder: (context) => WillPopScope(
          onWillPop: () async => dismissible,
          child: Dialog(
              insetPadding: const EdgeInsets.all(10),
              backgroundColor: Colors.transparent,
              child: Container(
                height: 100,
                width: double.infinity,
                color: Colors.amber,
                child: Text(_isRegisterPage ? "Register Page": "Login Page"),
              )
          ),
        ));
  }
}