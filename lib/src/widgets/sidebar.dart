import 'package:flutter/material.dart';
import 'package:flux/flux.dart';

class FluxSidebar extends StatelessWidget {
  final double width;
  final List<Widget> children;
  const FluxSidebar({
    super.key,
    this.width = 250,
    this.children = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      color: context.theme.appBarTheme.backgroundColor,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              child: ListView(
                children: [
                  for (var child in children)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: child,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FluxSidebarItem extends StatelessWidget {
  final String title;
  final IconData? icon;
  final VoidCallback? onClick;
  final bool selected;

  const FluxSidebarItem({
    super.key,
    required this.title,
    this.icon,
    this.onClick,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: selected
            ? context.theme.colorScheme.primary.withOpacity(0.1)
            : Colors.transparent,
      ),
      onPressed: () {
        onClick?.call();
        FluxScaffold.maybeOf(context)?.closeSidebar();
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            if (icon != null)
              Icon(
                icon,
                color: context.theme.textTheme.titleMedium?.color,
                size: 18,
              ),
            if (icon != null) const SizedBox(width: 10.0),
            Text(
              title,
              style: context.theme.textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
