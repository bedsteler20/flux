import 'package:flutter/material.dart';
import 'package:flux/flux.dart';

class DialogsPage extends StatelessWidget {
  const DialogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FilledButton(
            onPressed: () {
              FluxConfirmDialog.show(
                context: context,
                title: 'Confirmation',
                message: 'Are you sure you want to proceed?',
                onResult: (bool result) {},
              );
            },
            child: const Text('Show Confirmation Dialog'),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return const FluxAboutDialog(
                    title: 'Flux',
                    message: 'Flux is a Flutter UI library.',
                    icon: FlutterLogo(size: 128),
                    children: [
                      FluxTileGroup(
                        children: [
                          FluxTile(
                            title: 'Website',
                            following: Icon(Icons.open_in_new_rounded),
                          ),
                        ],
                      )
                    ],
                  );
                },
              );
            },
            child: const Text('Show About Dialog'),
          ),
        ],
      ),
    );
  }
}
