import 'package:flutter/material.dart';

class ButtonViewPage extends StatelessWidget {
  const ButtonViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView(
        children: [
          Card(
            child: ListTile(
              title: const Text('Button'),
              trailing: FilledButton(
                onPressed: () {},
                child: const Text('Button'),
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Outlined Button'),
              trailing: OutlinedButton(
                onPressed: () {},
                child: const Text('Button'),
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Text Button'),
              trailing: TextButton(
                onPressed: () {},
                child: const Text('Button'),
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Icon Button'),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
