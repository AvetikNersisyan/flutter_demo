import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../store/auth_store.dart';

import '../widgets/pill_input.dart';
import '../widgets/segmented.dart';
import '../widgets/auth_background.dart';
import '../types/types.dart';

// TODO: refactor to import from centralized folder ( assests)
String logoSvgStr = '''
<svg width="49" height="48" viewBox="0 0 49 48" fill="none" xmlns="http://www.w3.org/2000/svg">
    <path d="M24.5 12.75C24.5 18.9632 19.4632 24 13.25 24H2V12.75C2 6.53679 7.03679 1.5 13.25 1.5C19.4632 1.5 24.5 6.53679 24.5 12.75Z" fill="#17CF97"/>
    <path d="M24.5 35.25C24.5 29.0368 29.5368 24 35.75 24H47V35.25C47 41.4632 41.9632 46.5 35.75 46.5C29.5368 46.5 24.5 41.4632 24.5 35.25Z" fill="#17CF97"/>
    <path d="M2 35.25C2 41.4632 7.03679 46.5 13.25 46.5H24.5V35.25C24.5 29.0368 19.4632 24 13.25 24C7.03679 24 2 29.0368 2 35.25Z" fill="#17CF97"/>
    <path d="M47 12.75C47 6.53679 41.9632 1.5 35.75 1.5H24.5V12.75C24.5 18.9632 29.5368 24 35.75 24C41.9632 24 47 18.9632 47 12.75Z" fill="#17CF97"/>
</svg>
''';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthMode _mode = AuthMode.login;
  final _formKey = GlobalKey<FormState>();

  void onMainPage() {
    Navigator.pushReplacementNamed(context, '/');
  }

  void onLogin() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    authStore.clearError();
    final success = await authStore.login();

    if (success && mounted) {
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  void onSignup() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    authStore.clearError();
    final success = await authStore.register();

    if (success && mounted) {
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  void onForgotPass() {
    // FIXME: remindr
  }

  void emailHandler(String? value) {
    authStore.setEmail(value);
  }

  void usernameHandler(String? value) {
    authStore.setUsername(value);
  }

  void passHandler(String? value) {
    authStore.setPassword(value);
  }

  String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    if (value.length <= 4) {
      return "Username should be at least 4 chars";
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    return null;
  }

  String? passValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length <= 5) {
      return "Password should be min 6 chars length";
    }
    return null;
  }

  void onModeChange(AuthMode mode) {
    authStore.clearError();
    setState(() {
      _mode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(authStore.username);
    final isLogin = _mode == AuthMode.login;
    final double logoTopPadding = 54 - kToolbarHeight < 0 ? 0 : 54 - kToolbarHeight;
    return Scaffold(
      appBar: AppBar(
        title: isLogin ? Text("Login") : Text("Signup"),
        backgroundColor: Color(0xFFCFE3FF),
      ),
      body: AuthBackground(
        topColor: Color(0xFFCFE3FF),
        bottomColor: Colors.white,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(24, logoTopPadding, 0, 0),
                child: SvgPicture.string(logoSvgStr, width: 49, height: 48),
              ),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Observer(
                          builder: (_) {
                            if (authStore.errorMessage != null) {
                              return Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.error,
                                        color: Colors.red.shade700,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          authStore.errorMessage!,
                                          style: TextStyle(
                                            color: Colors.red.shade700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                        if (!isLogin) ...[
                          PillFormInput(
                            hint: "Email",
                            label: "Email",
                            onChange: emailHandler,
                            validator: emailValidator,
                          ),
                        ],
                        const SizedBox(height: 12),
                        PillFormInput(
                          hint: "Username",
                          label: "Username",
                          validator: usernameValidator,
                          onChange: usernameHandler,
                        ),
                        const SizedBox(height: 12),
                        PillFormInput(
                          hint: 'Password',
                          obscure: true,
                          label: "Password",
                          validator: passValidator,
                          onChange: passHandler,
                        ),
                        const SizedBox(height: 36),
                        Observer(
                          builder: (_) {
                            if (authStore.isLoading) {
                              return const CircularProgressIndicator();
                            }
                            return AuthSegmented(
                              onLogin: onLogin,
                              onModeChanged: onModeChange,
                              onSignup: onSignup,
                              mode: _mode,
                            );
                          },
                        ),
                        const SizedBox(height: 36),
                        TextButton(
                          style: ButtonStyle(),
                          onPressed: onForgotPass,
                          child: Text("Forgot Password ?"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              )],
          ),
        ),
      ),
    );
  }
}
