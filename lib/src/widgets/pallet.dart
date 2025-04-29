import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flux/flux.dart';

class FluxPallet extends StatefulWidget {
  final String title;
  final Widget inputBoxLeading;
  final String placeholder;
  final TextEditingController controller;
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final Widget? trailing;

  const FluxPallet({
    super.key,
    required this.controller,
    required this.title,
    required this.inputBoxLeading,
    required this.placeholder,
    required this.itemCount,
    required this.itemBuilder,
    this.trailing,
  });

  @override
  State<FluxPallet> createState() => _FluxPalletState();
}

class _FluxPalletState extends State<FluxPallet> {
  final focusNode = FocusNode(
    onKeyEvent: (node, event) {
      if (event is KeyUpEvent) {
        if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
          node.nextFocus();
          return KeyEventResult.handled;
        }
      }
      return KeyEventResult.ignored;
    },
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.topCenter,
      insetPadding: const EdgeInsets.only(top: 60),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: SizedBox(
          width: context.breakpoint(SM),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                autofocus: true,
                controller: widget.controller,
                focusNode: focusNode,
                decoration: InputDecoration(
                  labelText: widget.title,
                  hintText: widget.placeholder,
                  prefixIcon: widget.inputBoxLeading,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(),
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(top: 8.0),
                itemCount: widget.itemCount,
                itemBuilder: widget.itemBuilder,
              ),
              if (widget.trailing != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: widget.trailing!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class FluxPalletItem extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const FluxPalletItem({
    super.key,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}
