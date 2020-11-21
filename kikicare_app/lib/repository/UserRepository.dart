import 'package:kikicare_app/model/User.dart';
import 'package:kikicare_app/util/constants.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserRepository
{
  Future<User> login(email, password) async
  {
    try {
      var response = await http.get(Uri.encodeFull(host + "/login?email="+email+"&password="+password),
          headers: {"Content-Type": "application/json"});
      print(json.decode(response.body));
      return User.fromMap(json.decode(response.body));
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<User> getUser(email) async
  {
    try {
      var response = await http.get(Uri.encodeFull(host + "/getUser?email="+email),
          headers: {"Content-Type": "application/json"});
      print(json.decode(response.body));
      return User.fromMap(json.decode(response.body));
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<User> signup(first_name, last_name, email, password, num_tel, adress, url_image, mode_cnx) async
  {
    try {
      var response = await http.get(Uri.encodeFull(host + "/signup?first_name="+first_name+"&last_name="+last_name+"&email="+email+"&password="+password+"&num_tel="+num_tel+"&adress="+adress+"&url_image="+url_image+"&mode_cnx="+mode_cnx),
          headers: {"Content-Type": "application/json"});
      User u = User(email: email, first_name: first_name, last_name: last_name, password: password, num_tel: num_tel, adress: adress, url_image: url_image, mode_cnx: mode_cnx);
      print(u);
      return u;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }




}
