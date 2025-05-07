import 'package:flutter/material.dart';
import 'package:flux/flux.dart';
import 'package:flux/src/widgets/tiles.dart';

class FluxAboutDialog extends StatelessWidget {
  final String title;
  final String message;
  final Widget? icon;
  final List<Widget> children;

  const FluxAboutDialog({
    super.key,
    required this.title,
    required this.message,
    this.icon,
    this.children = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment:
          context.width > 400 ? Alignment.center : Alignment.bottomCenter,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      clipBehavior: Clip.antiAlias,
      insetPadding: context.width > 400
          ? const EdgeInsets.symmetric(vertical: 20)
          : const EdgeInsets.only(top: 100),
      child: Container(
        height: 600,
        constraints: const BoxConstraints(
          maxWidth: 400,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FluxDialogTitlebar(
                onClose: () {
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(height: 24),
              if (icon != null) icon!,
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                message,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: children,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
