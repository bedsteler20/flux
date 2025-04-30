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
    return SizedBox(
      width: context.width,
      height: context.height,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: SizedBox(
          width: 340,
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FluxButton(
                      text: confirmText,
                      width: 130,
                      fontSize: 18.0,
                      backgroundColor: confirmButtonColor,
                      textColor: confirmTextColor,
                      edgeInsets: const EdgeInsets.symmetric(
                        horizontal: 36.0,
                        vertical: 10.0,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        onResult(true);
                      },
                    ),
                    const SizedBox(width: 12.0),
                    FluxButton(
                      text: cancelText,
                      width: 130,
                      backgroundColor: cancelButtonColor,
                      textColor: cancelTextColor,
                      fontSize: 18.0,
                      edgeInsets: const EdgeInsets.symmetric(
                        horizontal: 36.0,
                        vertical: 10.0,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        onResult(false);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
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

class FluxButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsets edgeInsets;
  final double? fontSize;
  final double? width;

  const FluxButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.edgeInsets =
        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    this.fontSize,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final fontSize = this.fontSize ?? 16.0;
    final textColor = this.textColor ?? context.colorScheme.onSurface;
    final backgroundColor =
        this.backgroundColor ?? context.theme.scaffoldBackgroundColor;
    return InkWell(
      borderRadius: BorderRadius.circular(8.0),
      onTap: onPressed,
      child: Container(
        padding: edgeInsets,
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
