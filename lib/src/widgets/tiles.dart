import 'package:flutter/material.dart';
import 'package:flux/flux.dart';

class FluxTile extends StatelessWidget {
  final String title;
  final Widget? following;
  final VoidCallback? onClick;

  const FluxTile({
    super.key,
    required this.title,
    this.following,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity.comfortable,
      title: Text(title),
      trailing: following,
      onTap: onClick,
    );
  }
}

class FluxTileGroup extends StatelessWidget {
  final List<Widget> children;
  const FluxTileGroup({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: context.theme.scaffoldBackgroundColor,
      child: Column(
        children: [
          for (int i = 0; i < children.length; i++) ...[
            children[i],
            if (i != children.length - 1)
              const Divider(
                height: 0,
                thickness: 0.09,
              ),
          ],
        ],
      ),
    );
  }
}
