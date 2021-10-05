import 'package:flutter/material.dart';
import 'app/login/login.dart';
import 'app/home/home.dart';

void main() {
	runApp(
		MaterialApp(
				title: 'Flutter Tutorial',
				home: FormLogin(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/login': (context) => FormLogin(),
          '/home': (context) => Home(),
        }
		),
	);
}