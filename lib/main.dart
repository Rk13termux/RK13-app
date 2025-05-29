import 'package:flutter/material.dart';
              import 'dart:ui';
              import 'pages/rk13_intro_page.dart';
              import 'pages/home_page.dart';
              import 'pages/learn_python_page.dart';
              import 'pages/termux_commands_page.dart';
              import 'pages/bash_tools_page.dart';
              import 'pages/donar_page.dart';
              import 'pages/login_page.dart'; // Asegúrate de tener esta página creada
              import 'services/auth_service.dart';

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
                    home: const AuthGate(),
                  );
                }
              }

              class AuthGate extends StatefulWidget {
                const AuthGate({super.key});

                @override
                State<AuthGate> createState() => _AuthGateState();
              }

              class _AuthGateState extends State<AuthGate> {
                bool _loading = true;
                bool _authenticated = false;

                @override
                void initState() {
                  super.initState();
                  _checkAuth();
                }

                Future<void> _checkAuth() async {
                  final token = await AuthService.getToken();
                  setState(() {
                    _authenticated = token != null;
                    _loading = false;
                  });
                }

                @override
                Widget build(BuildContext context) {
                  if (_loading) {
                    return const Scaffold(body: Center(child: CircularProgressIndicator()));
                  }
                  if (_authenticated) {
                    return const MainLayout();
                  } else {
                    return const LoginPage();
                  }
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
              }