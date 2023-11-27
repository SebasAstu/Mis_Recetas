//Quiero una pantalla simple que tenga la opcion para registrarse con email y password, que se guarden en memoria y que se pueda acceder a la pantalla de inicio de sesion

import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailFilter = TextEditingController();
  final TextEditingController _passwordFilter = TextEditingController();
  final TextEditingController _nameFilter = TextEditingController();
  final TextEditingController _repeatPasswordFilter = TextEditingController();
  String _repeatPassword = "";
  String _email = "";
  String _password = "";
  String _name = "";

  _SignUpPageState() {
    _emailFilter.addListener(_emailListen);
    _passwordFilter.addListener(_passwordListen);
    _nameFilter.addListener(_nameListen);
    _repeatPasswordFilter.addListener(_repeatPasswordListen);
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

  void _nameListen() {
    if (_nameFilter.text.isEmpty) {
      _name = "";
    } else {
      _name = _nameFilter.text;
    }
  }

  void _repeatPasswordListen() {
    if (_repeatPasswordFilter.text.isEmpty) {
      _repeatPassword = "";
    } else {
      _repeatPassword = _repeatPasswordFilter.text;
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
              _buildTextField(
                  _nameFilter, Icons.mail, 'Ingresa tu nombre completo'),
              const SizedBox(height: 20.0),
              _buildTextField(_emailFilter, Icons.mail, 'Correo Electrónico'),
              const SizedBox(height: 20.0),
              _buildTextField(_passwordFilter, Icons.lock, 'Contraseña',
                  obscureText: true),
              const SizedBox(height: 20.0),
              _buildTextField(
                  _repeatPasswordFilter, Icons.lock, 'Repetir Contraseña',
                  obscureText: true),
              const SizedBox(height: 20.0),
              _buildButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, IconData icon, String hintText,
      {bool obscureText = false}) {
    return Container(
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
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            icon: Icon(icon, color: const Color(0xFFFFA53D)),
            hintText: hintText,
            border: InputBorder.none,
          ),
          style: const TextStyle(color: Color(0xFFFFA53D)),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Column(
      children: <Widget>[
        ElevatedButton(
          onPressed: _signUpPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFFA53D),
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
    print(
        'The user wants to login with $_email and $_password and $_name and $_repeatPassword');
  }

  void _loginPressed() {
    Navigator.pop(context);
  }
}
