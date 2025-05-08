import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flux/flux.dart';
import 'package:flux/src/utils.dart';
import 'package:flux/src/widgets/tiles.dart';
import 'package:url_launcher/url_launcher.dart';

class FluxAboutInfo {
  final String? appName;
  final String? appVersion;
  final String? appDescription;
  final List<(String name, List<String> people)> credits;
  final List<(String title, String url)> links;

  const FluxAboutInfo({
    this.appName,
    this.appVersion,
    this.appDescription,
    this.credits = const [],
    this.links = const [],
  });
}

class FluxAboutDialog extends StatefulWidget {
  final FluxAboutInfo info;
  final Widget? icon;

  const FluxAboutDialog({
    required this.info,
    super.key,
    this.icon,
  });

  @override
  State<FluxAboutDialog> createState() => _FluxAboutDialogState();
}

class _FluxAboutDialogState extends State<FluxAboutDialog> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  late final CallbackNavigationObserver observer;
  bool canPop = false;
  @override
  void initState() {
    super.initState();
    observer = CallbackNavigationObserver(
      onDidChangeTop: (topRoute, previousTopRoute) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            canPop = _navigatorKey.currentState?.canPop() ?? false;
          });
        });
      },
    );
  }

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FluxDialogTitlebar(
              leading: [
                if (canPop)
                  FluxTitlebarButton(
                    icon: Icons.arrow_back_rounded,
                    onPressed: () {
                      _navigatorKey.currentState?.pop();
                    },
                  ),
              ],
              onClose: () {
                Navigator.of(context).pop();
              },
            ),
            Expanded(
              child: Navigator(
                key: _navigatorKey,
                onDidRemovePage: (_) {},
                observers: [observer],
                pages: [
                  MaterialPage(
                    child: _MainPage(
                      info: widget.info,
                      icon: widget.icon,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _MainPage extends StatelessWidget {
  final FluxAboutInfo info;
  final Widget? icon;
  const _MainPage({required this.info, this.icon});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 24),
          if (icon != null) icon!,
          const SizedBox(height: 8),
          Text(
            info.appName ?? '',
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            info.appDescription ?? '',
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
              children: [
                if (info.links.isNotEmpty)
                  FluxTileGroup(children: [
                    for (final (name, url) in info.links)
                      FluxTile(
                        title: name,
                        following: const Icon(Icons.open_in_new_rounded),
                        onClick: () => launchUrl(Uri.parse(url)),
                      ),
                  ]),
                if (info.links.isNotEmpty) const SizedBox(height: 16),
                FluxTileGroup(
                  children: [
                    FluxTile(
                      title: "Credits",
                      following: const Icon(Icons.arrow_forward_rounded),
                      onClick: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => _CreditsPage(info: info),
                          ),
                        );
                      },
                    ),
                    FluxTile(
                      title: "Licenses",
                      following: const Icon(Icons.arrow_forward_rounded),
                      onClick: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const _LicensesPage(),
                          ),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _CreditsPage extends StatelessWidget {
  final FluxAboutInfo info;
  const _CreditsPage({required this.info});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final (title, people) in info.credits) ...[
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              FluxTileGroup(
                children: [
                  for (final person in people)
                    FluxTile(
                      title: person,
                    ),
                ],
              ),
              const SizedBox(height: 20),
            ]
          ],
        ),
      ),
    );
  }
}

class _LicensesPage extends StatelessWidget {
  const _LicensesPage();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: LicenseRegistry.licenses.toList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error loading licenses'));
        }

        final packages = {
          for (final license in snapshot.data!) ...license.packages
        };

        return SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: FluxTileGroup(
              children: [
                for (final package in packages)
                  FluxTile(
                    title: package,
                    following: const Icon(Icons.arrow_forward_rounded),
                    onClick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => _LicenseViewPage(
                            package: package,
                            licenses: snapshot.data!,
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _LicenseViewPage extends StatelessWidget {
  final String package;
  final List<LicenseEntry> licenses;
  const _LicenseViewPage({
    required this.package,
    required this.licenses,
  });

  @override
  Widget build(BuildContext context) {
    final matchedLicenses = licenses
        .where((license) => license.packages.contains(package))
        .toList();
    if (matchedLicenses.isNotEmpty) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final license in matchedLicenses) ...[
                for (final paragraph in license.paragraphs) ...[
                  Text(
                    paragraph.text,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
                const SizedBox(height: 16),
                const Divider(
                  height: 0,
                  thickness: 0.09,
                ),
                const SizedBox(height: 16),
              ],
            ],
          ),
        ),
      );
    }
    return const Placeholder();
  }
}
