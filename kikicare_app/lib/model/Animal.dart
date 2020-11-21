import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:kikicare_app/ui/Home/MyAnimals.dart';
import 'package:kikicare_app/util/constants.dart';


class AnimalList extends StatefulWidget {
  @override
  _AnimalListState createState() => _AnimalListState();
}

class _AnimalListState extends State<AnimalList>
{
  List<Animal> animals =[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    http.get(host+"/getAllAnimals")
        .then((http.Response response){
      List<dynamic>AnimalsFromServer = json.decode(response.body);
      for(int i=0; i<AnimalsFromServer.length;i++){
        Map<String,dynamic> animalJ  = AnimalsFromServer[i]; //Chaque bloc JSON est un animal de type Map
        print(animalJ['nom']);
        print(animalJ['status']);
        setState(() {
          animals.add(Animal(animalJ['id_user'],animalJ['nom'],animalJ['date_naissance'],animalJ['url_image'],animalJ['status'],animalJ['famille'],animalJ['race']));
        });
        //Alimenter mon dataSource (animals)
      }
      print(">>>>>>> "+animals.length.toString());
    });

  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Animals"),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return MyAnimals(
              animals[index].nom, animals[index].date_naissance, animals[index].url_image);
        },
        itemCount: animals.length,
      ),
    );
  }

}

class Animal
{
  int id_animal;
  int id_user;
  String nom;
  String date_naissance;
  String url_image;
  String status;
  String famille;
  String race;

  Animal( this.id_user, this.nom, this.date_naissance,
      this.url_image, this.status, this.famille, this.race);

  @override
  String toString()
  {
    return 'Animal{id_animal: $id_animal, id_user: $id_user, nom: $nom, date_naissance: $date_naissance, url_image: $url_image, status: $status, famille: $famille, race: $race}';
  }

}
