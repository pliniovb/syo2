import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/auth_check.dart';

class MeuAplicativo extends StatelessWidget {
  const MeuAplicativo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SYO",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      home: const AuthCheck(),
    );
  }
}
