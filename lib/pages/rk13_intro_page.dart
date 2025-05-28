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
                                        const _SocialRow(),
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