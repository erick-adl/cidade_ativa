import 'package:cidade_ativa/screens/login/login_screen.dart';
import 'package:cidade_ativa/tabs/login_screen_1.dart';
import 'package:flutter/material.dart';
import 'package:cidade_ativa/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: MaterialApp(
          title: "Cidade Ativa",
          theme: ThemeData(
              primarySwatch: Colors.blue,
              primaryColor: Color.fromARGB(255, 0, 191, 214)),
          debugShowCheckedModeBanner: false,
          home:  LoginScreen()),          
          
    );
  }
}
