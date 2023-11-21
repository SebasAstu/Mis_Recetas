//Quiero una pantalla simple que tenga la opcion para registrarse con email y password, que se guarden en memoria y que se pueda acceder a la pantalla de inicio de sesion

import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailFilter = TextEditingController();
  final TextEditingController _passwordFilter = TextEditingController();
  String _email = "";
  String _password = "";

  _SignUpPageState() {
    _emailFilter.addListener(_emailListen);
    _passwordFilter.addListener(_passwordListen);
  }

  void _emailListen() {
    if (_emailFilter.text.isEmpty) {
      _email = "";
    } else {
      _email = _emailFilter.text;
    }
  }

  void _passwordListen() {
    if (_passwordFilter.text.isEmpty) {
      _password = "";
    } else {
      _password = _passwordFilter.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign up"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            _buildTextFields(),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFields() {
    return Container(
      child: Column(
        children: <Widget>[
          TextField(
            controller: _emailFilter,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: _passwordFilter,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
          )
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Column(
      children: <Widget>[
        ElevatedButton(
          onPressed: _signUpPressed,
          child: const Text('Sign Up'),
        ),
        ElevatedButton(
          onPressed: _loginPressed,
          child: const Text('Have an account? Login.'),
        )
      ],
    );
  }

  void _signUpPressed() {
    print('The user wants to login with $_email and $_password');
  }

  void _loginPressed() {
    Navigator.pop(context);
  }
}
