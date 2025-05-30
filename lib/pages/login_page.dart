import 'package:flutter/material.dart';
                      import '../services/auth_service.dart';

                      class LoginPage extends StatefulWidget {
                        const LoginPage({super.key});

                        @override
                        State<LoginPage> createState() => _LoginPageState();
                      }

                      class _LoginPageState extends State<LoginPage> {
                        final TextEditingController _telegramIdController = TextEditingController();
                        bool _loading = false;
                        String? _error;

                        Future<void> _login(bool isRegister) async {
                          setState(() {
                            _loading = true;
                            _error = null;
                          });
                          final telegramId = _telegramIdController.text.trim();
                          bool success = false;
                          if (isRegister) {
                            success = await AuthService.registerTelegram(telegramId);
                          } else {
                            success = await AuthService.loginTelegram(telegramId);
                          }
                          setState(() {
                            _loading = false;
                            _error = success ? null : 'Error de autenticación';
                          });
                          if (success) {
                            // Recarga la app para pasar a la pantalla principal
                            Navigator.pushReplacementNamed(context, '/');
                          }
                        }

                        @override
                        Widget build(BuildContext context) {
                          return Scaffold(
                            appBar: AppBar(title: const Text('Iniciar sesión con Telegram')),
                            body: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextField(
                                    controller: _telegramIdController,
                                    decoration: const InputDecoration(
                                      labelText: 'Telegram ID',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  if (_error != null)
                                    Text(_error!, style: const TextStyle(color: Colors.red)),
                                  const SizedBox(height: 20),
                                  _loading
                                      ? const CircularProgressIndicator()
                                      : Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () => _login(true),
                                              child: const Text('Registrarse'),
                                            ),
                                            ElevatedButton(
                                              onPressed: () => _login(false),
                                              child: const Text('Iniciar sesión'),
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                            ),
                          );
                        }
                      }