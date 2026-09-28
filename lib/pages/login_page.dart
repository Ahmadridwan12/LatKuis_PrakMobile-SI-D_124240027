import 'package:flutter/material.dart';

import '../config/login_credentials.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _hidePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (!_formKey.currentState!.validate()) return;

    // Periksa NIM sebagai username dan nama program studi sebagai password.
    final usernameMatches =
        _usernameController.text.trim() == LoginCredentials.username;
    final passwordMatches =
        _passwordController.text.trim().toLowerCase() ==
        LoginCredentials.password.toLowerCase();

    if (usernameMatches && passwordMatches) {
      // Login berhasil: ganti halaman login dengan Home Page (push replacement).
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(builder: (_) => const HomePage()),
      );
      return;
    }

    // Login gagal: tampilkan snackbar merah dengan informasi kesalahan.
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('NIM atau nama program studi tidak sesuai.'),
          backgroundColor: Color(0xFFB93832),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  Widget _buildLoginForm(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Masuk ke atlas',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF202B27),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Gunakan NIM dan nama program studi Anda.',
            style: Theme.of(context).textTheme.bodyMedium
                ?.copyWith(color: const Color(0xFF69736C)),
          ),
          const SizedBox(height: 28),
          // Field username: pengguna memasukkan NIM.
          TextFormField(
            controller: _usernameController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'NIM',
              prefixIcon: Icon(Icons.badge_outlined),
            ),
            validator: (value) => value == null || value.trim().isEmpty
                ? 'NIM wajib diisi.'
                : null,
          ),
          const SizedBox(height: 16),
          // Field password: pengguna memasukkan nama program studi.
          TextFormField(
            controller: _passwordController,
            obscureText: _hidePassword,
            onFieldSubmitted: (_) => _login(),
            decoration: InputDecoration(
              labelText: 'Nama program studi',
              prefixIcon: const Icon(Icons.school_outlined),
              suffixIcon: IconButton(
                tooltip: _hidePassword ? 'Tampilkan' : 'Sembunyikan',
                onPressed: () => setState(() => _hidePassword = !_hidePassword),
                icon: Icon(
                  _hidePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
              ),
            ),
            validator: (value) => value == null || value.trim().isEmpty
                ? 'Nama program studi wajib diisi.'
                : null,
          ),
          const SizedBox(height: 22),
          FilledButton.icon(
            onPressed: _login,
            icon: const Icon(Icons.login),
            label: const Text('Masuk'),
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(54),
              backgroundColor: colors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomePanel(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(36),
      decoration: BoxDecoration(
        color: const Color(0xFF24594D),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.eco_outlined, size: 48, color: Color(0xFFE7C36A)),
          const SizedBox(height: 28),
          Text(
            'FAUNA ATLAS',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: const Color(0xFFE7C36A),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 13),
          Text(
            'Kenali penghuni bumi, satu per satu.',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 13),
          Text(
            'Jelajahi habitat, kebiasaan, dan fakta menarik dari berbagai satwa.',
            style: Theme.of(context).textTheme.bodyLarge
                ?.copyWith(color: const Color(0xFFD3E1D8), height: 1.5),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= 900) {
              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1180),
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Row(
                      children: [
                        Expanded(child: _buildWelcomePanel(context)),
                        const SizedBox(width: 72),
                        Expanded(
                          child: Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 420),
                              child: _buildLoginForm(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 40),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.eco_outlined,
                        size: 38,
                        color: Color(0xFF24594D),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'FAUNA ATLAS',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: const Color(0xFF24594D),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Jelajahi dunia satwa.',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 36),
                      _buildLoginForm(context),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
