import 'package:cidade_ativa/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:cidade_ativa/data.dart';
import 'package:cidade_ativa/intro_page_item.dart';
import 'package:cidade_ativa/page_transformer.dart';

class IntroPageView extends StatelessWidget {

  final _pageController = PageController(viewportFraction: 0.95);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(        
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0.0,
        flexibleSpace: FlexibleSpaceBar(
          title: const Text("Cidade Ativa", style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
      ),
      drawer: CustomDrawer(_pageController),       
      body: Center(
        child: SizedBox.fromSize(
          size: const Size.fromHeight(500.0),
          child: PageTransformer(
            pageViewBuilder: (context, visibilityResolver) {
              return PageView.builder(
                controller: _pageController,
                itemCount: sampleItems.length,
                itemBuilder: (context, index) {
                  final item = sampleItems[index];
                  final pageVisibility =
                      visibilityResolver.resolvePageVisibility(index);

                  return IntroPageItem(
                    item: item,
                    pageVisibility: pageVisibility,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
