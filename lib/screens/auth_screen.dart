import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:food_vision/models/user.dart';
import 'package:food_vision/screens/fitness_app_home_screen.dart';
import 'package:food_vision/screens/fitness_app_theme.dart';
import 'package:food_vision/service/auth_view_model.dart';
import 'package:food_vision/service/food_view_model.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: FitnessAppTheme.background,
        body: LoginScreen(),
      ), //FitnessAppHomeScreen(cameras: cameras, service: service,),
    );
  }
}

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isObscure = true;
  bool _isVisible = false;

  final TapGestureRecognizer _gestureRecognizer = TapGestureRecognizer()
    ..onTap = () {
      if (kDebugMode) {
        print("Hello world from _gestureRecognizer");
      }
    };

  @override
  Widget build(BuildContext context) {
    _isVisible = Provider.of<AuthViewModel>(context).error != null;
    return SingleChildScrollView(
        reverse: true,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 200,
              width: 200,
            ),

            // Login text Widget
            Center(
              child: Container(
                height: 40,
                width: 400,
                alignment: Alignment.center,
                child: const Text(
                  "Login",
                  style: FitnessAppTheme.display1
                  // textAlign: TextAlign.center,
                ),
              ),
            ),

            const SizedBox(
              height: 60,
              width: 10,
            ),

            // Wrong Password text
            Visibility(
              visible: _isVisible,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  "Wrong credentials entered",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 10,
                  ),
                ),
              ),
            ),

            // Textfields for username and password fields
            Container(
              height: 140,
              width: 530,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    onTap: () {
                      setState(() {
                        _isVisible = false;
                      });
                    },
                    controller: usernameController, // Controller for Username
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Username",
                        contentPadding: EdgeInsets.all(20)),
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                  ),
                  const Divider(
                    thickness: 3,
                  ),
                  TextFormField(
                    onTap: () {
                      setState(() {
                        _isVisible = false;
                      });
                    },

                    controller: passwordController, // Controller for Password
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                        contentPadding: const EdgeInsets.all(20),
                        // Adding the visibility icon to toggle visibility of the password field
                        suffixIcon: IconButton(
                          icon: Icon(_isObscure
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        )),
                    obscureText: _isObscure,
                  ),
                ],
              ),
            ),

            // Submit Button
            Container(
              width: 570,
              height: 70,
              padding: EdgeInsets.only(top: 20),
              child: RaisedButton(
                  color: FitnessAppTheme.nearlyDarkBlue,
                  child: const Text("Submit", style: TextStyle(color: Colors.white)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () async {
                    var username = usernameController.value.text;
                    var password = passwordController.value.text;
                    await Provider.of<AuthViewModel>(context, listen: false).login(User(username: username, password: password));
                    await Provider.of<FoodViewModel>(context, listen: false).getAll();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => FitnessAppHomeScreen(asnyc: true,)));
                  }),
            ),

            // Register
            Container(
                padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                child: Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Dont have an account? ",
                        style: FitnessAppTheme.body2,
                        children: [
                          TextSpan(
                              text: " Register here",
                              style: const TextStyle(
                                  color: FitnessAppTheme.nearlyDarkBlue, fontWeight: FontWeight.bold),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignupPage()),
                                  )
                                }),
                        ],
                      ),
                    )))
          ],
        ));
  }
}

class SignupPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _SignupPage();
}

class _SignupPage extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: FitnessAppTheme.background,
      body: SignupPageContent(),
    );
  }
}

class SignupPageContent extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _SignupPageContent();
}

class _SignupPageContent extends State<SignupPageContent> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController1 = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
  bool _isVisible = false;
  bool _isObscure1 = true;
  bool _isObscure2 = true;
  String returnVisibilityString = "";

  bool returnVisibility(String password1, String password2, String username) {
    if (password1 != password2) {
      returnVisibilityString = "Passwords do not match";
    } else if (username == "") {
      returnVisibilityString = "Username cannot be empty";
    } else if (password1 == "" || password2 == "") {
      returnVisibilityString = "Password fields cant be empty";
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Sized Box
          const SizedBox(
            height: 37.5,
            width: 400,
          ),

          // Signup Text
          Center(
            child: Container(
              height: 245,
              width: 400,
              alignment: Alignment.center,
              child: const Text(
                "Signup",
                style: FitnessAppTheme.display1
              ),
            ),
          ),

          // Wrong password text
          Visibility(
            visible: _isVisible,
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(10),
              child: Text(
                returnVisibilityString,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 10,
                ),
              ),
            ),
          ),

          // Signup Info
          Container(
            height: 215,
            width: 530,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.white),
            child: Column(
              children: <Widget>[
                TextFormField(
                  onTap: () {
                    setState(() {
                      _isVisible = false;
                    });
                  },
                  controller: usernameController, // Controller for Username
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Username",
                      contentPadding: EdgeInsets.all(20)),
                  onEditingComplete: () => FocusScope.of(context).nextFocus(),
                ),
                const Divider(
                  thickness: 3,
                ),
                TextFormField(
                  onTap: () {
                    setState(() {
                      _isVisible = false;
                    });
                  },

                  controller: passwordController1, // Controller for Password
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Password",
                      contentPadding: const EdgeInsets.all(20),
                      // Adding the visibility icon to toggle visibility of the password field
                      suffixIcon: IconButton(
                        icon: Icon(_isObscure1
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _isObscure1 = !_isObscure1;
                          });
                        },
                      )),
                  obscureText: _isObscure1,
                ),
                const Divider(
                  thickness: 3,
                ),
                TextFormField(
                  onTap: () {
                    setState(() {
                      _isVisible = false;
                    });
                  },

                  controller: passwordController2, // Controller for Password
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Re-enter Password",
                      contentPadding: EdgeInsets.all(20),
                      // Adding the visibility icon to toggle visibility of the password field
                      suffixIcon: IconButton(
                        icon: Icon(_isObscure2
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _isObscure2 = !_isObscure2;
                          });
                        },
                      )),
                  obscureText: _isObscure2,
                ),
              ],
            ),
          ),

          // Signup Submit button
          Container(
            width: 570,
            height: 70,
            padding: EdgeInsets.only(top: 20),
            child: RaisedButton(
                color: FitnessAppTheme.nearlyDarkBlue,
                child: const Text("Submit", style: TextStyle(color: Colors.white)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onPressed: () async {

                  if (usernameController.text != "" &&
                      passwordController1.text == passwordController2.text &&
                      passwordController2.text != "") {
                    await Provider.of<AuthViewModel>(context, listen: false).register(User(username: usernameController.value.text, password: passwordController1.value.text));
                    await Provider.of<FoodViewModel>(context, listen: false).getAll();
                    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => FitnessAppHomeScreen(asnyc: true,)));
                  } else {
                    setState(() {
                      _isVisible = returnVisibility(passwordController1.text,
                          passwordController2.text, usernameController.text);
                    });
                  }
                }),
          ),
        ],
      ),
    );
  }
}