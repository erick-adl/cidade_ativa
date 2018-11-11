import 'package:cidade_ativa/intro_page_view.dart';
import 'package:cidade_ativa/widgets/fancy_fab.dart';
import 'package:flutter/material.dart';
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
          body: IntroPageView(),
          drawer: CustomDrawer(_pageController),
          floatingActionButton: FancyFab(),
          
          floatingActionButtonLocation:
              FloatingActionButtonLocation.endDocked,
        ),
      ],
    );
  }
}
