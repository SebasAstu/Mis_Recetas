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
        child: Center(
          child: Column(
            children: <Widget>[
              _buildTextFields(),
              _buildButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFields() {
    return Container(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 20.0),
          // Campo de correo
          Container(
            width: 250.0,
            height: 46.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                color: const Color.fromARGB(255, 224, 224, 224),
                width: 2.0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                controller: _emailFilter,
                decoration: const InputDecoration(
                  icon: Icon(Icons.mail, color: Color(0xFFFFA53D)),
                  hintText: 'Correo Electrónico',
                  border: InputBorder.none,
                ),
                style: const TextStyle(color: Color(0xFFFFA53D)),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          // Campo de contraseña
          Container(
            width: 250.0,
            height: 46.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                color: const Color.fromARGB(255, 224, 224, 224),
                width: 2.0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                controller: _passwordFilter,
                obscureText: true,
                decoration: const InputDecoration(
                  icon: Icon(Icons.lock, color: Color(0xFFFFA53D)),
                  hintText: 'Contraseña',
                  border: InputBorder.none,
                ),
                style: const TextStyle(color: Color(0xFFFFA53D)),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Column(
      children: <Widget>[
        ElevatedButton(
          onPressed: _signUpPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFFFA53D),
            side: const BorderSide(
              color: Color.fromARGB(255, 90, 89, 88),
              width: 2,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          child: const SizedBox(
            width: 131.0,
            height: 46.0,
            child: Center(
              child: Text(
                'Iniciar Sesión',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
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
