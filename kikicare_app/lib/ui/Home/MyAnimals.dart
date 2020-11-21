import 'package:flutter/material.dart';
import 'package:kikicare_app/util/constants.dart';
import 'package:provider/provider.dart';
import 'package:kikicare_app/model/User.dart';


class MyAnimals extends StatelessWidget
{
  String image;
  String nom;
  String date_naissance;

  MyAnimals(this.image, this.nom, this.date_naissance);

  @override
  Widget build(BuildContext context)
  {
    return Card(
        child: InkWell(
          onTap:() {

          },
          child: Row(
            children: [
              Image.network(
                image,
                height: 100,
                width: 100,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(nom), Text(date_naissance)],
                ),
              )
            ],
          ),
        )
    );
  }
}