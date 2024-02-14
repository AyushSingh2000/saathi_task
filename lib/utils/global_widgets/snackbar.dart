import 'package:flutter/material.dart';

class Message {
  static snackbar(BuildContext context,String e){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(e,) ));
  }
}