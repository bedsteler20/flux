import 'package:flutter/material.dart';
import 'package:flux/flux.dart';

class FluxConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final Function(bool) onResult;

  final String confirmText;
  final Color? confirmButtonColor;
  final Color? confirmTextColor;

  final String cancelText;
  final Color? cancelButtonColor;
  final Color? cancelTextColor;

  const FluxConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmText = 'OK',
    this.confirmButtonColor,
    this.confirmTextColor,
    this.cancelText = 'Cancel',
    this.cancelButtonColor,
    this.cancelTextColor,
    required this.onResult,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: context.textTheme.headlineLarge?.copyWith(
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(message),
            const SizedBox(height: 24.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 16.0,
              children: [
                FilledButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    onResult(true);
                  },
                  style: context.theme.filledButtonTheme.style?.copyWith(
                    backgroundColor: confirmButtonColor != null
                        ? WidgetStateProperty.all(confirmButtonColor)
                        : WidgetStateProperty.all(
                            context.theme.scaffoldBackgroundColor),
                  ),
                  child: Container(
                    constraints: const BoxConstraints(
                      minWidth: 70,
                      maxHeight: 45,
                    ),
                    child: Center(
                      child: Text(
                        confirmText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color:
                              confirmTextColor ?? context.colorScheme.onSurface,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                FilledButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    onResult(false);
                  },
                  style: context.theme.filledButtonTheme.style?.copyWith(
                    backgroundColor: cancelButtonColor != null
                        ? WidgetStateProperty.all(cancelButtonColor)
                        : WidgetStateProperty.all(
                            context.theme.scaffoldBackgroundColor),
                  ),
                  child: Container(
                    constraints: const BoxConstraints(
                      minWidth: 70,
                      maxHeight: 45,
                    ),
                    child: Center(
                      child: Text(
                        cancelText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color:
                              cancelTextColor ?? context.colorScheme.onSurface,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static void show({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = 'OK',
    Color? confirmButtonColor,
    Color? confirmTextColor,
    String cancelText = 'Cancel',
    Color? cancelButtonColor,
    Color? cancelTextColor,
    required Function(bool) onResult,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return FluxConfirmDialog(
          title: title,
          message: message,
          confirmText: confirmText,
          confirmButtonColor: confirmButtonColor,
          confirmTextColor: confirmTextColor,
          cancelText: cancelText,
          cancelButtonColor: cancelButtonColor,
          cancelTextColor: cancelTextColor,
          onResult: onResult,
        );
      },
    );
  }
}
