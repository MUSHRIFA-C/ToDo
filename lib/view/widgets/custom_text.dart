import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/utilities/constants.dart';

class CustomText extends StatelessWidget {
  CustomText({
    this.text,
    this.value,
    Key? key}) : super(key: key);
  String? text;
  String? value;
  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            children:[
              TextSpan(text: text,style: TextStyle(color: Constants.primaryColor,fontWeight: FontWeight.bold)),
              TextSpan(text:value??'not Given')
            ]));
  }
}
