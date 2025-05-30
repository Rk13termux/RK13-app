import 'package:flutter/material.dart';
          import 'package:http/http.dart' as http;
          import 'dart:convert';
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
              if (!_formKey.currentState!.validate()) return;
              setState(() {
                _loading = true;
                _error = null;
              });
              try {
                final response = await http.post(
                  Uri.parse('https://TU_API_HEROKU/api/register'),
                  headers: {'Content-Type': 'application/json'},
                  body: jsonEncode({'email': _email.trim(), 'password': _password}),
                );
                final data = jsonDecode(response.body);
                if (response.statusCode == 200) {
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
                  _error = 'Error de red o servidor';
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
                body: Center(
                  child: SingleChildScrollView(
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
                            validator: (v) {
                              if (v == null || v.isEmpty) return 'Campo requerido';
                              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v)) return 'Email inválido';
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            decoration: const InputDecoration(labelText: 'Contraseña'),
                            obscureText: true,
                            onChanged: (v) => _password = v,
                            validator: (v) {
                              if (v == null || v.isEmpty) return 'Campo requerido';
                              if (v.length < 6) return 'Mínimo 6 caracteres';
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),
                          _loading
                              ? const CircularProgressIndicator()
                              : ElevatedButton(
                                  onPressed: _register,
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
                ),
              );
            }
          }