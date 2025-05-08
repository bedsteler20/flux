import 'package:flutter/material.dart';
import 'package:flux/flux.dart';
import 'package:flux/src/utils.dart';

class FluxTitlebar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(48);
  const FluxTitlebar({
    super.key,
    this.leading = const [],
    this.following = const [],
    this.title,
    this.showDivider = false,
  });

  final List<Widget> leading;
  final List<Widget> following;

  final Widget? title;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (_) => Flux.yaruWindow.drag(),
      onSecondaryTap: () => Flux.yaruWindow.showMenu(),
      onDoubleTap: () {
        Flux.yaruWindow.maximizeOrRestore();
      },
      child: AppBar(
        titleSpacing: 0,
        surfaceTintColor: Colors.transparent,
        bottom: showDivider
            ? PreferredSize(
                preferredSize: const Size.fromHeight(2),
                child: Divider(
                  height: 2,
                  thickness: 2,
                  color: context.theme.colorScheme.onPrimaryContainer,
                ),
              )
            : null,
        title: SizedBox(
          height: 48,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: leading,
                    ),
                  ),
                ),
                if (title != null)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: title!,
                    ),
                  ),
                Positioned(
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        ...following,
                        FluxWindowControls(
                          controls: const [
                            FluxWindowControlType.minimize,
                            FluxWindowControlType.maximize,
                            FluxWindowControlType.close,
                          ],
                          onClose: () => Flux.yaruWindow.close(),
                          onMinimize: () => Flux.yaruWindow.minimize(),
                          onMaximize: () => Flux.yaruWindow.maximizeOrRestore(),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FluxTitlebarButton extends StatelessWidget {
  const FluxTitlebarButton({
    super.key,
    this.onPressed,
    required this.icon,
  });

  final void Function()? onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onPressed,
        onDoubleTap: () {},
        hoverColor:
            Theme.of(context).colorScheme.surfaceContainer.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
        highlightColor: Colors.white.withOpacity(0.1),
        splashColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Icon(
            icon,
            size: 20,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}

class FluxDialogTitlebar extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(48);
  const FluxDialogTitlebar({
    super.key,
    this.leading = const [],
    this.following = const [],
    this.onClose,
    this.title,
  });

  final bool showBackButton = true;
  final List<Widget> leading;
  final List<Widget> following;

  final VoidCallback? onClose;
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (_) => Flux.yaruWindow.drag(),
      onSecondaryTap: () => Flux.yaruWindow.showMenu(),
      onDoubleTap: () {
        Flux.yaruWindow.maximizeOrRestore();
      },
      child: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        leading: null,
        title: SizedBox(
          height: 48,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: leading,
                    ),
                  ),
                ),
                if (title != null)
                  Positioned(
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: title!,
                    ),
                  ),
                Positioned(
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        ...following,
                        FluxWindowControls(
                          controls: const [
                            FluxWindowControlType.close,
                          ],
                          onClose: () => onClose?.call(),
                          onMinimize: () => Flux.yaruWindow.minimize(),
                          onMaximize: () => Flux.yaruWindow.maximizeOrRestore(),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
