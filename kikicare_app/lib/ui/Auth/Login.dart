import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:kikicare_app/model/User.dart';
import 'package:kikicare_app/repository/UserRepository.dart';
import 'package:kikicare_app/ui/Home/Home.dart';
import 'package:kikicare_app/util/bubble_indication_painter.dart';
import 'package:kikicare_app/util/constants.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget
{
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final FocusNode myFocusNodeEmailLogin = FocusNode();
  final FocusNode myFocusNodePasswordLogin = FocusNode();

  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();

  bool _obscureTextLogin = true;

  final FocusNode myFocusNodePasswordRegister = FocusNode();
  final FocusNode myFocusNodeEmailRegister = FocusNode();
  final FocusNode myFocusNodeFirstNameRegister = FocusNode();
  final FocusNode myFocusNodeLastNameRegister = FocusNode();
  final FocusNode myFocusNodeAddressRegister = FocusNode();
  final FocusNode myFocusNodePhoneNumberRegister = FocusNode();
  final FocusNode myFocusNodeConfirmPasswordRegister = FocusNode();

  TextEditingController signupEmailController = new TextEditingController();
  TextEditingController signupFirstNameController = new TextEditingController();
  TextEditingController signupLastNameController = new TextEditingController();
  TextEditingController signupAddressController = new TextEditingController();
  TextEditingController signupPhoneNumberController = new TextEditingController();
  TextEditingController signupPasswordController = new TextEditingController();
  TextEditingController signupConfirmPasswordController = new TextEditingController();

  bool emailValid(String email){
    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    return !regExp.hasMatch(email);
  }

  bool _obscureTextSignup = true;

  PageController _pageController;


  List<Color> colors = [Color(0x99F3D617),Color(0xFFF9429E)];
  int _index = 0;

  set isLoggedIn(bool isLoggedIn) {}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowGlow();
          },
          child: Container(
            decoration: BoxDecoration(gradient: LinearGradient(colors: colors,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),

            child: Center(
              child: SingleChildScrollView(
                child: Column(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[

                  Image.asset('assets/img/kiki.png',width: 220,),

                  Tabs(context),

                  AnimatedCrossFade(

                    duration: Duration(milliseconds: 150),
                    firstChild: Login(context),
                    secondChild: SignUp(context),
                    crossFadeState: _index == 0 ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                  )

                ],),
              ),
            ),
          ),
        )
    );
  }


  // ignore: non_constant_identifier_names
  Widget Login(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:30.0,left: 15,right: 15),
      child: Column(
        children: <Widget>[
          Stack(
              overflow: Overflow.visible,
              alignment: Alignment.bottomCenter,
              children:<Widget>[
                Container(
                  decoration: BoxDecoration(color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top:10.0,left: 15,right: 15,bottom: 20),
                    child: Column(children: <Widget>[

                      TextField(
                          focusNode: myFocusNodeEmailLogin,
                          controller: loginEmailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email,color: Colors.grey,),
                          labelText: "Enter Your Email",
                          labelStyle: TextStyle(color: Colors.black87),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent))

                      ),),

                      Divider(color: Colors.grey,height: 8),

                      TextField(
                          focusNode: myFocusNodePasswordLogin,
                          controller: loginPasswordController,
                          obscureText: _obscureTextLogin,
                          decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock,color: Colors.grey,),
                          labelText: "Password",
                          labelStyle: TextStyle(color: Colors.black87),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent))

                      ),),

                      Divider(color: Colors.transparent,height: 20,)
                    ],),
                  ),
                ),

                Positioned(
                  top: 150,
                  child: Center(
                    child: GestureDetector(
                      child: Container(
                        width: MediaQuery.of(context).size.width - 100,
                        decoration: BoxDecoration(gradient: LinearGradient(colors: colors,),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: MaterialButton(
                            child: Padding(
                                padding: const EdgeInsets.symmetric(vertical:12.0),
                                child: Center(
                                  child: Text(
                                  "LOGIN",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),)),
                            ),
                            onPressed: () async {
                              Future.delayed(Duration(seconds: 1), () async {
                                if(!emailValid(loginEmailController.text)){
                                  var user = await UserRepository().login(
                                      loginEmailController.text,
                                      loginPasswordController.text);
                                  if (user != null) {
                                    //showInSnackBar("Welcome " + user.first_name);
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return HomeScreen(user);
                                        },
                                      ),
                                    );
                                  } else {
                                    _scaffoldKey.currentState.showSnackBar(
                                        SnackBar(
                                          content: Text("Email or password incorrect"),
                                          backgroundColor: Color(0x99F3D617),
                                        )
                                    );
                                  }
                                }else {
                                  _scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                        content: Text("Email invalid"),
                                        backgroundColor: Color(0x99F3D617),
                                      )
                                  );
                                }

                              });
                            }
                        ),
                      ),
                    ),
                  ),
                ),

              ]
          ),

          Padding(
            padding: const EdgeInsets.only(top:45.0),
            child: GestureDetector(
              child: Center(child: Text("Forget Password?",style: TextStyle(color: Colors.white,fontSize: 16),)),

              onTap: (){},
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top:20.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[

              Container(width: 55,height: 1,color: Colors.white,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal:15.0),
                child: Text("Or",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
              ),

              Container(width: 55,height: 1,color: Colors.white,),

            ],),
          ),


          Padding(
            padding: const EdgeInsets.only(top:25.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[

              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(color: Colors.white,
                      shape: BoxShape.circle),

                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Image.asset('assets/img/google.png'),
                  ),
                ),

                onTap: (){},
              ),

              Container(width: 55,),

              GestureDetector(

                onTap: ()
                {
                  _loginWithFB();
                },
                child: Container(
                  decoration: BoxDecoration(color: Colors.white,
                      shape: BoxShape.circle),

                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Image.asset('assets/img/fb.png'),
                  ),
                ),



              ),
            ],),
          ),
        ],
      ),
    );
  }


  // ignore: non_constant_identifier_names
  Widget SignUp(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:30.0,left: 15,right: 15),
      child: Column(
        children: <Widget>[
          Stack(
              overflow: Overflow.visible,
              alignment: Alignment.bottomCenter,
              children:<Widget>[
                Container(
                  decoration: BoxDecoration(color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top:10.0,left: 15,right: 15,bottom: 20),
                    child: Column(children: <Widget>[

                      TextField(
                        focusNode: myFocusNodeEmailRegister,
                        controller: signupEmailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email,color: Colors.grey,),
                            labelText: "Email",
                            labelStyle: TextStyle(color: Colors.black87),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent))

                        ),),

                      Divider(color: Colors.grey,height: 8),

                      TextField(
                        focusNode: myFocusNodeFirstNameRegister,
                        controller: signupFirstNameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock,color: Colors.grey,),
                            labelText: "First Name",
                            labelStyle: TextStyle(color: Colors.black87),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent))

                        ),),

                      Divider(color: Colors.grey,height: 8),

                      TextField(
                        focusNode: myFocusNodeLastNameRegister,
                        controller: signupLastNameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock,color: Colors.grey,),
                            labelText: "Last Name",
                            labelStyle: TextStyle(color: Colors.black87),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent))

                        ),),

                      Divider(color: Colors.grey,height: 8),

                      TextField(
                        focusNode: myFocusNodeAddressRegister,
                        controller: signupAddressController,
                        keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock,color: Colors.grey,),
                            labelText: "Address",
                            labelStyle: TextStyle(color: Colors.black87),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent))

                        ),),

                      Divider(color: Colors.grey,height: 8),

                      TextField(
                        focusNode: myFocusNodePhoneNumberRegister,
                        controller: signupPhoneNumberController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock,color: Colors.grey,),
                            labelText: "Phone Number",
                            labelStyle: TextStyle(color: Colors.black87),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent))

                        ),),

                      TextField(
                        focusNode: myFocusNodePasswordRegister,
                        controller: signupPasswordController,
                        obscureText: _obscureTextSignup,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock,color: Colors.grey,),
                            labelText: "Password",
                            labelStyle: TextStyle(color: Colors.black87),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent))

                        ),),

                      Divider(color: Colors.grey,height: 8),

                      TextField(
                        focusNode: myFocusNodeConfirmPasswordRegister,
                        controller: signupConfirmPasswordController,
                        obscureText: _obscureTextSignup,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock,color: Colors.grey,),
                            labelText: "Confirm Password",
                            labelStyle: TextStyle(color: Colors.black87),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent))

                        ),),

                      Divider(color: Colors.transparent,height: 20,)
                    ],),
                  ),
                ),

                Positioned(
                  top: 480,
                  child: Center(
                    child: GestureDetector(
                      child: Container(
                        width: MediaQuery.of(context).size.width - 100,
                        decoration: BoxDecoration(gradient: LinearGradient(colors: colors,),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: MaterialButton(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical:12.0),
                              child: Center(
                                  child: Text(
                                    "SIGNUP",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),)),
                            ),
                            onPressed: () async {
                              Future.delayed(Duration(seconds: 1), () async {
                                if(emailValid(signupEmailController.text)){
                                  _scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                        content: Text("Invalid Email"),
                                        backgroundColor: Color(0x99F3D617),
                                      )
                                  );
                                  return;
                                }else if(signupFirstNameController.text==""){
                                  _scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                        content: Text("Invalid First Name"),
                                        backgroundColor: Color(0x99F3D617),
                                      )
                                  );
                                  return;
                                }else if(signupLastNameController.text==""){
                                  _scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                        content: Text("Invalid Last Name"),
                                        backgroundColor: Color(0x99F3D617),
                                      )
                                  );
                                  return;
                                }else if(signupAddressController.text==""){
                                  _scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                        content: Text("Invalid Address"),
                                        backgroundColor: Color(0x99F3D617),
                                      )
                                  );
                                  return;
                                }else if(signupPhoneNumberController.text=="" || signupPhoneNumberController.text.length < 8){
                                  _scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                        content: Text("Invalid Phone Number"),
                                        backgroundColor: Color(0x99F3D617),
                                      )
                                  );
                                  return;
                                }else if(signupPasswordController.text=="" || signupPasswordController.text.length < 8 || signupPasswordController.text!=signupConfirmPasswordController.text){
                                  _scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                        content: Text("Invalid Password"),
                                        backgroundColor: Color(0x99F3D617),
                                      )
                                  );
                                  return;
                                }else {
                                  var u = await UserRepository().getUser(signupEmailController.text);
                                  if(u == null){
                                    var user = await UserRepository().signup(
                                      signupFirstNameController.text,
                                      signupLastNameController.text,
                                      signupEmailController.text,
                                      signupPasswordController.text,
                                      signupPhoneNumberController.text,
                                      signupAddressController.text,
                                      "",
                                      "EMAIL",
                                    );
                                    if (user != null) {
                                      //showInSnackBar("Welcome " + user.first_name);
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return HomeScreen(user);
                                          },
                                        ),
                                      );
                                    }
                                  }else {
                                    _scaffoldKey.currentState.showSnackBar(
                                        SnackBar(
                                          content: Text("User existes"),
                                          backgroundColor: Color(0x99F3D617),
                                        )
                                    );
                                  }
                                }
                              });
                            }
                        ),
                      ),
                    ),
                  ),
                ),

              ]
          ),


          Padding(
            padding: const EdgeInsets.only(top:40.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[

              Container(width: 55,height: 1,color: Colors.white,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal:15.0),
                child: Text("Or",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
              ),

              Container(width: 55,height: 1,color: Colors.white,),

            ],),
          ),


          Padding(
            padding: const EdgeInsets.only(top:25.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[

              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(color: Colors.white,
                      shape: BoxShape.circle),

                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Image.asset('assets/img/google.png'),
                  ),
                ),

                onTap: (){},
              ),

              Container(width: 55,),

              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(color: Colors.white,
                      shape: BoxShape.circle),

                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Image.asset('assets/img/fb.png'),
                  ),
                ),

                onTap: (){},
              ),
            ],),
          ),
        ],
      ),
    );
  }

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
    ));
  }

  // ignore: non_constant_identifier_names
  Widget Tabs(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:30.0,left: 15,right: 15),
      child: Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.12),
            borderRadius: BorderRadius.circular(25),
          ),
          child:
          Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[

            Expanded(
              child: GestureDetector(
                child: Container(
                    decoration: BoxDecoration(color: _index == 0 ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(25)
                    ),
                    child: Center(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Existing",style: TextStyle(color: _index == 0 ? Colors.black : Colors.white,fontSize: 18,fontWeight: _index == 0 ? FontWeight.bold : FontWeight.normal),),
                    ))
                ),
                onTap: (){

                  setState(() {
                    _index = 0;
                  });
                },
              ),
            ),

            Expanded(
              child: GestureDetector(
                child: Container(
                    decoration: BoxDecoration(color: _index == 1 ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(25)
                    ),
                    child: Center(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("New",style: TextStyle(color: _index == 1 ? Colors.black : Colors.white,fontSize: 18,fontWeight:  _index == 1 ? FontWeight.bold : FontWeight.normal),),
                    ))),

                onTap: (){

                  setState(() {
                    _index = 1;
                  });
                },
              ),
            )
          ],)
      ),
    );
  }

  final fbLogin = FacebookLogin();
  _loginWithFB() async {
    final result = await fbLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profile = json.decode(graphResponse.body);
        String email = '${profile['email']}';
        String picture = '${profile['picture']['data']['url']}';
        String name = '${profile['name']}';
        print(email);
        print(picture);
        print(name);
        User u = new User(email: email, url_image: picture, first_name: name);

        //pass your token and other information to your back end
        setState(() {
        // create "bool _isLoggedIn = false;"
          // a bool variable to get the user is logged in or not
          var userProfile = profile;
          //create Map userProfile; to get the user details
          isLoggedIn = true;

          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(u)));
        });
        break;

      case FacebookLoginStatus.cancelledByUser:
        setState(() => isLoggedIn = false);
        break;
      case FacebookLoginStatus.error:
        setState(() => isLoggedIn = false);
        break;
    }
  }

}