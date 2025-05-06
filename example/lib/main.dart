import 'package:flutter/material.dart';
import 'package:flux/flux.dart';

void main() async {
  await Flux.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: Flux.config.theme,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FluxTitlebar(
        title: FluxTabSwitcher(
          tabs: const [
            FluxTab(title: 'Home', icon: Icons.home_rounded),
            FluxTab(title: 'Installed', icon: Icons.apps_rounded),
          ],
          selectedTab: 0,
          onTabChanged: (index) {},
        ),
        following: [
          FluxMenu(
            items: [
              FluxMenuItem(
                title: 'Settings',
                onClick: () {},
              ),
              FluxMenuItem(
                title: 'About',
                onClick: () {},
              ),
            ],
          )
        ],
        leading: [
          FluxTitlebarButton(
            icon: Icons.arrow_back_rounded,
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text('Item $index'),
              trailing: FilledButton(
                onPressed: () {},
                child: const Text('Button'),
              ),
            ),
          );
        },
      ),
    );
  }
}
