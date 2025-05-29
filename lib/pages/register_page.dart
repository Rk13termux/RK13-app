import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../services/auth_service.dart';
import 'login_page.dart';

          class RegisterPage extends StatefulWidget {
            const RegisterPage({super.key});

            @override
            State<RegisterPage> createState() => _RegisterPageState();
          }

          class _RegisterPageState extends State<RegisterPage> {
            final _formKey = GlobalKey<FormState>();
            String _email = '';
            String _password = '';
            bool _loading = false;
            String? _error;

            Future<void> _register() async {
              setState(() {
                _loading = true;
                _error = null;
              });
              try {
                final response = await http.post(
                  Uri.parse('https://TU_API_HEROKU/api/register'), // Cambia por tu endpoint real
                  headers: {'Content-Type': 'application/json'},
                  body: jsonEncode({'email': _email, 'password': _password}),
                );
                final data = jsonDecode(response.body);
                if (response.statusCode == 200) {
                  // Si tu API retorna un token, guárdalo
                  // await AuthService.saveToken(data['token']);
                  // Si solo retorna mensaje, puedes navegar al login
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Registro exitoso, inicia sesión')),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginPage()),
                    );
                  }
                } else {
                  setState(() {
                    _error = data['msg'] ?? 'Error al registrar';
                  });
                }
              } catch (e) {
                setState(() {
                  _error = 'Error de red';
                });
              } finally {
                setState(() {
                  _loading = false;
                });
              }
            }

            @override
            Widget build(BuildContext context) {
              return Scaffold(
                appBar: AppBar(title: const Text('Registro')),
                body: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        if (_error != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Text(_error!, style: const TextStyle(color: Colors.red)),
                          ),
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (v) => _email = v,
                          validator: (v) => v != null && v.contains('@') ? null : 'Email inválido',
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Contraseña'),
                          obscureText: true,
                          onChanged: (v) => _password = v,
                          validator: (v) => v != null && v.length >= 6 ? null : 'Mínimo 6 caracteres',
                        ),
                        const SizedBox(height: 24),
                        _loading
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _register();
                                  }
                                },
                                child: const Text('Registrarse'),
                              ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => const LoginPage()),
                            );
                          },
                          child: const Text('¿Ya tienes cuenta? Inicia sesión'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          }