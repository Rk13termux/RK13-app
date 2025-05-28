import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TermuxCommandsPage extends StatelessWidget {
  const TermuxCommandsPage({super.key});

  // Comandos organizados por categorías
  final Map<String, List<Map<String, String>>> comandosPorCategoria = const {
    "Archivos y Directorios": [
      {"comando": "ls", "descripcion": "Listar archivos y directorios."},
      {
        "comando": "pwd",
        "descripcion": "Mostrar el directorio de trabajo actual.",
      },
      {
        "comando": "cd <directorio>",
        "descripcion": "Cambiar al directorio especificado.",
      },
      {
        "comando": "mkdir <nombre>",
        "descripcion": "Crear un nuevo directorio.",
      },
      {
        "comando": "touch <archivo>",
        "descripcion":
            "Crear un archivo vacío o actualizar su fecha de modificación.",
      },
      {"comando": "rm <archivo>", "descripcion": "Eliminar un archivo."},
      {
        "comando": "rmdir <directorio>",
        "descripcion": "Eliminar un directorio vacío.",
      },
      {
        "comando": "rm -rf <directorio>",
        "descripcion":
            "Eliminar un directorio y todo su contenido recursivamente.",
      },
      {
        "comando": "cp <origen> <destino>",
        "descripcion": "Copiar archivos o directorios.",
      },
      {
        "comando": "mv <origen> <destino>",
        "descripcion": "Mover o renombrar archivos o directorios.",
      },
      {
        "comando": "cat <archivo>",
        "descripcion": "Mostrar el contenido de un archivo.",
      },
      {
        "comando": "more <archivo>",
        "descripcion": "Ver el contenido de un archivo página por página.",
      },
      {
        "comando": "head <archivo>",
        "descripcion": "Mostrar las primeras líneas de un archivo.",
      },
      {
        "comando": "tail <archivo>",
        "descripcion": "Mostrar las últimas líneas de un archivo.",
      },
      {
        "comando": "grep <patrón> <archivo>",
        "descripcion": "Buscar un patrón dentro de un archivo.",
      },
      {
        "comando": "find <ruta>",
        "descripcion": "Buscar archivos en una jerarquía de directorios.",
      },
      {
        "comando": "locate <nombre>",
        "descripcion":
            "Encontrar archivos por nombre usando una base de datos.",
      },
    ],
    "Historial y Ayuda": [
      {
        "comando": "history",
        "descripcion": "Mostrar el historial de comandos.",
      },
      {
        "comando": "clear",
        "descripcion": "Limpiar la pantalla de la terminal.",
      },
      {"comando": "echo <texto>", "descripcion": "Mostrar una línea de texto."},
      {
        "comando": "man <comando>",
        "descripcion": "Mostrar el manual de un comando.",
      },
      {"comando": "help", "descripcion": "Mostrar ayuda de shell interna."},
      {
        "comando": "alias <nombre>=<comando>",
        "descripcion": "Crear un alias para un comando.",
      },
      {"comando": "unalias <nombre>", "descripcion": "Eliminar un alias."},
    ],
    "Información del Sistema": [
      {
        "comando": "whoami",
        "descripcion": "Mostrar el nombre de usuario actual.",
      },
      {"comando": "date", "descripcion": "Mostrar la fecha y hora actuales."},
      {"comando": "cal", "descripcion": "Mostrar un calendario."},
      {
        "comando": "uptime",
        "descripcion": "Mostrar el tiempo de actividad del sistema.",
      },
      {"comando": "free", "descripcion": "Mostrar el uso de memoria."},
      {
        "comando": "df",
        "descripcion": "Mostrar espacio en disco de sistemas de archivos.",
      },
      {"comando": "du", "descripcion": "Estimar uso de espacio de archivos."},
      {"comando": "top", "descripcion": "Mostrar procesos en ejecución."},
      {
        "comando": "ps aux",
        "descripcion": "Listar todos los procesos en ejecución.",
      },
      {"comando": "htop", "descripcion": "Visor interactivo de procesos."},
    ],
    "Procesos y Permisos": [
      {
        "comando": "kill <PID>",
        "descripcion": "Enviar señal para detener un proceso.",
      },
      {
        "comando": "killall <nombre>",
        "descripcion": "Detener procesos por nombre.",
      },
      {
        "comando": "pkill <patrón>",
        "descripcion": "Enviar señal a procesos coincidentes.",
      },
      {
        "comando": "bg",
        "descripcion": "Reanudar un trabajo detenido en segundo plano.",
      },
      {
        "comando": "fg",
        "descripcion": "Traer un trabajo de fondo al primer plano.",
      },
      {
        "comando": "jobs",
        "descripcion": "Listar trabajos activos en la sesión.",
      },
      {
        "comando": "chmod <modo> <archivo>",
        "descripcion": "Cambiar permisos de un archivo o directorio.",
      },
      {
        "comando": "chown <usuario>:<grupo> <archivo>",
        "descripcion": "Cambiar propietario y grupo de un archivo.",
      },
      {
        "comando": "chgrp <grupo> <archivo>",
        "descripcion": "Cambiar grupo de un archivo.",
      },
    ],
    "Red y Conectividad": [
      {
        "comando": "ssh <usuario@host>",
        "descripcion": "Conectar a otro equipo vía SSH.",
      },
      {
        "comando": "scp <origen> <destino>",
        "descripcion": "Copiar archivos de forma segura entre hosts.",
      },
      {
        "comando": "wget <url>",
        "descripcion": "Descargar archivos desde la web.",
      },
      {
        "comando": "curl <url>",
        "descripcion": "Transferir datos desde o hacia un servidor.",
      },
      {
        "comando": "ping <host>",
        "descripcion": "Enviar paquetes ICMP para probar conectividad.",
      },
      {
        "comando": "ifconfig",
        "descripcion": "Mostrar configuración de interfaces (obsoleto).",
      },
      {
        "comando": "ip addr",
        "descripcion": "Mostrar o manipular direcciones IP.",
      },
      {
        "comando": "netstat",
        "descripcion": "Mostrar conexiones y estadísticas de red.",
      },
      {"comando": "ss", "descripcion": "Investigar sockets del sistema."},
    ],
    "Comandos Termux Específicos": [
      {
        "comando": "termux-setup-storage",
        "descripcion": "Conceder permisos de almacenamiento.",
      },
      {
        "comando": "termux-open <archivo_o_url>",
        "descripcion": "Abrir archivo o URL en la app predeterminada.",
      },
      {
        "comando": "termux-clipboard-set <texto>",
        "descripcion": "Copiar texto al portapapeles.",
      },
      {
        "comando": "termux-clipboard-get",
        "descripcion": "Obtener texto del portapapeles.",
      },
      {
        "comando": "termux-sms-send -n <número> \"mensaje\"",
        "descripcion": "Enviar un SMS.",
      },
      {
        "comando": "termux-telephony-call <número>",
        "descripcion": "Realizar una llamada telefónica.",
      },
      {
        "comando": "termux-vibrate",
        "descripcion": "Hacer vibrar el dispositivo.",
      },
      {
        "comando": "termux-toast \"mensaje\"",
        "descripcion": "Mostrar un mensaje tipo toast.",
      },
      {
        "comando": "termux-notification --title \"Título\" --content \"Texto\"",
        "descripcion": "Enviar una notificación local.",
      },
      {
        "comando": "termux-battery-status",
        "descripcion": "Mostrar estado de la batería.",
      },
      {"comando": "termux-wifi-enable", "descripcion": "Activar Wi-Fi."},
      {"comando": "termux-wifi-disable", "descripcion": "Desactivar Wi-Fi."},
      {
        "comando": "termux-wake-lock",
        "descripcion": "Mantener el CPU despierto.",
      },
      {"comando": "termux-wake-unlock", "descripcion": "Liberar el wake lock."},
      {
        "comando": "termux-tts-speak <texto>",
        "descripcion": "Leer texto mediante TTS.",
      },
      {
        "comando": "termux-media-player play <archivo>",
        "descripcion": "Reproducir archivo de medios.",
      },
      {
        "comando": "termux-media-player stop",
        "descripcion": "Detener reproducción de medios.",
      },
      {
        "comando": "termux-camera-photo -c 0 <ruta>",
        "descripcion": "Tomar foto con la cámara.",
      },
      {
        "comando": "termux-location",
        "descripcion": "Obtener ubicación GPS actual.",
      },
      {
        "comando": "termux-sensor <tipo>",
        "descripcion": "Leer datos de sensores.",
      },
      {
        "comando": "termux-dialog confirm",
        "descripcion": "Mostrar un diálogo de confirmación.",
      },
      {
        "comando": "termux-alert <mensaje>",
        "descripcion": "Mostrar alerta personalizada.",
      },
      {
        "comando": "termux-share <archivo>",
        "descripcion": "Compartir archivo con otras apps.",
      },
      {
        "comando": "termux-voice-recognize",
        "descripcion": "Reconocer voz del usuario.",
      },
      {
        "comando": "termux-download <url>",
        "descripcion": "Descargar archivo con gestor interno.",
      },
      {
        "comando": "termux-event",
        "descripcion": "Esperar eventos del sistema.",
      },
      {
        "comando": "termux-telephony-cellinfo",
        "descripcion": "Obtener información de celda móvil.",
      },
      {
        "comando": "termux-call-log",
        "descripcion": "Ver registro de llamadas.",
      },
      {
        "comando": "termux-telephony-networkinfo",
        "descripcion": "Obtener info de red móvil.",
      },
      {
        "comando": "termux-contacts-list",
        "descripcion": "Listar contactos del dispositivo.",
      },
      {
        "comando": "termux-job-scheduler",
        "descripcion": "Programar trabajos periódicos en Termux.",
      },
    ],
    "Gestión de Paquetes": [
      {"comando": "pkg update", "descripcion": "Actualizar lista de paquetes."},
      {
        "comando": "pkg upgrade",
        "descripcion": "Instalar actualizaciones disponibles.",
      },
      {
        "comando": "pkg install <paquete>",
        "descripcion": "Instalar un paquete.",
      },
      {"comando": "pkg search <término>", "descripcion": "Buscar un paquete."},
      {
        "comando": "pkg uninstall <paquete>",
        "descripcion": "Desinstalar un paquete.",
      },
      {"comando": "apt update", "descripcion": "Equivalente a pkg update."},
      {"comando": "apt upgrade", "descripcion": "Equivalente a pkg upgrade."},
    ],
    "Git": [
      {
        "comando": "git clone <repo>",
        "descripcion": "Clonar un repositorio Git.",
      },
      {"comando": "git status", "descripcion": "Ver estado del repositorio."},
      {
        "comando": "git add <archivos>",
        "descripcion": "Agregar cambios al índice.",
      },
      {
        "comando": "git commit -m <mensaje>",
        "descripcion": "Registrar cambios en el repositorio.",
      },
      {
        "comando": "git pull",
        "descripcion": "Obtener y fusionar cambios remotos.",
      },
      {
        "comando": "git push",
        "descripcion": "Enviar cambios al repositorio remoto.",
      },
      {"comando": "git log", "descripcion": "Ver historial de commits."},
      {"comando": "git branch", "descripcion": "Listar o crear ramas."},
    ],
    "Lenguajes y Multimedia": [
      {
        "comando": "node <archivo.js>",
        "descripcion": "Ejecutar script JavaScript con Node.js.",
      },
      {
        "comando": "python <archivo.py>",
        "descripcion": "Ejecutar script Python.",
      },
      {
        "comando": "ffmpeg -i <entrada> <salida>",
        "descripcion": "Convertir archivos multimedia.",
      },
    ],
  };

  void copiarAlPortapapeles(BuildContext context, String texto) {
    Clipboard.setData(ClipboardData(text: texto));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Comando copiado al portapapeles'),
        duration: Duration(milliseconds: 800),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Comandos Termux'),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: ListView(
        children:
            comandosPorCategoria.entries.map((entry) {
              return ExpansionTile(
                title: Text(
                  entry.key,
                  style: const TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children:
                    entry.value.map((cmd) {
                      return Card(
                        color: Colors.grey[900],
                        margin: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 8,
                        ),
                        child: ListTile(
                          title: Text(
                            cmd['comando']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              cmd['descripcion']!,
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.copy,
                              color: Colors.redAccent,
                            ),
                            onPressed:
                                () => copiarAlPortapapeles(
                                  context,
                                  cmd['comando']!,
                                ),
                          ),
                        ),
                      );
                    }).toList(),
              );
            }).toList(),
      ),
    );
  }
}
