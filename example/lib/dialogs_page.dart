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
                    icon: FlutterLogo(size: 128),
                    info: FluxAboutInfo(
                      appName: 'Flux Example',
                      appDescription: 'An example application using Flux.',
                      links: [
                        ("GitHub", "https://github.com/bedsteler20/flux")
                      ],
                      credits: [
                        ("Programers", ["Bedsteler20"]),
                        ("Designers", ["Bedsteler20"]),
                      ],
                    ),
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
