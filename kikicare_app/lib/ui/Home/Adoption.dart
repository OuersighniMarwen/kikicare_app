import 'package:flutter/material.dart';
import 'package:kikicare_app/util/constants.dart';
import 'package:provider/provider.dart';
import 'package:kikicare_app/model/User.dart';



class Adoption extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Center(
          child: Container(
            alignment: Alignment.center,
            height: 300,
            width: 300,
            child: Text(
              "Adoption",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            color: Colors.cyan,
          )),
    );
  }
}