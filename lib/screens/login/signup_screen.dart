import 'dart:async';
import 'package:cidade_ativa/screens/login/login_screen.dart';
import 'package:cidade_ativa/widgets/color_loader.dart';
import 'package:flutter/material.dart';
import 'package:cidade_ativa/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState(controller);

  final PageController controller;
  SignUpScreen(this.controller);
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _addressController = TextEditingController();
  final _ageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final PageController controller;
  _SignUpScreenState(this.controller);

  final bool isReleaseMode = bool.fromEnvironment('dart.vm.product');

  @override
  void initState() {
    super.initState();
    if (!isReleaseMode) {
      _emailController.text = "erick.adlima@gmail.com";
      _passController.text = "12345678";
      _nameController.text = "Erick Anjos de Lima";
      _addressController.text = "Nova Espnha 77";
      _ageController.text = "28";
    }
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: goBack,
      child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title:
                Text("Dados cadastrais", style: TextStyle(color: Colors.white)),
            centerTitle: true,
          ),
          body: ScopedModelDescendant<UserModel>(
            builder: (context, child, model) {
              if (model.isLoading)
                return Center(
                  child: ColorLoader(),
                );

              return Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.fromLTRB(16.0, 50.0, 16.0, 16.0),
                  children: <Widget>[
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(hintText: "Nome Completo"),
                      validator: (text) {
                        if (text.isEmpty) return "Nome Inválido!";
                      },
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(hintText: "E-mail"),
                      keyboardType: TextInputType.emailAddress,
                      validator: (text) {
                        if (text.isEmpty || !text.contains("@"))
                          return "E-mail inválido!";
                      },
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _passController,
                      decoration: InputDecoration(hintText: "Senha"),
                      obscureText: true,
                      validator: (text) {
                        if (text.isEmpty || text.length < 6)
                          return "Senha inválida!";
                      },
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(hintText: "Endereço"),
                      validator: (text) {
                        if (text.isEmpty) return "Endereço inválido!";
                      },
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _ageController,
                      decoration: InputDecoration(hintText: "Idade"),
                      keyboardType: TextInputType.number,
                      validator: (age) {
                        if (int.parse(age) < 10 || int.parse(age) > 110)
                          return "Idade invalida";
                      },
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    SizedBox(
                      height: 44.0,
                      child: RaisedButton(
                        child: Text(
                          "Criar Conta",
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        textColor: Colors.white,
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            Map<String, dynamic> userData = {
                              "name": _nameController.text,
                              "email": _emailController.text,
                              "address": _addressController.text,
                              "age": int.parse(_ageController.text)
                            };

                            model.signUp(
                                userData: userData,
                                pass: _passController.text,
                                onSuccess: _onSuccess,
                                onFail: _onFail);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          )),
    );
  }

  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Usuário criado com sucesso!"),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 2),
    ));
    Future.delayed(Duration(seconds: 2)).then((_) {
      // Navigator.of(context).pop();
      this.controller.animateToPage(
            0,
            duration: Duration(milliseconds: 1000),
            curve: Curves.bounceOut,
          );
    });
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Falha ao criar usuário!"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }

  Future<Null> goBack() async {
    await this.controller.animateToPage(
          1,
          duration: Duration(milliseconds: 1000),
          curve: Curves.bounceOut,
        );
  }
}
