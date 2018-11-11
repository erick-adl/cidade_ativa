import 'package:cidade_ativa/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:cidade_ativa/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState(controller);

  final PageController controller;
  SignInScreen(this.controller);
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final PageController controller;
  _SignInScreenState(this.controller);

  final bool isReleaseMode = bool.fromEnvironment('dart.vm.product');

  @override
  void initState() {
    super.initState();
    if (!isReleaseMode) {
      _emailController.text = "erick.adlima@gmail.com";
      _passController.text = "12345678";
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: goBack,
      child: Scaffold(
          key: _scaffoldKey,
          body: Stack(children: <Widget>[
            Image.asset(
              "assets/images/backgroud.png",
              fit: BoxFit.fill,
              width: 2000.0,
            ),
            Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.fill,
              width: 2000.0,
            ),
            ScopedModelDescendant<UserModel>(
              builder: (context, child, model) {
                if (model.isLoading)
                  return Center(
                    child: CircularProgressIndicator(),
                  );

                return Form(
                  key: _formKey,
                  child: ListView(
                    padding: EdgeInsets.fromLTRB(16.0, 280.0, 16.0, 16.0),
                    children: <Widget>[
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
                      Align(
                        alignment: Alignment.centerRight,
                        child: FlatButton(
                          onPressed: () {
                            if (_emailController.text.isEmpty)
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content:
                                    Text("Insira seu e-mail para recuperação!"),
                                backgroundColor: Colors.redAccent,
                                duration: Duration(seconds: 2),
                              ));
                            else {
                              model.recoverPass(_emailController.text);
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text("Confira seu e-mail!"),
                                backgroundColor: Theme.of(context).primaryColor,
                                duration: Duration(seconds: 3),
                              ));
                            }
                          },
                          child: Text(
                            "Esqueci minha senha",
                            textAlign: TextAlign.right,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      SizedBox(
                        height: 44.0,
                        child: RaisedButton(
                          child: Text(
                            "Entrar",
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                          textColor: Colors.white,
                          color: Theme.of(context).primaryColor,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              model.signIn(
                                  email: _emailController.text,
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
            )
          ])),
    );
  }

  void _onSuccess() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
        
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content:
          Text("Falha ao Entrar. Verifique email e senha e tente novamente"),
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
