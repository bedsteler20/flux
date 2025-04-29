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
      floatingActionButton: const MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      // Show the dialog after a delay
      showDialog(
        context: context,
        builder: (context) {
          return const MyPallet();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}

class MyPallet extends StatefulWidget {
  const MyPallet({super.key});

  @override
  State<MyPallet> createState() => _MyPalletState();
}

class _MyPalletState extends State<MyPallet> {
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return FluxPallet(
      title: 'Search',
      controller: textController,
      inputBoxLeading: const Icon(Icons.search_rounded),
      placeholder: 'Search',
      itemCount: 4,
      itemBuilder: (context, index) {
        return FluxPalletItem(
          title: 'Item $index',
          onTap: () {
            // Handle item tap
            print('Tapped on item $index');
          },
        );
      },
    );
  }
}
