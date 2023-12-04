import 'package:flutter/material.dart';
import 'package:flutter_application_1/repositories/favoritas_repository.dart';
import 'package:flutter_application_1/widgets/roupa_card.dart';
import 'package:provider/provider.dart';

class FavoritasPage extends StatefulWidget {
  const FavoritasPage({super.key});

  @override
  State<FavoritasPage> createState() => _FavoritasPageState();
}

class _FavoritasPageState extends State<FavoritasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Roupas Favoritas'),
      ),
      body: Container(
        color: Colors.indigo.withOpacity(0.05),
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(12.0),
        child:
            Consumer<FavoritasRepository>(builder: (context, favoritas, child) {
          return favoritas.lista.isEmpty
              ? const ListTile(
                  leading: Icon(Icons.star),
                  title: Text('Ainda não há roupas favoritas'),
                )
              : ListView.builder(
                  itemCount: favoritas.lista.length,
                  itemBuilder: (_, index) {
                    return RoupaCard(roupa: favoritas.lista[index]);
                  });
        }),
      ),
    );
  }
}
