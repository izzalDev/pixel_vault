import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightBlue,
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<({IconData icon, IconData selectedIcon, String label})> _navItems =
      const [
        (
          icon: Icons.home_outlined,
          selectedIcon: Icons.home,
          label: "Home",
        ),
        (
          icon: Icons.settings_outlined,
          selectedIcon: Icons.settings,
          label: "Settings",
        ),
        (
          icon: Icons.history_outlined,
          selectedIcon: Icons.history,
          label: "History",
        ),
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isLargeScreen = MediaQuery.of(context).size.width >= 600;
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            if (isLargeScreen)
              NavigationRail(
                minWidth: 50,
                backgroundColor: theme.colorScheme.primaryContainer,
                indicatorColor: Colors.transparent,
                indicatorShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                selectedIndex: _selectedIndex, // Gunakan state
                onDestinationSelected:
                    _onItemTapped, // Update state saat dipilih
                destinations: _navItems.map((item) {
                  return NavigationRailDestination(
                    icon: Icon(
                      item.icon,
                      size: 24,
                    ),
                    selectedIcon: Icon(
                      item.selectedIcon,
                      size: 24,
                    ),
                    label: Text(item.label),
                  );
                }).toList(),
              ),
            Expanded(
              child: Center(
                child: Text("Hellow World - Selected Index: $_selectedIndex"),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: isLargeScreen
          ? null
          : BottomNavigationBar(
              currentIndex: _selectedIndex, // Gunakan state
              onTap: _onItemTapped, // Update state saat dipilih
              items: _navItems.map((item) {
                return BottomNavigationBarItem(
                  icon: Icon(item.icon),
                  activeIcon: Icon(item.selectedIcon), // Ikon yang diisi/solid
                  label: item.label,
                );
              }).toList(),
            ),
    );
  }
}
