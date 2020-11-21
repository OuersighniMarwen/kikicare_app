import 'dart:convert';

class User
{
    int id_user;
    String first_name;
    String last_name;
    String email;
    String password;
    String num_tel;
    String adress;
    String url_image;
    String mode_cnx;

    User({this.id_user, this.first_name, this.last_name, this.email, this.password,
      this.num_tel, this.adress, this.url_image, this.mode_cnx,});

  @override
    String toString()
    {
      return 'User{id_user: $id_user, first_name: $first_name, last_name: $last_name, email: $email, password: $password, num_tel: $num_tel, adress: $adress, url_image: $url_image, mode_cnx: $mode_cnx}';
    }

    Map<String, dynamic> toMap()
    {
      return {
          'id_user' : id_user,
          'first_name' : first_name,
          'last_name' : last_name,
          'email' : email,
          'password' : password,
          'num_tel' : num_tel,
          'adress' : adress,
          'url_image' : url_image,
          'mode_cnx' : mode_cnx,
      };
    }

    factory User.fromMap(Map<String, dynamic> map)
    {
      if (map == null)
        {return null;}
      else{
      return User(
        id_user: map['id_user'],
        first_name: map['first_name'],
        last_name: map['last_name'],
        email: map['email'],
        password: map['password'],
        num_tel: map['num_tel'],
        adress: map['adress'],
        url_image: map['url_image'],
        mode_cnx: map['mode_cnx'],
      );}
    }


    factory User.fromMapSignup(Map<String, dynamic> map)
    {
      if (map == null) return null;

      return User(
        first_name: map['first_name'],
        last_name: map['last_name'],
        email: map['email'],
        password: map['password'],
        num_tel: map['num_tel'],
        adress: map['adress'],
        url_image: map['url_image'],
        mode_cnx: map['mode_cnx'],
      );
    }

    static User fromFacebook(json)
    {
      return User(
          first_name: json['first_name'],
          last_name: json['last_name'],
          email: json['email'],
          password: '');
    }

    String toJson() => json.encode(toMap());

    factory User.fromJson(String source) => User.fromMapSignup(json.decode(source));

    @override
    bool operator ==(Object o)
    {
      if (identical(this, o)) return true;

      return o is User &&
          o.first_name == first_name &&
          o.last_name == last_name &&
          o.email == email &&
          o.password == password &&
          o.num_tel == num_tel &&
          o.adress == adress &&
          o.url_image == url_image &&
          o.mode_cnx == mode_cnx;
    }

    @override
  int get hashCode => first_name.hashCode ^ last_name.hashCode ^ email.hashCode ^ password.hashCode ^ num_tel.hashCode ^ adress.hashCode ^ url_image.hashCode ^ mode_cnx.hashCode ;
}