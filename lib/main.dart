import 'package:flutter/material.dart';
import 'package:treeshop/screens/home.dart';

main()=>runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData(primarySwatch: Colors.green),
      title: 'Decorative Tree Shop',
      home: Home(),
    );
  }
}
