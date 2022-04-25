import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:food_vision/screens/auth_screen.dart';
import 'package:food_vision/screens/fitness_app_theme.dart';


class ButtonView extends StatelessWidget{

  AnimationController? animationController;
  final Animation<double>? animation;

  ButtonView({this.animationController, this.animation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - animation!.value), 0.0),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 38, bottom: 16),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: FlatButton(
                          padding: EdgeInsets.zero,
                          onPressed: () async {
                            var storage = FlutterSecureStorage();
                            await storage.delete(key: "token");
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => AuthScreen()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const <Widget>[
                              Icon(Icons.logout),
                              Padding(padding: EdgeInsets.fromLTRB(26,0,0,0)),
                              Text('LOG OUT', style: FitnessAppTheme.title,),
                            ],
                          ),
                        ),
                      )
                    ),

                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
    return Stack(
            children: const <Widget>[

              ListTile(
                title: Text(
                  'Email',
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'palmeiro.leonardo@gmail.com',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Divider(),
            ],
          );
  }

}