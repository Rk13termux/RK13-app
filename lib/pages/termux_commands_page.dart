import 'package:flutter/material.dart';
                import 'package:clipboard/clipboard.dart';
                import 'package:animate_do/animate_do.dart';

                class TermuxCommandsPage extends StatefulWidget {
                  const TermuxCommandsPage({super.key});

                  @override
                  State<TermuxCommandsPage> createState() => _TermuxCommandsPageState();
                }

                class _TermuxCommandsPageState extends State<TermuxCommandsPage> {
                  final Map<String, List<Map<String, String>>> comandosPorCategoria = const {
                    "Sistema y Navegación": [
                      {"comando": "ls", "descripcion": "Listar archivos y carpetas."},
                      {"comando": "cd", "descripcion": "Cambiar de directorio."},
                      {"comando": "pwd", "descripcion": "Mostrar directorio actual."},
                    ],
                    "Gestión de Paquetes": [
                      {"comando": "pkg update", "descripcion": "Actualizar repositorios."},
                      {"comando": "pkg install <paquete>", "descripcion": "Instalar un paquete."},
                      {"comando": "pkg search <nombre>", "descripcion": "Buscar un paquete."},
                    ],
                    "Git y Control de Versiones": [
                      {"comando": "git clone <url>", "descripcion": "Clonar un repositorio."},
                      {"comando": "git status", "descripcion": "Ver estado del repositorio."},
                      {"comando": "git pull", "descripcion": "Actualizar repositorio local."},
                    ],
                    "Lenguajes y Multimedia": [
                      {"comando": "python <archivo.py>", "descripcion": "Ejecutar script Python."},
                      {"comando": "node <archivo.js>", "descripcion": "Ejecutar script JavaScript con Node.js."},
                      {"comando": "ffmpeg -i input.mp4 output.mp3", "descripcion": "Convertir video a audio."},
                    ],
                  };

                  String _search = "";

                  void copiarAlPortapapeles(BuildContext context, String texto) async {
                    await FlutterClipboard.copy(texto);
                    final overlay = Overlay.of(context);
                    final entry = OverlayEntry(
                      builder: (_) => Positioned(
                        bottom: 90,
                        left: 24,
                        right: 24,
                        child: Material(
                          color: Colors.transparent,
                          child: FadeInUp(
                            duration: const Duration(milliseconds: 400),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              decoration: BoxDecoration(
                                color: Colors.redAccent.withOpacity(0.95),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: const [
                                  Icon(Icons.copy, color: Colors.white),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      "Comando copiado",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                    overlay.insert(entry);
                    await Future.delayed(const Duration(milliseconds: 900));
                    entry.remove();
                  }

                  @override
                  Widget build(BuildContext context) {
                    final categorias = comandosPorCategoria.keys.toList();
                    return Scaffold(
                      backgroundColor: Colors.black,
                      appBar: AppBar(
                        title: const Text('Comandos Termux'),
                        backgroundColor: Colors.black,
                      ),
                      body: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                            child: TextField(
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: "Buscar comando...",
                                hintStyle: const TextStyle(color: Colors.white38),
                                prefixIcon: const Icon(Icons.search, color: Colors.redAccent),
                                filled: true,
                                fillColor: Colors.grey[900],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: Colors.redAccent),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: Colors.redAccent),
                                ),
                                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                              ),
                              onChanged: (value) => setState(() => _search = value.trim().toLowerCase()),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              padding: const EdgeInsets.all(16),
                              itemCount: categorias.length,
                              itemBuilder: (context, catIndex) {
                                final categoria = categorias[catIndex];
                                final lista = comandosPorCategoria[categoria]!
                                    .where((cmd) =>
                                        cmd['comando']!.toLowerCase().contains(_search) ||
                                        cmd['descripcion']!.toLowerCase().contains(_search))
                                    .toList();
                                if (lista.isEmpty) return const SizedBox.shrink();
                                return FadeInUp(
                                  duration: Duration(milliseconds: 400 + catIndex * 100),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        child: Text(
                                          categoria,
                                          style: const TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.1,
                                          ),
                                        ),
                                      ),
                                      ...lista.asMap().entries.map((entry) {
                                        final i = entry.key;
                                        final cmd = entry.value;
                                        return SlideInLeft(
                                          duration: Duration(milliseconds: 400 + i * 80),
                                          child: Card(
                                            color: Colors.grey[900],
                                            elevation: 8,
                                            shadowColor: Colors.redAccent.withOpacity(0.18),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(14),
                                              side: const BorderSide(color: Colors.redAccent, width: 1),
                                            ),
                                            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                                            child: ListTile(
                                              title: Text(
                                                cmd['comando']!,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              subtitle: Padding(
                                                padding: const EdgeInsets.only(top: 4),
                                                child: Text(
                                                  cmd['descripcion']!,
                                                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                                                ),
                                              ),
                                              trailing: Tooltip(
                                                message: "Copiar comando",
                                                child: IconButton(
                                                  icon: const Icon(Icons.copy, color: Colors.redAccent),
                                                  onPressed: () => copiarAlPortapapeles(context, cmd['comando']!),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                      const SizedBox(height: 16),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }