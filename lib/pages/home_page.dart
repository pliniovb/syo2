import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/configuracoes_page.dart';
import 'package:flutter_application_1/pages/favoritas_page.dart';
import 'package:flutter_application_1/pages/roupas_page.dart';
import 'package:flutter_application_1/pages/post_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int paginaAtual = 0;
  late PageController pc;

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: paginaAtual);
  }

  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        onPageChanged: setPaginaAtual,
        children: const [
          RoupasPage(),
          FavoritasPage(),
          ConfiguracoesPage(),
          PostPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: paginaAtual,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Todas'),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favoritas'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Conta'),
            BottomNavigationBarItem(icon: Icon(Icons.post_add), label: 'Posts'),
          ],
          onTap: (pagina) {
            pc.animateToPage(pagina,
                duration: const Duration(milliseconds: 400),
                curve: Curves.ease);
          }),
    );
  }
}
