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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
          FluxTitlebarButton(
            icon: Icons.more_vert_rounded,
            onPressed: () {},
          ),
        ],
        leading: [
          FluxTitlebarButton(
            icon: Icons.arrow_back_rounded,
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          for (var i = 0; i < 100; i++)
            Card(
              child: ListTile(
                title: Text('Item $i'),
                trailing: FilledButton(
                  onPressed: () {},
                  child: const Text('Button'),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
