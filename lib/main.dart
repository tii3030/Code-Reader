import 'package:flutter/material.dart';
import 'app/view/login/login.dart';
import 'app/view/home/home.dart';

void main() {

	runApp(
		MaterialApp(
			title: 'Flutter Tutorial',
			//home: const FormLogin(),
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',

      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'login':
            builder = (BuildContext context) => const FormLogin();
            break;
          case 'home':
            builder = (BuildContext context) => const Home();
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute<void>(builder: builder, settings: settings);
      },
	  ),
  );
}