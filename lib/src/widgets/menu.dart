import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flux/flux.dart';

class FluxMenuItem {
  final String title;
  final VoidCallback? onClick;

  const FluxMenuItem({
    required this.title,
    this.onClick,
  });
}

class FluxMenu extends StatelessWidget {
  final List<FluxMenuItem> items;

  const FluxMenu({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      builder: (context, controller, child) {
        return FluxTitlebarButton(
          icon: Icons.more_vert_rounded,
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
        );
      },
      menuChildren: [
        for (var item in items)
          MenuItemButton(
            onPressed: item.onClick,
            child: Text(item.title),
          ),
      ],
    );
  }
}
