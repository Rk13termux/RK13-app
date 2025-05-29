import 'package:flutter/material.dart';
                          import 'package:font_awesome_flutter/font_awesome_flutter.dart';
                          import 'package:animate_do/animate_do.dart';
                          import 'learn_python_page.dart';
                          import 'donar_page.dart';
                          import 'termux_start_page.dart';
                          import 'package:url_launcher/url_launcher.dart';
                          import 'dart:async';

                          const kPrimaryColor = Color(0xFF3489FE);
                          const kBackgroundColor = Color(0xFF262729);
                          const kTextColor = Colors.white;

                          class Rk13IntroPage extends StatefulWidget {
                            const Rk13IntroPage({super.key});

                            @override
                            State<Rk13IntroPage> createState() => _Rk13IntroPageState();
                          }

                          class _Rk13IntroPageState extends State<Rk13IntroPage> {
                            final ScrollController _iconScrollController = ScrollController();
                            Timer? _scrollTimer;

                            @override
                            void initState() {
                              super.initState();
                              _startAutoScroll();
                            }

                            void _startAutoScroll() {
                              _scrollTimer = Timer.periodic(const Duration(milliseconds: 40), (_) {
                                if (_iconScrollController.hasClients) {
                                  final max = _iconScrollController.position.maxScrollExtent;
                                  final current = _iconScrollController.offset;
                                  if (current < max) {
                                    _iconScrollController.jumpTo(current + 1.5);
                                  } else {
                                    _iconScrollController.jumpTo(0);
                                  }
                                }
                              });
                            }

                            @override
                            void dispose() {
                              _scrollTimer?.cancel();
                              _iconScrollController.dispose();
                              super.dispose();
                            }

                            void _launchFacebook() async {
                              const url = 'https://www.facebook.com/share/15f5KqmACg/';
                              final uri = Uri.parse(url);
                              if (await canLaunchUrl(uri)) {
                                await launchUrl(uri, mode: LaunchMode.externalApplication);
                              }
                            }

                            @override
                            Widget build(BuildContext context) {
                              final w = MediaQuery.of(context).size.width;
                              return Scaffold(
                                backgroundColor: kBackgroundColor,
                                body: SafeArea(
                                  child: ListView(
                                    padding: EdgeInsets.zero,
                                    children: [
                                      // Banner animado con logo alineado a la izquierda
                                      SlideInDown(
                                        duration: const Duration(milliseconds: 900),
                                        child: Stack(
                                          children: [
                                            Image.asset(
                                              'assets/images/intro_banner.png',
                                              width: w,
                                              height: w * 0.45,
                                              fit: BoxFit.cover,
                                            ),
                                            Positioned.fill(
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: BounceInLeft(
                                                  duration: const Duration(milliseconds: 1200),
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 32),
                                                    child: Image.asset(
                                                      'assets/images/rk13_logo.png',
                                                      width: 110,
                                                      height: 110,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 18),
                                      // Mini galería de iconos de lenguajes con scroll automático
                                      SizedBox(
                                        height: 56,
                                        child: ListView(
                                          controller: _iconScrollController,
                                          scrollDirection: Axis.horizontal,
                                          children: [
                                            const SizedBox(width: 18),
                                            _LangIcon(FontAwesomeIcons.python, Colors.yellow, 'Python'),
                                            _LangIcon(FontAwesomeIcons.linux, Colors.white, 'Linux'),
                                            _LangIcon(FontAwesomeIcons.terminal, Colors.greenAccent, 'Bash'),
                                            _LangIcon(FontAwesomeIcons.java, Colors.orange, 'Java'),
                                            _LangIcon(FontAwesomeIcons.html5, Colors.deepOrange, 'HTML5'),
                                            _LangIcon(FontAwesomeIcons.js, Colors.amber, 'JavaScript'),
                                            _LangIcon(FontAwesomeIcons.php, Colors.indigo, 'PHP'),
                                            _LangIcon(FontAwesomeIcons.database, Colors.cyan, 'SQL'),
                                            _LangIcon(FontAwesomeIcons.c, Colors.blue, 'C'),
                                            _LangIcon(FontAwesomeIcons.code, Colors.purpleAccent, 'C++'),
                                            _LangIcon(FontAwesomeIcons.gitAlt, Colors.deepOrange, 'Git'),
                                            _LangIcon(FontAwesomeIcons.networkWired, Colors.tealAccent, 'Networking'),
                                            _LangIcon(FontAwesomeIcons.mask, Colors.redAccent, 'Hacking'),
                                            _LangIcon(FontAwesomeIcons.userSecret, Colors.blueGrey, 'Pentest'),
                                            _LangIcon(FontAwesomeIcons.rust, Colors.orangeAccent, 'Rust'),
                                            _LangIcon(FontAwesomeIcons.nodeJs, Colors.green, 'Node.js'),
                                            _LangIcon(FontAwesomeIcons.gem, Colors.red, 'Ruby'),
                                            _LangIcon(FontAwesomeIcons.periscope, Colors.purple, 'Perl'),
                                            _LangIcon(FontAwesomeIcons.docker, Colors.blueAccent, 'Docker'),
                                            _LangIcon(FontAwesomeIcons.react, Colors.cyanAccent, 'React'),
                                            _LangIcon(FontAwesomeIcons.android, Colors.green, 'Android'),
                                            _LangIcon(FontAwesomeIcons.apple, Colors.white, 'Apple'),
                                            _LangIcon(FontAwesomeIcons.linux, Colors.blue, 'Kali Linux'),
                                            _LangIcon(FontAwesomeIcons.meteor, Colors.deepOrange, 'Metasploit'),
                                            _LangIcon(FontAwesomeIcons.napster, Colors.blueGrey, 'Nmap'),
                                            _LangIcon(FontAwesomeIcons.wifi, Colors.lightBlueAccent, 'Wireshark'),
                                            _LangIcon(FontAwesomeIcons.key, Colors.white, 'SSH'),
                                            _LangIcon(FontAwesomeIcons.windows, Colors.blue, 'Powershell'),
                                            const SizedBox(width: 18),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 18),
                                      // Sección de logos de distros y sistemas con iconos estándar
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 18),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            _LangIcon(FontAwesomeIcons.terminal, Colors.white, 'Termux'),
                                            const SizedBox(width: 16),
                                            _LangIcon(FontAwesomeIcons.linux, Colors.white, 'Linux'),
                                            const SizedBox(width: 16),
                                            _LangIcon(FontAwesomeIcons.windows, Colors.white, 'Windows'),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      // Texto explicativo multiplataforma
                                      const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 24),
                                        child: Text(
                                          'Esta app y sus recursos están pensados para usuarios de Termux, Linux y Windows. '
                                          'Podrás aprender, automatizar y compartir scripts o herramientas entre estos sistemas fácilmente.',
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 15,
                                            height: 1.4,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      const SizedBox(height: 18),
                                      // Botón para ir a la página de inicio Termux
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 32),
                                        child: ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green[700],
                                            foregroundColor: Colors.white,
                                            padding: const EdgeInsets.symmetric(vertical: 15),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            elevation: 8,
                                            textStyle: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                            ),
                                          ),
                                          icon: const FaIcon(FontAwesomeIcons.terminal),
                                          label: const Text('Comienza con Termux'),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (_) => const TermuxStartPage()),
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 18),
                                      // Slogan
                                      const Center(
                                        child: Text(
                                          'Transforma tu móvil en una terminal Linux avanzada',
                                          style: TextStyle(
                                            color: kTextColor,
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
                                            'Accede a más de 50 repositorios, scripts de hacking ético y personalización avanzada. Todo en gris mate y con estilo profesional.',
                                      ),
                                      const SizedBox(height: 18),
                                      // Botón principal
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 32),
                                        child: ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: kPrimaryColor,
                                            foregroundColor: kTextColor,
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
                                      // Sección exclusiva Facebook
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                                        child: Card(
                                          color: kBackgroundColor,
                                          elevation: 6,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(14),
                                            side: const BorderSide(color: kPrimaryColor, width: 1.2),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                                            child: Column(
                                              children: [
                                                const Text(
                                                  'Esta app pertenece a la página de Facebook:',
                                                  style: TextStyle(
                                                    color: kTextColor,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                const SizedBox(height: 10),
                                                ElevatedButton.icon(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: kPrimaryColor,
                                                    foregroundColor: kTextColor,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    padding: const EdgeInsets.symmetric(
                                                      vertical: 12,
                                                      horizontal: 18,
                                                    ),
                                                    textStyle: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  icon: const FaIcon(FontAwesomeIcons.facebook, color: Colors.white),
                                                  label: const Text('Facebook T3R-C0D3'),
                                                  onPressed: _launchFacebook,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 18),
                                      // Redes sociales
                                      const _SocialRow(),
                                      const SizedBox(height: 18),
                                      // Footer
                                      const Center(
                                        child: Text(
                                          '© 2025 T3R-C0D3 - Todos los derechos reservados',
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

                          // Widget para iconos de lenguajes y distros
                          class _LangIcon extends StatelessWidget {
                            final IconData icon;
                            final Color color;
                            final String tooltip;
                            const _LangIcon(this.icon, this.color, this.tooltip, {super.key});

                            @override
                            Widget build(BuildContext context) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Tooltip(
                                  message: tooltip,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.black,
                                    radius: 24,
                                    child: FaIcon(icon, color: color, size: 28),
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
                                  color: kBackgroundColor,
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

                          // Fila de redes sociales
                          class _SocialRow extends StatelessWidget {
                            const _SocialRow();

                            void _launch(String url) async {
                              final uri = Uri.parse(url);
                              if (await canLaunchUrl(uri)) {
                                await launchUrl(uri, mode: LaunchMode.externalApplication);
                              }
                            }

                            @override
                            Widget build(BuildContext context) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: const FaIcon(FontAwesomeIcons.github, color: Colors.white),
                                    onPressed: () => _launch('https://github.com/Rk13termux'),
                                    tooltip: 'GitHub',
                                  ),
                                  IconButton(
                                    icon: const FaIcon(FontAwesomeIcons.telegram, color: Colors.white),
                                    onPressed: () => _launch('https://t.me/rk13termux'),
                                    tooltip: 'Telegram',
                                  ),
                                  IconButton(
                                    icon: const FaIcon(FontAwesomeIcons.youtube, color: Colors.white),
                                    onPressed: () => _launch('https://youtube.com/@rk13termux'),
                                    tooltip: 'YouTube',
                                  ),
                                  IconButton(
                                    icon: const FaIcon(FontAwesomeIcons.instagram, color: Colors.white),
                                    onPressed: () => _launch('https://instagram.com/rk13termux'),
                                    tooltip: 'Instagram',
                                  ),
                                ],
                              );
                            }
                          }