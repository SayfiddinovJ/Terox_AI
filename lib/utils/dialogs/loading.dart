import 'package:flutter/material.dart';

void showLoading({required BuildContext context}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    },
  );
}

void hideLoading({required BuildContext? context}) async {
  if (context != null) Navigator.pop(context);
}
