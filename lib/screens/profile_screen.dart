import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'fitness_app_theme.dart';

class ProfileScreen extends StatelessWidget{

  AnimationController? animationController;

  ProfileScreen({this.animationController});

  @override
  Widget build(BuildContext context) {
    var animation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: animationController!,
            curve: const Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    return Container(
              color: FitnessAppTheme.background,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Stack(
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
              ),
            )

    );
  }

}