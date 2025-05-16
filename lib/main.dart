import 'package:flutter/material.dart';
import 'dart:ui';
import 'pages/rk13_intro_page.dart';
import 'pages/home_page.dart';
import 'pages/learn_python_page.dart';
import 'pages/termux_commands_page.dart';
import 'pages/bash_tools_page.dart';
import 'pages/donar_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const RK13App());
}

class RK13App extends StatelessWidget {
  const RK13App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RK13 Installer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF000000),
        canvasColor: Colors.transparent,
        primaryColor: const Color.fromARGB(255, 255, 0, 51),
        cardColor: Colors.black.withOpacity(0.5),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Color.fromARGB(255, 255, 0, 51)),
          titleTextStyle: TextStyle(
            color: Color.fromARGB(255, 255, 0, 51),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white, fontSize: 16, height: 1.5),
          bodyLarge: TextStyle(color: Colors.white70, fontSize: 18),
        ),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 255, 0, 51)),
        drawerTheme: const DrawerThemeData(backgroundColor: Colors.black),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 255, 0, 51),
            foregroundColor: Colors.white,
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        listTileTheme: const ListTileThemeData(
          iconColor: Color.fromARGB(255, 255, 0, 51),
          textColor: Colors.white,
          selectedColor: Color.fromARGB(255, 255, 0, 51),
        ),
      ),
      home: const MainLayout(),
    );
  }
}

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const Rk13IntroPage(),
    HomePage(),
    const LearnPythonPage(),
    const TermuxCommandsPage(),
    const BashToolsPage(),
  ];

  final List<String> _titles = [
    "Bienvenido a RK13",
    "Repositorios",
    "Aprende Python",
    "Comandos Termux",
    "Scripts Bash Tools",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'Sobre esta app',
            onPressed: () => _mostrarInfo(context),
          ),
        ],
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(color: Colors.black.withOpacity(0.7)),
            ),
            Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      DrawerHeader(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(0, 255, 0, 0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Icon(
                              Icons.terminal,
                              size: 48,
                              color: Color.fromARGB(255, 255, 0, 0),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "RK13 Tools",
                              style: TextStyle(
                                fontSize: 24,
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Instala y explora herramientas de hacking ético.",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color.fromARGB(179, 175, 156, 156),
                              ),
                            ),
                          ],
                        ),
                      ),
                      for (var i = 0; i < _titles.length; i++)
                        _buildDrawerItem(_getIcon(i), _titles[i], i),
                    ],
                  ),
                ),
                const Divider(color: Color.fromARGB(95, 255, 0, 0)),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Developer & Programmer;",
                        style: TextStyle(
                          color: Color.fromARGB(179, 187, 157, 157),
                        ),
                      ),
                      const Text(
                        "Sebastian Lara - RK13",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const DonarPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 255, 0, 0),
                        ),
                        icon: const Icon(
                          Icons.favorite,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        label: const Text(
                          "DONAR",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: _pages[_currentIndex],
    );
  }

  IconData _getIcon(int index) {
    switch (index) {
      case 0:
        return Icons.info;
      case 1:
        return Icons.extension;
      case 2:
        return Icons.code;
      case 3:
        return Icons.computer;
      case 4:
        return Icons.build;
      default:
        return Icons.device_unknown;
    }
  }

  ListTile _buildDrawerItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(
        icon,
        color:
            _currentIndex == index
                ? const Color.fromARGB(255, 255, 0, 51)
                : const Color.fromARGB(255, 255, 255, 255),
      ),
      title: Text(
        title,
        style: TextStyle(
          color:
              _currentIndex == index
                  ? const Color.fromARGB(255, 255, 0, 51)
                  : const Color.fromARGB(255, 255, 255, 255),
        ),
      ),
      selected: _currentIndex == index,
      onTap: () {
        setState(() => _currentIndex = index);
        Navigator.pop(context);
      },
    );
  }

  void _mostrarInfo(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'RK13 Installer',
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(
        Icons.security,
        size: 40,
        color: Color.fromARGB(255, 255, 0, 51),
      ),
      children: [
        const Text(
          'Una app de herramientas automatizadas para usuarios de Termux. '
          'Incluye scripts y accesos rápidos a más de 30 repositorios de seguridad.',
        ),
      ],
    );
  }
}
