import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:permission_handler/permission_handler.dart';

      class ScriptInstaller {
        static Future<bool> _requestPermission() async {
          final status = await Permission.manageExternalStorage.status;
          if (status.isGranted) return true;
          final result = await Permission.manageExternalStorage.request();
          return result.isGranted;
        }

        static Future<void> saveScript(String scriptFile) async {
          try {
            final hasPermission = await _requestPermission();
            if (!hasPermission) {
              throw Exception("Permiso de almacenamiento denegado por el usuario.");
            }

            final baseDir = Directory('/storage/emulated/0/termuxcode');
            if (!await baseDir.exists()) {
              await baseDir.create(recursive: true);
            }

            final fullPath = '${baseDir.path}/$scriptFile';
            final file = File(fullPath);

            if (await file.exists()) {
              // Ya existe, no se sobrescribe
              return;
            }

            final assetPath = 'assets/scripts/$scriptFile';
            final byteData = await rootBundle.load(assetPath);
            await file.writeAsBytes(byteData.buffer.asUint8List(), flush: true);
          } catch (e) {
            throw Exception("Error al guardar el script '$scriptFile': $e");
          }
        }
      }