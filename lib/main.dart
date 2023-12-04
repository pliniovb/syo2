import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/repositories/favoritas_repository.dart';
import 'package:flutter_application_1/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'meu_aplicativo.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(
            create: (context) => FavoritasRepository(
                  auth: context.read<AuthService>(),
                )),
      ],
      child: const MeuAplicativo(),
    ),
  );
}
