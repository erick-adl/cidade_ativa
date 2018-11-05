import 'package:cidade_ativa/widgets/new_picture_button.dart';
import 'package:flutter/material.dart';
import 'package:cidade_ativa/tabs/home_tab.dart';
import 'package:cidade_ativa/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController), 
          floatingActionButton: NewPictureButton(),
        ),
      ],
    );
  }
}
