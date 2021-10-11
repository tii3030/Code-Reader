import 'package:flutter/material.dart';
import 'app/view/login/login.dart';
import 'app/view/home/home.dart';

void main() {

	runApp(
		MaterialApp(
			title: 'Flutter Tutorial',
			home: const FormLogin(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => const FormLogin(),
        '/home': (context) => const Home(),
      }
	  ),
  );
}