import 'package:flutter/material.dart';
          import 'package:font_awesome_flutter/font_awesome_flutter.dart';
          import 'package:animate_do/animate_do.dart';
          import 'learn_python_page.dart';
          import 'donar_page.dart';
          import 'package:url_launcher/url_launcher.dart';

          const kPrimaryColor = Color(0xFFFF0033);
          const kBackgroundColor = Color(0xFF000000);

          class Rk13IntroPage extends StatelessWidget {
            const Rk13IntroPage({super.key});

            @override
            Widget build(BuildContext context) {
              final w = MediaQuery.of(context).size.width;
              return Scaffold(
                backgroundColor: kBackgroundColor,
                body: SafeArea(
                  child: ListView(
                    padding: const EdgeInsets.all(0),
                    children: [
                      // Banner superior con logo y nombre animados
                      Stack(
                        children: [
                          Container(
                            width: w,
                            height: w * 0.45,
                            decoration: const BoxDecoration(
                              color: kBackgroundColor,
                            ),
                            child: Image.asset(
                              'assets/images/intro_banner.png',
                              fit: BoxFit.cover,
                              width: w,
                              height: w * 0.45,
                              color: Colors.black.withOpacity(0.5),
                              colorBlendMode: BlendMode.darken,
                            ),
                          ),
                          Positioned(
                            left: 24,
                            top: 24,
                            child: ZoomIn(
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/rk13_logo.png',
                                    width: 60,
                                    height: 60,
                                  ),
                                  const SizedBox(width: 16),
                                  const Text(
                                    'RK13 Installer',
                                    style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      // Slogan
                      const Center(
                        child: Text(
                          'Transforma tu móvil en una terminal Linux avanzada',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 18),
                      // Tarjeta de introducción
                      _IntroCard(
                        icon: FontAwesomeIcons.terminal,
                        title: 'Automatiza, aprende y hackea',
                        description:
                            'Instala herramientas, aprende Python y domina Termux desde tu móvil. Scripts, recursos y utilidades en un solo lugar.',
                      ),
                      const SizedBox(height: 12),
                      // Tarjeta de beneficios
                      _IntroCard(
                        icon: FontAwesomeIcons.shieldAlt,
                        title: 'Seguridad y Potencia',
                        description:
                            'Accede a más de 50 repositorios, scripts de hacking ético y personalización avanzada. Todo en negro mate y con estilo profesional.',
                      ),
                      const SizedBox(height: 18),
                      // Botón principal
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 8,
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          icon: const Icon(Icons.play_arrow),
                          label: const Text('Aprende Python Ahora'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const LearnPythonPage()),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 18),
                      // Frase motivacional
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          '"El conocimiento es la mejor arma" - Chema Alonso',
                          style: TextStyle(
                            color: Colors.white38,
                            fontStyle: FontStyle.italic,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 18),
                      // Botón de donación
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: kPrimaryColor,
                            side: const BorderSide(color: kPrimaryColor, width: 2),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          icon: const Icon(Icons.favorite),
                          label: const Text('Donar y Apoyar'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const DonarPage()),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Redes sociales
                      _SocialRow(),
                      const SizedBox(height: 18),
                      // Footer
                      const Center(
                        child: Text(
                          '© 2025 Rk13Termux - Todos los derechos reservados',
                          style: TextStyle(color: Colors.white24, fontSize: 12),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              );
            }
          }

          // Tarjeta de introducción reutilizable
          class _IntroCard extends StatelessWidget {
            final IconData icon;
            final String title;
            final String description;
            const _IntroCard({
              required this.icon,
              required this.title,
              required this.description,
            });

            @override
            Widget build(BuildContext context) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Card(
                  color: Colors.black,
                  elevation: 8,
                  shadowColor: kPrimaryColor.withOpacity(0.15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: const BorderSide(color: kPrimaryColor, width: 1.2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                    child: Row(
                      children: [
                        FaIcon(icon, color: kPrimaryColor, size: 32),
                        const SizedBox(width: 18),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                description,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          }

import 'package:flutter/material.dart';
import 'dart:ui';
import 'pages/rk13_intro_page.dart';
import 'pages/home_page.dart';
import 'pages/learn_python_page.dart';
import 'pages/termux_commands_page.dart';
import 'pages/bash_tools_page.dart';
import 'pages/donar_page.dart';

// Nuevos colores
const kBackgroundColor = Color(0xFF262729); // gris
const kPrimaryColor = Color(0xFF3489FE);    // azul
const kTextColor = Colors.white;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const T3RC0D3App());
}

class T3RC0D3App extends StatelessWidget {
  const T3RC0D3App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'T3R-C0D3',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: kBackgroundColor,
        canvasColor: kBackgroundColor,
        primaryColor: kPrimaryColor,
        cardColor: Colors.grey[900],
        appBarTheme: const AppBarTheme(
          backgroundColor: kBackgroundColor,
          surfaceTintColor: kBackgroundColor,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: kPrimaryColor),
          titleTextStyle: TextStyle(
            color: kTextColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: kTextColor, fontSize: 16, height: 1.5),
          bodyLarge: TextStyle(color: kTextColor, fontSize: 18),
        ),
        iconTheme: const IconThemeData(color: kPrimaryColor),
        drawerTheme: const DrawerThemeData(backgroundColor: kBackgroundColor),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            foregroundColor: kTextColor,
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
          iconColor: kPrimaryColor,
          textColor: kTextColor,
          selectedColor: kPrimaryColor,
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
    "Bienvenido a T3R-C0D3",
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
              child: Container(color: kBackgroundColor.withOpacity(0.7)),
            ),
            Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      DrawerHeader(
                        decoration: const BoxDecoration(
                          color: Color(0x00000000),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Icon(
                              Icons.terminal,
                              size: 48,
                              color: kPrimaryColor,
                            ),
                            SizedBox(height: 10),
                            Text(
                              "T3R-C0D3",
                              style: TextStyle(
                                fontSize: 24,
                                color: kTextColor,
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
                const Divider(color: kPrimaryColor),
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
                          color: kTextColor,
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
                          backgroundColor: kPrimaryColor,
                        ),
                        icon: const Icon(
                          Icons.favorite,
                          color: kTextColor,
                        ),
                        label: const Text(
                          "DONAR",
                          style: TextStyle(
                            color: kTextColor,
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
        color: _currentIndex == index ? kPrimaryColor : kTextColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: _currentIndex == index ? kPrimaryColor : kTextColor,
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
      applicationName: 'T3R-C0D3',
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(
        Icons.security,
        size: 40,
        color: kPrimaryColor,
      ),
      children: [
        const Text(
          'Una app de herramientas automatizadas para usuarios de Termux. '
          'Incluye scripts y accesos rápidos a más de 30 repositorios de seguridad.',
          style: TextStyle(color: kTextColor),
        ),
      ],
    );
  }
}          // Fila de redes sociales
          class _SocialRow extends StatelessWidget {
            @override
            Widget build(BuildContext context) {
              final items = [
                {'icon': FontAwesomeIcons.github, 'url': 'https://github.com/Rk13termux'},
                {'icon': FontAwesomeIcons.instagram, 'url': 'https://instagram.com/Rk13termux'},
                {'icon': FontAwesomeIcons.telegram, 'url': 'https://t.me/Rk13termux'},
              ];
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: items.map((item) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () async {
                        final url = item['url'] as String;
                        final uri = Uri.parse(url);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri, mode: LaunchMode.externalApplication);
                        }
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.white10,
                        radius: 22,
                        child: FaIcon(
                          item['icon'] as IconData,
                          color: kPrimaryColor,
                          size: 22,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            }
          }