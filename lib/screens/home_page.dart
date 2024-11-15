import 'package:flutter/material.dart';

import '../widgets/main_card.dart';
import '../widgets/main_card_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

typedef Projetos = ({
  String nome,
  String descricao,
  String imagem,
});

class _HomePageState extends State<HomePage> {
  int selectedIndex = -1;
  bool light1 = true;
  int selectedSegment = 0;

  final projetos = <Projetos>[
    (
      nome: 'Projeto 123',
      descricao: 'Descrição do projeto 01 Descrição do projeto 01 Descrição do projeto 01 Descrição do projeto 01',
      imagem: 'images/01.jpg'
    ),
    (
      nome: 'Projeto 02',
      descricao: 'Descrição do projeto 02',
      imagem: 'images/02.jpg'
    ),
    (
      nome: 'Projeto 03',
      descricao: 'Descrição do projeto 03',
      imagem: 'images/01.jpg'
    ),
    (
      nome: 'Projeto 04',
      descricao: 'Descrição do projeto 03',
      imagem: 'images/02.jpg'
    ),
  ];

  final filtersName = <String>{
    'Programação',
    'Banco de Dados',
    'Redes',
    'Internet'
  };
  final filters = <String>{};

  @override
  Widget build(BuildContext context) {
    debugPrint('Tela Redesenhada...');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive'),
        centerTitle: true,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          const SizedBox(width: 16)
        ],
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 42,
                    child: Icon(
                      Icons.account_circle_rounded,
                      size: 64,
                    ),
                  ),
                  Text(
                    'Deriks Karlay',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: selectedIndex == 0
                  ? const Icon(Icons.check_box_outlined)
                  : const Icon(Icons.check_box_outline_blank),
              title: const Text('Home'),
              selected: selectedIndex == 0,
              onTap: () {
                // Update the state of the app
                onItemTapped(0);
                // Then close the drawer
                //Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Projetos'),
              selected: selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                onItemTapped(1);
                // Then close the drawer
                //Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Ink(
              color: Colors.grey,
              height: 100,
              width: double.maxFinite,
              child: Center(
                child: const Text(
                  'Projetos Integradores',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: filtersName.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final item = filtersName.elementAt(index);
                  return FilterChip(
                    label: Text(item),
                    selected: filters.contains(item),
                    onSelected: (value) {
                      setState(() {
                        if (value) {
                          filters.add(item);
                        } else {
                          filters.remove(item);
                        }
                      });
                    },
                  );
                },
              ),
            ),
            Row(
              children: [
                SegmentedButton<int>(
                  showSelectedIcon: false,
                  segments: const [
                    ButtonSegment(
                        value: 0,
                        label: Text('Grade'),
                        icon: Icon(Icons.grid_view_rounded)),
                    ButtonSegment(
                        value: 1,
                        label: Text('Lista'),
                        icon: Icon(Icons.dns_rounded)),
                  ],
                  selected: {selectedSegment},
                  onSelectionChanged: (newSelection) {
                    setState(() {
                      selectedSegment = newSelection.first;
                    });
                  },
                ),
              ],
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 900,
              ),
              child: Wrap(
                children: [
                  ...projetos.map((projeto) {
                    return selectedSegment == 0
                        ? MainCard(
                            name: projeto.nome,
                            description: projeto.descricao,
                            image: projeto.imagem,
                          )
                        : MainCardList(
                            name: projeto.nome,
                            description: projeto.descricao,
                            image: projeto.imagem,
                          );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onItemTapped(int index) => setState(() {
        selectedIndex = index;
      });
}
