import 'package:flutter/material.dart';

import '../widgets/main_card.dart';
import '../widgets/main_card_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = -1;
  bool light1 = true;
  int selectedSegment = 0;

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
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 900,
                ),
                child: Wrap(
                  children: [
                    for (int i = 0; i < 10; i++) selectedSegment == 0 ? const MainCard() : const MainCardList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onItemTapped(int index) => setState(() {
        selectedIndex = index;
      });
}
