import 'package:cidade_ativa/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:cidade_ativa/models/cart_model.dart';
import 'package:cidade_ativa/models/user_model.dart';
import 'package:cidade_ativa/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant<UserModel>(
          builder: (context, child, model){
            return ScopedModel<CartModel>(
              model: CartModel(model),
              child: MaterialApp(
                  title: "Flutter's Clothing",
                  theme: ThemeData(
                      primarySwatch: Colors.blue,
                      primaryColor: Color.fromARGB(255, 4, 125, 141)
                  ),
                  debugShowCheckedModeBanner: false,
                  home: LoginScreen()
              ),
            );
          }
      ),
    );
  }
}
