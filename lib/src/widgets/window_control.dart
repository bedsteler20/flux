import 'package:flutter/material.dart';

enum FluxWindowControlType {
  close,
  maximize,
  minimize,
}

class FluxWindowControls extends StatelessWidget {
  final List<FluxWindowControlType> controls;
  final void Function()? onClose;
  final void Function()? onMaximize;
  final void Function()? onMinimize;

  const FluxWindowControls({
    super.key,
    this.controls = const [
      FluxWindowControlType.minimize,
      FluxWindowControlType.maximize,
      FluxWindowControlType.close,
    ],
    this.onClose,
    this.onMaximize,
    this.onMinimize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final control in controls)
          Padding(
            padding: const EdgeInsets.only(left: 6.0),
            child: FluxWindowControl(
              type: control,
              onPressed: () {
                switch (control) {
                  case FluxWindowControlType.close:
                    onClose?.call();
                    break;
                  case FluxWindowControlType.maximize:
                    onMaximize?.call();
                    break;
                  case FluxWindowControlType.minimize:
                    onMinimize?.call();
                    break;
                }
              },
            ),
          ),
      ],
    );
  }
}

class FluxWindowControl extends StatelessWidget {
  final FluxWindowControlType type;
  final void Function()? onPressed;

  const FluxWindowControl({
    super.key,
    required this.type,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 32,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onPressed,
        onDoubleTap: () {},
        hoverColor: type == FluxWindowControlType.close
            ? Theme.of(context).colorScheme.error
            : null,
        borderRadius: BorderRadius.circular(12),
        highlightColor: Colors.white.withOpacity(0.1),
        splashColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Icon(
            type == FluxWindowControlType.close
                ? Icons.close_rounded
                : type == FluxWindowControlType.maximize
                    ? Icons.crop_square_rounded
                    : Icons.minimize_rounded,
            size: 16,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
