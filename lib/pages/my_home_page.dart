import 'package:flutter/material.dart';

import 'package:word_generator/pages/favorites_page.dart';
import 'package:word_generator/pages/generator_page.dart';

const navDestinationsData = [
  (icon: Icons.home_outlined, selectedIcon: Icons.home, label: "Home"),
  (
    icon: Icons.favorite_outline,
    selectedIcon: Icons.favorite,
    label: "Favorites"
  ),
  (icon: Icons.list, selectedIcon: Icons.list, label: "Test list"),
  (
    icon: Icons.settings_outlined,
    selectedIcon: Icons.settings,
    label: "Settings"
  ),
];

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _selectedIndex = 0;
  _changePage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return LayoutBuilder(builder: (context, constraints) {
      var isMobile = constraints.maxWidth <= 600;

      var smallScreenContent = Expanded(
        child: Container(
          color: theme.colorScheme.secondaryContainer,
          child: _renderMainContent(),
        ),
      );

      var largeScreenContent = Expanded(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(4),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(24)),
              child: Container(
                color: theme.colorScheme.secondaryContainer,
                child: _renderMainContent(),
              ),
            ),
          ),
        ),
      );

      // print("❗ : ${theme.useMaterial3}");

      return Scaffold(
        // extendBodyBehindAppBar: true,
        extendBody: true,
        drawer: !isMobile
            ? NavigationDrawer(
                selectedIndex: _selectedIndex,
                tilePadding: EdgeInsets.symmetric(vertical: 8),
                onDestinationSelected: _changePage,
                children: navDestinationsData
                    .map(
                      (element) => NavigationDrawerDestination(
                        icon: Icon(element.icon),
                        selectedIcon: Icon(element.selectedIcon),
                        label: Text(element.label),
                      ),
                    )
                    .toList(),
              )
            : null,
        body: isMobile
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
                            padding: EdgeInsets.symmetric(vertical: 8),
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
        bottomNavigationBar: isMobile
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
      duration: Duration(milliseconds: 400),
      switchInCurve: Curves.easeInOutCubic,
      switchOutCurve: Curves.easeInOutCubic,
      child: () {
        switch (_selectedIndex) {
          case 0:
            return GeneratorPage();

          case 1:
            return FavoritesPage();

          case 2:
            return ListView.builder(
              itemCount: 50,
              itemBuilder: (context, index) => SizedBox(
                height: 75,
                child: Card(
                  color: index % 2 == 0 ? Colors.pink[900] : Colors.red[800],
                  child: Center(
                    child: Text('${index + 1}'),
                  ),
                ),
              ),
            );

          default:
            return Center(
              child: Text('Not implemented ($_selectedIndex).'),
            );
        }
      }(),
    );
  }
}
