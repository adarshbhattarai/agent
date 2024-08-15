import 'package:flutter/material.dart';

import 'constants/palette.dart';
import 'home/my_home_page.dart';
import 'sample_feature/sample_item_details_view.dart';
import 'sample_feature/sample_item_list_view.dart';
import 'settings/settings_controller.dart';

import 'package:provider/provider.dart';

import 'settings/settings_view.dart';
import 'state/thela_state.dart';



class ThelaApp extends StatelessWidget {
  static String id = 'thela_app_screen';

  const ThelaApp({super.key,
  required this.settingsController});

   final SettingsController settingsController;



  @override
  Widget build(BuildContext context) {

    var appState =  ThelaState();
    return ChangeNotifierProvider(
      create: (context) => appState..loadUser(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E-thela App',
        // Providing a restorationScopeId allows the Navigator built by the
        // MaterialApp to restore the navigation stack when a user leaves and
        // returns to the app after it has been killed while running in the
        // background.
        restorationScopeId: 'app',
        // Provide the generated AppLocalizations to the MaterialApp. This
        // allows descendant Widgets to display the correct translations
        // depending on the user's locale.
        localizationsDelegates: const [
          // AppLocalizations.delegate,
          // GlobalMaterialLocalizations.delegate,
          // GlobalWidgetsLocalizations.delegate,
          // GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''), // English, no country code
        ],
        // Use AppLocalizations to configure the correct application title
        // depending on the user's locale.
        //
        // The appTitle is defined in .arb files found in the localization
        // directory.
        //onGenerateTitle: (BuildContext context) =>
        // AppLocalizations.of(context)!.appTitle,
         theme: ThemeData(
           useMaterial3: true,
           colorScheme: ColorScheme.fromSeed(seedColor:  Palette.backgroundColor,),
         ),
        darkTheme: ThemeData.dark(),
        themeMode: settingsController.themeMode,
        home: MyHomePage(),
        // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  case SampleItemDetailsView.routeName:
                    return const SampleItemDetailsView();
                  case SampleItemListView.routeName:
                  default:
                    return const SampleItemListView();
                }
              },
            );
          },

      ),
    );
  }

}
