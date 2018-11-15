import 'package:cidade_ativa/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:cidade_ativa/models/user_model.dart';
import 'package:cidade_ativa/tiles/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {
  final PageController pageController;

  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color.fromARGB(255, 150, 236, 241), Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
        );

    return Padding(
      padding: EdgeInsets.only(top: 25.0),
      child: SizedBox(
          width: 250.0,
          child: Drawer(
            child: Stack(
              children: <Widget>[
                _buildDrawerBack(),
                ListView(
                  padding: EdgeInsets.only(left: 32.0, top: 16.0),
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 8.0),
                      padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                      height: 160.0,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 1.0,
                            left: 0.0,
                            child: Image(
                              image: AssetImage("assets/images/logo.png"),
                              fit: BoxFit.fitWidth,
                              width: 150.0,
                            ),
                          ),
                          Positioned(
                              left: 0.0,
                              bottom: 0.0,
                              child: ScopedModelDescendant<UserModel>(
                                builder: (context, child, model) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Olá, ${!model.isLoggedIn() ? "" : model.userData["name"]}",
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      InkWell(
                                        child: Text(
                                          "Sair",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onTap: () {
                                          _exit(context);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              ))
                        ],
                      ),
                    ),
                    Divider(),
                    DrawerTile(Icons.home, "Início", pageController, 0),
                    DrawerTile(Icons.list, "Outros", pageController, 1),
                    // DrawerTile(Icons.location_on, "Lojas", pageController, 2),
                    // DrawerTile(
                    //     Icons.playlist_add_check, "Meus Pedidos", pageController, 3),
                  ],
                )
              ],
            ),
          )),
    );
  }

  _exit(BuildContext context) {
    AlertDialog ad = new AlertDialog(
      content: Container(
          height: 200.0,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100.0)),
          child: ScopedModelDescendant<UserModel>(
            builder: (contex, child, model) {
              return Column(
                children: <Widget>[
                  ClipOval(
                    child: new Image.network(model.firebaseUser.photoUrl,
                        width: 50.0, height: 50.0),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Deseja fazer logoff?",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      RaisedButton(
                          child: Text(
                            "Sim",
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                          textColor: Colors.white,
                          color: Theme.of(context).primaryColor,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          onPressed: () {
                            model.signOut(context);
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          }),
                      RaisedButton(
                          child: Text(
                            "Não",
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                          textColor: Colors.white,
                          color: Theme.of(context).primaryColor,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ],
                  )
                ],
              );
            },
          )),
    );

    showDialog(context: context, child: ad);
  }
}
