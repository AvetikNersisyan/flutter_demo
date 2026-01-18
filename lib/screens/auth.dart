import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../store/auth_store.dart';

import '../widgets/pill_input.dart';
import '../widgets/segmented.dart';
import '../types/types.dart';


AuthStore authStore = AuthStore();

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthMode _mode = AuthMode.login;
  final _formKey = GlobalKey<FormState>();


  void onMainPage () {
    Navigator.pushReplacementNamed(context, '/');
  }

  void onLogin(){
    final isValid = _formKey.currentState?.validate() ?? false;
    print(isValid);
    if(!isValid) return;
    Navigator.pushReplacementNamed(context, '/');
  }

  void onSignup() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if(!isValid) return;



  }


  void onForgotPass() {

  }

  void emailHandler (String? value) {
    authStore.setEmail(value);
  }
  void usernameHandler (String? value) {
    authStore.setUsername(value);
  }
  void passHandler (String? value) {
    authStore.setPassword(value);
  }

  String? usernameValidator(String? value) {
    if(value == null || value.isEmpty) {
      return 'Username is required';
    }
    if(value.length <= 4) {
      return "Username should be at least 4 chars";
    }
    return null;
  }

  String? emailValidator(String? value) {
    if(value == null || value.isEmpty) {
      return 'Email is required';
    }

    return null;
  }


   String? passValidator(String? value) {
    if(value == null || value.isEmpty) {
      return 'Password is required';
    }

    if(value.length <= 5) {
      return "Password should be min 6 chars length";
    }
    return null;
  }



  void onModeChange( AuthMode mode) {
    setState(() {
      _mode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(authStore.username);
    final isLogin = _mode == AuthMode.login;
    return Scaffold(
      appBar: AppBar(
        title: isLogin ? Text("Login")  : Text("Signup"),
      ),
      body: SafeArea(child: Center(
        child: SingleChildScrollView(
          // child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 420)),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                if(!isLogin) ...[
                  PillFormInput(
                    hint: "Email",
                    label: "Email",
                    onChange: emailHandler,
                    validator: emailValidator,
                  )
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
                const SizedBox(height: 36,),
                AuthSegmented(
                  onLogin: onLogin,
                  onModeChanged: onModeChange,
                  onSignup: onSignup,
                  mode: _mode,
                ),
                const SizedBox(height: 36,),
                TextButton(
                  style: ButtonStyle(
                  ),
                    onPressed: onForgotPass,
                    child: Text("Forgot Password ?")
                ),



              ],
            ),
          )
        ),
      ))
    );
  }}