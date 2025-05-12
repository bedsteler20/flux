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
  final bool alwaysShowSidebarButton;

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
    this.alwaysShowSidebarButton = false,
  });

  @override
  State<FluxScaffold> createState() => FluxScaffoldState();

  static FluxScaffoldState of(BuildContext context) {
    final state = context.findAncestorStateOfType<FluxScaffoldState>();
    if (state == null) {
      throw Exception('FluxScaffold not found in context');
    }
    return state;
  }

  static FluxScaffoldState? maybeOf(BuildContext context) {
    return context.findAncestorStateOfType<FluxScaffoldState>();
  }
}

class FluxScaffoldState extends State<FluxScaffold>
    with SingleTickerProviderStateMixin {
  bool _isSmall = false;
  bool _isSidebarOpen = false;
  bool _canDrag = false;
  double _screenWidth = 0.0;

  late final AnimationController _animationController = AnimationController(
    duration: const Duration(milliseconds: 100),
    vsync: this,
  );

  late final Animation _animation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeInOutQuad,
  );

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final mediaQuery = MediaQuery.of(context);
    if (_screenWidth == mediaQuery.size.width) {
      return;
    }
    setState(() {
      _screenWidth = mediaQuery.size.width;
      _isSmall = mediaQuery.size.width < widget.mobileThreshold;
      _isSidebarOpen = false;
      _canDrag = false;
    });

    if (!_isSmall &&
        _animationController.value != 1 &&
        !widget.alwaysShowSidebarButton) {
      _animationController.forward();
    } else if (_isSmall && _animationController.value != 0) {
      _animationController.reverse();
    }
  }

  void toggleSidebar() {
    if (_isSidebarOpen) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
    setState(() => _isSidebarOpen = !_isSidebarOpen);
  }

  void closeSidebar() {
    if (_isSidebarOpen && (_isSmall || !widget.alwaysShowSidebarButton)) {
      _animationController.reverse();
      setState(() => _isSidebarOpen = false);
    }
  }

  void _onDragStart(DragStartDetails details) {
    final closed = _animationController.isDismissed;
    final open = _animationController.isCompleted;
    setState(() {
      _canDrag = (closed && details.localPosition.dx < 60) || open;
    });
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (!_canDrag) return;
    _animationController.value +=
        (details.primaryDelta ?? 0.0) / widget.sideBar!.width;
  }

  void _dragCloseDrawer(DragUpdateDetails details) {
    final delta = details.primaryDelta ?? 0.0;
    if (delta < 0) {
      setState(() {
        _isSidebarOpen = false;
      });
      _animationController.reverse();
    }
  }

  void _onDragEnd(DragEndDetails details) async {
    const minFlingVelocity = 365;
    if (details.velocity.pixelsPerSecond.dx.abs() >= minFlingVelocity) {
      final visualVelocity =
          details.velocity.pixelsPerSecond.dx / widget.sideBar!.width;

      await _animationController.fling(velocity: visualVelocity);
      setState(() => _isSidebarOpen = _animationController.isCompleted);
    } else {
      if (_animationController.value < 0.5) {
        _animationController.reverse();
        setState(() => _isSidebarOpen = false);
      } else {
        _animationController.forward();
        setState(() => _isSidebarOpen = true);
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
          if ((widget.alwaysShowSidebarButton && widget.sideBar != null) ||
              (widget.sideBar != null && _isSmall))
            FluxTitlebarButton(
              icon: Icons.menu_rounded,
              onPressed: toggleSidebar,
            ),
          ...widget.titlebarLeading,
        ],
        following: widget.titlebarFollowing,
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
        animation: _animation,
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

          if (_isSmall) {
            return Stack(
              children: [
                GestureDetector(
                  onHorizontalDragStart: _onDragStart,
                  onHorizontalDragUpdate: _onDragUpdate,
                  onHorizontalDragEnd: _onDragEnd,
                ),
                widget.child,
                if (_animation.value > 0)
                  Container(
                    color: Colors.black
                        .withAlpha((150 * _animation.value).toInt()),
                  ),
                if (_animation.value == 1)
                  GestureDetector(
                    onTap: toggleSidebar,
                    onHorizontalDragUpdate: _dragCloseDrawer,
                  ),
                ClipRRect(
                  child: SizedOverflowBox(
                    size: Size(
                      (widget.sideBar?.width ?? 1.0) * _animation.value,
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
                      (widget.sideBar?.width ?? 1.0) * _animation.value,
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
