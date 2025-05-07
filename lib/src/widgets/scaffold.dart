import 'package:flutter/material.dart';
import 'package:flux/flux.dart';

class FluxScaffold extends StatefulWidget {
  final double mobileThreshold;
  final FluxSidebar? sideBar;
  final Widget child;
  final List<Widget> titlebarLeading;
  final List<Widget> titlebarFollowing;
  final Widget? titlebarTitle;
  final int selectedTab;
  final Function(int)? onTabSelected;
  final List<FluxTab>? tabs;
  final bool showTabSwitcher;

  const FluxScaffold({
    super.key,
    required this.child,
    this.sideBar,
    this.mobileThreshold = 768.0,
    this.titlebarLeading = const [],
    this.titlebarFollowing = const [],
    this.titlebarTitle,
    this.selectedTab = 0,
    this.onTabSelected,
    this.tabs,
    this.showTabSwitcher = true,
  });

  @override
  State<FluxScaffold> createState() => _FluxScaffoldState();
}

class _FluxScaffoldState extends State<FluxScaffold>
    with SingleTickerProviderStateMixin {
  bool isSmall = false;
  bool isSidebarOpen = false;
  bool canDrag = false;
  double screenWidth = 0.0;

  late final AnimationController animationController = AnimationController(
    duration: const Duration(milliseconds: 100),
    vsync: this,
  );

  late final Animation animation = CurvedAnimation(
    parent: animationController,
    curve: Curves.easeInOutQuad,
  );

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final mediaQuery = MediaQuery.of(context);
    if (screenWidth == mediaQuery.size.width) {
      return;
    }
    setState(() {
      screenWidth = mediaQuery.size.width;
      isSmall = mediaQuery.size.width < widget.mobileThreshold;
      isSidebarOpen = false;
      canDrag = false;
    });
  }

  void toggleSidebar() {
    if (isSidebarOpen) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
    setState(() => isSidebarOpen = !isSidebarOpen);
  }

  void onDragStart(DragStartDetails details) {
    final closed = animationController.isDismissed;
    final open = animationController.isCompleted;
    setState(() {
      canDrag = (closed && details.localPosition.dx < 60) || open;
    });
  }

  void onDragUpdate(DragUpdateDetails details) {
    if (!canDrag) return;
    animationController.value +=
        (details.primaryDelta ?? 0.0) / widget.sideBar!.width;
  }

  void dragCloseDrawer(DragUpdateDetails details) {
    final delta = details.primaryDelta ?? 0.0;
    if (delta < 0) {
      setState(() {
        isSidebarOpen = false;
      });
      animationController.reverse();
    }
  }

  void onDragEnd(DragEndDetails details) async {
    const minFlingVelocity = 365;
    if (details.velocity.pixelsPerSecond.dx.abs() >= minFlingVelocity) {
      final visualVelocity =
          details.velocity.pixelsPerSecond.dx / widget.sideBar!.width;

      await animationController.fling(velocity: visualVelocity);
      setState(() => isSidebarOpen = animationController.isCompleted);
    } else {
      if (animationController.value < 0.5) {
        animationController.reverse();
        setState(() => isSidebarOpen = false);
      } else {
        animationController.forward();
        setState(() => isSidebarOpen = true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final shouldShowTabSwitcher = widget.tabs != null &&
        widget.showTabSwitcher &&
        widget.titlebarTitle == null;

    return Scaffold(
      appBar: FluxTitlebar(
        title: shouldShowTabSwitcher
            ? context.isScreenSize(SM)
                ? FluxTabSwitcher(
                    tabs: widget.tabs!,
                    selectedTab: widget.selectedTab,
                    onTabChanged: (e) => widget.onTabSelected?.call(e),
                  )
                : null
            : widget.titlebarTitle,
        showDivider: widget.sideBar != null,
        leading: [
          FluxTitlebarButton(
            icon: Icons.menu_rounded,
            onPressed: toggleSidebar,
          ),
          ...widget.titlebarLeading,
        ],
      ),
      bottomNavigationBar: shouldShowTabSwitcher
          ? !context.isScreenSize(SM)
              ? BottomNavigationBar(
                  currentIndex: widget.selectedTab,
                  onTap: (index) => widget.onTabSelected?.call(index),
                  items: widget.tabs!.map((e) {
                    return BottomNavigationBarItem(
                      icon: Icon(e.icon),
                      label: e.title,
                    );
                  }).toList(),
                )
              : null
          : null,
      body: AnimatedBuilder(
        animation: animation,
        builder: (context, _) {
          if (widget.sideBar == null) {
            return Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: widget.child,
                  ),
                )
              ],
            );
          }

          if (isSmall) {
            return Stack(
              children: [
                GestureDetector(
                  onHorizontalDragStart: onDragStart,
                  onHorizontalDragUpdate: onDragUpdate,
                  onHorizontalDragEnd: onDragEnd,
                ),
                widget.child,
                if (animation.value > 0)
                  Container(
                    color:
                        Colors.black.withAlpha((150 * animation.value).toInt()),
                  ),
                if (animation.value == 1)
                  GestureDetector(
                    onTap: toggleSidebar,
                    onHorizontalDragUpdate: dragCloseDrawer,
                  ),
                ClipRRect(
                  child: SizedOverflowBox(
                    size: Size(
                      (widget.sideBar?.width ?? 1.0) * animation.value,
                      double.infinity,
                    ),
                    child: widget.sideBar,
                  ),
                )
              ],
            );
          }

          return Row(
            children: [
              if (widget.sideBar != null)
                ClipRect(
                  child: SizedOverflowBox(
                    size: Size(
                      (widget.sideBar?.width ?? 1.0) * animation.value,
                      double.infinity,
                    ),
                    child: widget.sideBar,
                  ),
                ),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: widget.child,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
