import 'package:flutter/material.dart';
import 'package:flux/src/context.dart';

class FluxTabSwitcher extends StatelessWidget {
  const FluxTabSwitcher({
    super.key,
    required this.tabs,
    required this.onTabChanged,
    required this.selectedTab,
  });

  final List<FluxTab> tabs;
  final int selectedTab;
  final void Function(int) onTabChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < tabs.length; i++) ...[
          if (i > 0 && i < tabs.length) const SizedBox(width: 12.0),
          FilledButton(
            onPressed: () => onTabChanged(i),
            style: context.theme.filledButtonTheme.style?.copyWith(
              backgroundColor: i == selectedTab
                  ? WidgetStatePropertyAll(
                      context.colorScheme.primary.withOpacity(0.2),
                    )
                  : const WidgetStatePropertyAll(Colors.transparent),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (tabs[i].icon != null) ...[
                    Icon(
                      tabs[i].icon,
                      size: 22.0,
                      color: i == selectedTab
                          ? context.colorScheme.primary
                          : context.colorScheme.onSurface,
                    ),
                    const SizedBox(width: 6.0),
                  ],
                  Text(
                    tabs[i].title,
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: i == selectedTab
                          ? context.colorScheme.primary
                          : context.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class FluxTab {
  final String title;
  final IconData? icon;

  const FluxTab({
    required this.title,
    this.icon,
  });
}
