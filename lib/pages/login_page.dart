import 'package:flutter/material.dart';
                import 'package:http/http.dart' as http;
                import 'dart:convert';
                import '../services/auth_service.dart';
                import 'register_page.dart';

                class LoginPage extends StatefulWidget {
                  const LoginPage({super.key});

                  @override
                  State<LoginPage> createState() => _LoginPageState();
                }

                class _LoginPageState extends State<LoginPage> {
                  final _formKey = GlobalKey<FormState>();
                  String _email = '';
                  String _password = '';
                  bool _loading = false;
                  String? _error;

                  Future<void> _login() async {
                    setState(() {
                      _loading = true;
                      _error = null;
                    });
                    try {
                      final response = await http.post(
                        Uri.parse('https://TU_API_HEROKU/api/login'), // Cambia por tu endpoint real
                        headers: {'Content-Type': 'application/json'},
                        body: jsonEncode({'email': _email, 'password': _password}),
                      );
                      final data = jsonDecode(response.body);
                      if (response.statusCode == 200 && data['token'] != null) {
                        await AuthService.saveToken(data['token']);
                        if (mounted) {
                          Navigator.pushReplacementNamed(context, '/'); // Vuelve al AuthGate
                        }
                      } else {
                        setState(() {
                          _error = data['msg'] ?? 'Credenciales incorrectas';
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
                      appBar: AppBar(title: const Text('Iniciar sesión')),
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
                                          _login();
                                        }
                                      },
                                      child: const Text('Iniciar sesión'),
                                    ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (_) => const RegisterPage()),
                                  );
                                },
                                child: const Text('¿No tienes cuenta? Regístrate'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                }