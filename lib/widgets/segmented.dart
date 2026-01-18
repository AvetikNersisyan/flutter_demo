import 'package:flutter/material.dart';
import '../types/types.dart';

class AuthSegmented extends StatelessWidget {
  final AuthMode mode;
  final VoidCallback onLogin;
  final VoidCallback onSignup;
  final ValueChanged<AuthMode> onModeChanged;

  const AuthSegmented({
    super.key,
    required this.mode,
    required this.onLogin,
    required this.onSignup,
    required this.onModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isLogin = mode == AuthMode.login;

    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final half = w / 2;

        return Container(
          height: 44,
          decoration: BoxDecoration(
            color: const Color(0xFFBBD8FF), // track color
            borderRadius: BorderRadius.circular(999),
          ),
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                left: isLogin ? 0 : half,
                top: 0,
                bottom: 0,
                width: half,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E63FF),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),

              // Click buttos
              Row(
                children: [
                  Expanded(
                    child: _Segment(
                      label: 'Login',
                      active: isLogin,
                      onTap: () {
                        if (isLogin) {
                          onLogin();
                        } else {
                          onModeChanged(AuthMode.login);
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: _Segment(
                      label: 'Signup',
                      active: !isLogin,
                      onTap: () {
                        if (!isLogin) {
                          onSignup();
                        } else {
                          onModeChanged(AuthMode.signup);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Segment extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _Segment({
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: active ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}