
import 'dart:ui';

class FluxMenuItem {
  final String title;
  final VoidCallback? onClick;

  const FluxMenuItem({
    required this.title,
    this.onClick,
  });
}
