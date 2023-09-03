import 'package:flutter/material.dart';

import '/pages/generator_page.dart';
import '/pages/favorites_page.dart';
import '/pages/settings_page.dart';

const navDestinationsData = [
  (icon: Icons.home_outlined, selectedIcon: Icons.home, label: "Home"),
  (
    icon: Icons.favorite_outline,
    selectedIcon: Icons.favorite,
    label: "Favorites"
  ),
  (
    icon: Icons.settings_outlined,
    selectedIcon: Icons.settings,
    label: "Settings"
  ),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedIndex = 0;
  void _changePage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return LayoutBuilder(builder: (context, constraints) {
      var isSmallScreen = constraints.maxWidth <= 600;

      var smallScreenContent = Expanded(
        child: Container(
          color: theme.colorScheme.secondaryContainer,
          child: _renderMainContent(),
        ),
      );

      var largeScreenContent = Expanded(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            bottomLeft: Radius.circular(24),
          ),
          child: Container(
            color: theme.colorScheme.secondaryContainer,
            child: _renderMainContent(),
          ),
        ),
      );

      // print("❗ : ${theme.useMaterial3}");

      return Scaffold(
        // extendBodyBehindAppBar: true,
        extendBody: true,
        // drawer: isMobile
        //     ? null
        //     : NavigationDrawer(
        //         selectedIndex: _selectedIndex,
        //         tilePadding: EdgeInsets.symmetric(vertical: 8),
        //         onDestinationSelected: _changePage,
        //         children: navDestinationsData
        //             .map(
        //               (element) => NavigationDrawerDestination(
        //                 icon: Icon(element.icon),
        //                 selectedIcon: Icon(element.selectedIcon),
        //                 label: Text(element.label),
        //               ),
        //             )
        //             .toList(),
        //       ),
        body: isSmallScreen
            ? Column(
                children: [
                  smallScreenContent,
                ],
              )
            : Row(
                children: [
                  NavigationRail(
                    backgroundColor: theme.colorScheme.surface,
                    groupAlignment: 0,
                    labelType: NavigationRailLabelType.selected,
                    selectedIndex: _selectedIndex,
                    onDestinationSelected: _changePage,
                    destinations: navDestinationsData
                        .map(
                          (element) => NavigationRailDestination(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            icon: Icon(element.icon),
                            selectedIcon: Icon(element.selectedIcon),
                            label: Text(element.label),
                          ),
                        )
                        .toList(),
                  ),
                  largeScreenContent,
                ],
              ),
        bottomNavigationBar: isSmallScreen
            ? ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                child: NavigationBar(
                  // backgroundColor: ,
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: _changePage,
                  destinations: navDestinationsData
                      .map(
                        (element) => NavigationDestination(
                          icon: Icon(element.icon),
                          selectedIcon: Icon(element.selectedIcon),
                          label: element.label,
                        ),
                      )
                      .toList(),
                ),
              )
            : null,
      );
    });
  }

  Widget _renderMainContent() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      switchInCurve: Curves.easeInOutCubic,
      switchOutCurve: Curves.easeInOutCubic,
      child: () {
        switch (_selectedIndex) {
          case 0:
            return const GeneratorPage();

          case 1:
            return const FavoritesPage();

          case 2:
            return const SettingsPage();

          default:
            return Center(
              child: Text('Not implemented ($_selectedIndex).'),
            );
        }
      }(),
    );
  }
}
