import 'package:flutter/material.dart';
  import 'package:flutter/services.dart' show rootBundle;
  import 'package:flutter_markdown/flutter_markdown.dart';
  import 'package:url_launcher/url_launcher.dart';
  import 'package:clipboard/clipboard.dart';
  import 'package:android_intent_plus/android_intent.dart';
  import 'package:permission_handler/permission_handler.dart';
  import 'package:font_awesome_flutter/font_awesome_flutter.dart';
  import 'package:animate_do/animate_do.dart';
  import '../utils/script_installer.dart';

  // Colores del tema
  const kPrimaryColor = Color(0xFF3489FE);
  const kBackgroundColor = Color(0xFF262729);

  class RepoReadmePage extends StatefulWidget {
    final String repoName;
    final String scriptFile;
    final String readmeAsset;
    final String githubUrl;

    const RepoReadmePage({
      required this.repoName,
      required this.scriptFile,
      required this.readmeAsset,
      required this.githubUrl,
      super.key,
    });

    @override
    State<RepoReadmePage> createState() => _RepoReadmePageState();
  }

  class _RepoReadmePageState extends State<RepoReadmePage> {
    String readmeContent = "Cargando README...";
    bool isSaving = false;
    bool isSaved = false;

    @override
    void initState() {
      super.initState();
      _loadReadme();
    }

    Future<void> _loadReadme() async {
      try {
        final content = await rootBundle.loadString(widget.readmeAsset);
        setState(() {
          readmeContent = content;
        });
      } catch (e) {
        setState(() {
          readmeContent = "No se pudo cargar el README.";
        });
      }
    }

    Future<void> _guardarScript() async {
      final granted = await _pedirPermiso();
      if (!granted) return;

      setState(() {
        isSaving = true;
        isSaved = false;
      });

      try {
        await ScriptInstaller.saveScript(widget.scriptFile);
        setState(() {
          isSaved = true;
        });
        _mostrarToast("Script guardado en almacenamiento", Colors.greenAccent);
      } catch (e) {
        _mostrarToast("Error al guardar el script", Colors.redAccent);
      } finally {
        setState(() {
          isSaving = false;
        });
      }
    }

    Future<bool> _pedirPermiso() async {
      final status = await Permission.manageExternalStorage.request();
      if (status.isGranted) return true;

      _mostrarToast("Permiso de almacenamiento denegado", Colors.orange);
      return false;
    }

    Future<void> _copiarComando() async {
      final path = "/storage/emulated/0/termuxcode/${widget.scriptFile}";
      await FlutterClipboard.copy("bash $path");
      _mostrarToast("📋 Comando copiado: bash $path", kPrimaryColor);
    }

    void _mostrarToast(String mensaje, Color color) {
      final overlay = Overlay.of(context);

      final entry = OverlayEntry(
        builder: (context) => Positioned(
          bottom: 80,
          left: 24,
          right: 24,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color: color.withOpacity(0.95),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                mensaje,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      );

      overlay.insert(entry);
      Future.delayed(const Duration(seconds: 2), () => entry.remove());
    }

    Future<void> _abrirTermux() async {
      const intent = AndroidIntent(
        action: 'action_view',
        package: 'com.termux',
      );
      try {
        await intent.launch();
      } catch (e) {
        _mostrarToast("No se pudo abrir Termux", Colors.redAccent);
      }
    }

    Future<void> _abrirGithub() async {
      final uri = Uri.parse(widget.githubUrl);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        _mostrarToast("No se pudo abrir GitHub", Colors.redAccent);
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: kBackgroundColor,
          title: Text(
            widget.repoName,
            style: const TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          iconTheme: const IconThemeData(color: kPrimaryColor),
          elevation: 2,
        ),
        body: FadeIn(
          duration: const Duration(milliseconds: 400),
          child: Column(
            children: [
              Expanded(
                child: Markdown(
                  data: readmeContent,
                  styleSheet: MarkdownStyleSheet(
                    p: const TextStyle(color: Colors.white, fontSize: 16),
                    h1: const TextStyle(color: kPrimaryColor, fontSize: 26, fontWeight: FontWeight.bold),
                    h2: const TextStyle(color: kPrimaryColor, fontSize: 22, fontWeight: FontWeight.bold),
                    h3: const TextStyle(color: kPrimaryColor, fontSize: 19, fontWeight: FontWeight.bold),
                    code: const TextStyle(color: Colors.greenAccent, fontFamily: 'monospace'),
                    blockquote: const TextStyle(color: Colors.white70, fontStyle: FontStyle.italic),
                    listBullet: const TextStyle(color: kPrimaryColor),
                    tableHead: const TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
                    tableBody: const TextStyle(color: Colors.white),
                    codeblockDecoration: BoxDecoration(
                      color: const Color(0xFF232323),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    blockquoteDecoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  selectable: true,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Tooltip(
                        message: isSaved ? "Script guardado" : "Guardar script en almacenamiento",
                        child: ElevatedButton.icon(
                          icon: isSaving
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.2,
                                  ),
                                )
                              : const Icon(Icons.save_alt),
                          label: Text(isSaved ? "Guardado" : "Guardar"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            elevation: 4,
                          ),
                          onPressed: isSaving ? null : _guardarScript,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Tooltip(
                      message: "Copiar comando bash",
                      child: IconButton(
                        icon: const FaIcon(FontAwesomeIcons.clipboard, color: kPrimaryColor),
                        onPressed: _copiarComando,
                      ),
                    ),
                    Tooltip(
                      message: "Abrir Termux",
                      child: IconButton(
                        icon: const FaIcon(FontAwesomeIcons.terminal, color: Colors.greenAccent),
                        onPressed: _abrirTermux,
                      ),
                    ),
                    Tooltip(
                      message: "Ver en GitHub",
                      child: IconButton(
                        icon: const FaIcon(FontAwesomeIcons.github, color: Colors.white),
                        onPressed: _abrirGithub,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }