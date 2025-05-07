import 'package:example/button_view_page.dart';
import 'package:example/list_view_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flux/flux.dart';

class MyHomePage extends HookWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedView = useState(0);
    final selectedTab = useState(0);
    return FluxScaffold(
      selectedTab: selectedTab.value,
      onTabSelected: (index) => selectedTab.value = index,
      tabs: const [
        FluxTab(
          title: 'Hose',
          icon: Icons.home_rounded,
        ),
        FluxTab(
          title: 'Stuff',
          icon: Icons.apps_rounded,
        ),
      ],
      titlebarFollowing: [
        FluxMenu(
          items: [
            FluxMenuItem(
              title: 'Settings',
              onClick: () {},
            ),
            FluxMenuItem(
              title: 'About',
              onClick: () {},
            ),
          ],
        ),
      ],
      titlebarLeading: [
        FluxTitlebarButton(
          icon: Icons.arrow_back_rounded,
          onPressed: () {},
        ),
      ],
      sideBar: FluxSidebar(
        children: [
          FluxSidebarItem(
            title: "List View",
            icon: Icons.home,
            selected: selectedView.value == 0,
            onClick: () => selectedView.value = 0,
          ),
          FluxSidebarItem(
            title: "Button View",
            icon: Icons.apps,
            selected: selectedView.value == 1,
            onClick: () => selectedView.value = 1,
          ),
        ],
      ),
      child: switch (selectedView.value) {
        0 => const ListViewPage(),
        1 => const ButtonViewPage(),
        _ => const Center(
            child: Text("Unknown View"),
          ),
      },
    );
  }
}
