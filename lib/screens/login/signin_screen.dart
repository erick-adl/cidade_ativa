import 'package:cidade_ativa/screens/home/home_screen.dart';
import 'package:cidade_ativa/widgets/color_loader.dart';
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
              width: 1000.0,
            ),
            ScopedModelDescendant<UserModel>(
              builder: (context, child, model) {
                if (model.isLoading)
                  return Center(
                    child: ColorLoader(),
                  );

                return Form(
                  key: _formKey,
                  child: ListView(
                    padding: EdgeInsets.fromLTRB(6.0, 30.0, 6.0, 16.0),
                    children: <Widget>[
                      Image.asset(
                        "assets/images/logo.png",
                        width: 2000.0,
                      ),
                      _buildFormFild(Icons.person_outline, 'E-mail', (text) {
                        if (text.isEmpty || !text.contains("@"))
                          return "E-mail inválido!";
                      }, _emailController, false),
                      _buildFormFild(Icons.lock_outline, 'Password', (text) {
                        if (text.isEmpty || text.length < 6)
                          return "Senha inválida!";
                      }, _passController, true),
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
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Text(                            
                              "Esqueci minha senha",
                              textAlign: TextAlign.right,
                            ),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: SizedBox(
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
                      ),
                    ],
                  ),
                );
              },
            )
          ])),
    );
  }

  Widget _buildFormFild(
      @required IconData icon,
      @required String hint,
      @required Function formFieldValidator,
      @required TextEditingController controller,
      @required bool textObcure) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Row(
        children: <Widget>[
          new Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child: Icon(
              icon,
              color: Colors.grey,
            ),
          ),
          Container(
            height: 30.0,
            width: 1.0,
            color: Colors.grey.withOpacity(0.5),
            margin: const EdgeInsets.only(left: 00.0, right: 10.0),
          ),
          new Expanded(
            child: TextFormField(
              obscureText: textObcure,
              controller: controller,
              validator: formFieldValidator,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          )
        ],
      ),
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
