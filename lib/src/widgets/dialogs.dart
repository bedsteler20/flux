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
                      child: SizedBox(
                        width: 65,
                        height: 45,
                        child: Center(
                          child: Text(
                            confirmText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: confirmTextColor ??
                                  context.colorScheme.onSurface,
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
                      child: SizedBox(
                        width: 65,
                        height: 45,
                        child: Center(
                          child: Text(
                            cancelText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: cancelTextColor ??
                                  context.colorScheme.onSurface,
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

class FluxDialog extends StatelessWidget {
  final Widget child;
  final double width;
  const FluxDialog({
    super.key,
    required this.child,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: context.width > context.breakpoint(SM)
          ? const EdgeInsets.symmetric(horizontal: 20.0)
          : const EdgeInsets.all(0),
      alignment: context.width > context.breakpoint(SM)
          ? Alignment.center
          : Alignment.bottomCenter,
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: width,
            child: FluxDialogTitlebar(),
          ),
          child,
        ],
      ),
    );
  }
}
