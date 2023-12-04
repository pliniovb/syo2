import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/roupa.dart';
import 'package:flutter_application_1/pages/foto_page.dart';
import 'package:flutter_application_1/repositories/favoritas_repository.dart';
import 'package:flutter_application_1/repositories/roupa_repository.dart';
import 'package:provider/provider.dart';

class RoupasPage extends StatefulWidget {
  const RoupasPage({super.key});

  @override
  State<RoupasPage> createState() => _RoupasPageState();
}

List<Roupa> selecionadas = [];
late FavoritasRepository favoritas;

class _RoupasPageState extends State<RoupasPage> {
  @override
  Widget build(BuildContext context) {
    favoritas = Provider.of<FavoritasRepository>(context);
    //favoritas = context.watch<FavoritasRepository>();
    final tabela = RoupaRepository.tabela;

    limparSelecionadas() {
      setState(() {
        selecionadas = [];
      });
    }

    return Scaffold(
      appBar: (selecionadas.isEmpty)
          ? AppBar(
              title: const Text('SYO'),
            )
          : AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    selecionadas = [];
                  });
                },
              ),
              title: Text('${selecionadas.length} selecionadas'),
              backgroundColor: Colors.pink[300],
              elevation: 1,
              iconTheme: const IconThemeData(color: Colors.black87),
              titleTextStyle: const TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int roupa) {
          return ListTile(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            leading: (selecionadas.contains(tabela[roupa]))
                ? const CircleAvatar(
                    child: Icon(Icons.check),
                  )
                : SizedBox(
                    width: 40,
                    child: const Icon(Icons.collections),
                  ),
            title: Row(
              children: [
                Text(
                  tabela[roupa].tipo,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 82, 47, 34),
                  ),
                ),
                if (favoritas.lista
                    .any((fav) => fav.marca == tabela[roupa].marca))
                  const Icon(Icons.circle, color: Colors.amber, size: 8),
              ],
            ),
            selected: selecionadas.contains(tabela[roupa]),
            selectedTileColor: Colors.deepPurpleAccent,
            onLongPress: () {
              setState(() {
                (selecionadas.contains(tabela[roupa]))
                    ? selecionadas.remove(tabela[roupa])
                    : selecionadas.add(tabela[roupa]);
              });
              // print(tabela[roupa].nome);
            },
            //onTap: () => mostrarDetalhes(tabela[roupa]),
          );
        },
        padding: const EdgeInsets.all(12),
        separatorBuilder: (_, __) => const Divider(),
        itemCount: tabela.length,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: (selecionadas.isNotEmpty)
          ? FloatingActionButton.extended(
              onPressed: () {
                favoritas.saveAll(selecionadas);
                limparSelecionadas();
              },
              icon: const Icon(Icons.star),
              label: const Text(
                'FAVORITAR',
                style: TextStyle(
                  letterSpacing: 0,
                  fontWeight: FontWeight.bold,
                ),
              ))
          : FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FotoPage(),
                      fullscreenDialog: true,
                    ));
              },
              icon: const Icon(Icons.camera_alt),
              label: const Text(
                'Guarde seu outfit!',
                style: TextStyle(
                  letterSpacing: 0,
                  fontWeight: FontWeight.bold,
                ),
              )),
    );
  }
}
