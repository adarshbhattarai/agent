import 'package:e_thela_dental_bot/home/ai_thela_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/authentication_bloc.dart';
import '../constants/palette.dart';
import '../screens/home_screen.dart';
import 'favorite_page.dart';
import 'generator_page.dart';


class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = AIPage();
        //page = GeneratorPage();
        break;
      case 1:

        BlocProvider.of<AuthenticationBloc>(context)
            .add(SignOut());
        page = GeneratorPage();
        //page = FavoritesPage();
        break;
      case 2:
        page = FavoritesPage();
        break;
      case 3:
        page = AIPage();
        break;
      case 4:
        page = HomeScreen();
        break;
      case 5:
        page = FavoritesPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    // The container for the current page, with its background color
    // and subtle switching animation.
    var mainArea = ColoredBox(
      color: colorScheme.surfaceVariant,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: page,
      ),
    );

    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 1050) {
            // Use a more mobile-friendly layout with BottomNavigationBar
            // on narrow screens.
            return Column(
              children: [
                Expanded(child: mainArea),
                SafeArea(
                  child: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.smart_toy_outlined),
                        label: 'AI',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.logout),
                        label: 'Logout',
                      ),
                      // BottomNavigationBarItem(
                      //   icon: Icon(Icons.home),
                      //   label: 'Home',
                      // ),
                      // BottomNavigationBarItem(
                      //   icon: Icon(Icons.favorite),
                      //   label: 'Favorites',
                      // ),
                      // BottomNavigationBarItem(
                      //   icon: Icon(Icons.school),
                      //   label: 'Learn',
                      // ),
                      // BottomNavigationBarItem(
                      //   icon: Icon(Icons.smart_toy_outlined),
                      //   label: 'AI',
                      // ),
                      // BottomNavigationBarItem(
                      //   icon: Icon(Icons.shop),
                      //   label: 'Shop',
                      // ),
                      // BottomNavigationBarItem(
                      //   icon: Icon(Icons.shopping_cart_checkout_sharp),
                      //   label: 'Checkout',
                      // ),
                    ],
                    currentIndex: selectedIndex,
                    onTap: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                  ),
                )
              ],
            );
          } else {
            return Row(
              children: [
                SafeArea(
                  child: NavigationRail(
                    minWidth: 100,
                    extended: constraints.maxWidth >= 600,
                    selectedLabelTextStyle: TextStyle(
                        color: Colors.lightBlue[500]
                    ),
                    unselectedLabelTextStyle: TextStyle(
                      color: Colors.grey[500]
                    ),
                    destinations: [
                      NavigationRailDestination(
                        icon: Icon(Icons.home),
                        label: Text('Home'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.favorite),
                        label: Text('Favorites'),
                      ), NavigationRailDestination(
                        icon: Icon(Icons.school),
                        label: Text('Learn'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.smart_toy_outlined),
                        label:  Text('AI'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.shop),
                        label:  Text('Shop'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.shopping_cart_checkout_sharp),
                        label:  Text('Checkout'),
                      ),
                    ],
                    selectedIndex: selectedIndex,
                    elevation: 5,
                    useIndicator: true,
                    backgroundColor: Colors.grey[50],
                    indicatorColor: Colors.cyan[50],
                    onDestinationSelected: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                  ),
                ),
                Expanded(child: mainArea),
              ],
            );
          }
        },
      ),
    );
  }
}