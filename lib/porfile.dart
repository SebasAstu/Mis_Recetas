import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final String username;
  final String name;
  final int age;
  final String genero;
  final String location;
  final String email;
  final String movil;

  ProfilePage({
    required this.username,
    required this.name,
    required this.age,
    required this.genero,
    required this.location,
    required this.email,
    required this.movil,
  });

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController generoController;
  late TextEditingController locationController;
  late TextEditingController emailController;
  late TextEditingController movilController;

  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    ageController = TextEditingController(text: widget.age.toString());
    generoController = TextEditingController(text: widget.genero);
    locationController = TextEditingController(text: widget.location);
    emailController = TextEditingController(text: widget.email);
    movilController = TextEditingController(text: widget.movil);
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    generoController.dispose();
    locationController.dispose();
    emailController.dispose();
    movilController.dispose();
    super.dispose();
  }

  void _enableEditing() {
    setState(() {
      isEditing = true;
    });
  }

  void _cancelEditing() {
    setState(() {
      isEditing = false;
      // Reset controllers to initial values
      nameController.text = nameController.text;
      ageController.text = ageController.text;
      generoController.text = generoController.text;
      locationController.text = locationController.text;
      emailController.text = emailController.text;
      movilController.text = movilController.text;
    });
  }

  void _saveChanges() {
    setState(() {
      isEditing = false;
      // Update widget values with edited values
      nameController.text = nameController.text;
      ageController.text = ageController.text;
      generoController.text = generoController.text;
      locationController.text = locationController.text;
      emailController.text = emailController.text;
      movilController.text = movilController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mi Perfil',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFFFFA53D),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFFFA53D), Colors.white],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                CircleAvatar(
                  radius: 80,
                  backgroundColor: Color(0xFFFFA53D),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 6,
                      ),
                    ),
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                isEditing
                    ? _buildEditButtons()
                    : _buildEditButton(),
                SizedBox(height: 20),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _buildProfileDetail('Nombre :', nameController, isEditing),
                        _buildProfileDetail('Edad :', ageController, isEditing),
                        _buildProfileDetail('Genero :', generoController, isEditing),
                        _buildProfileDetail('País :', locationController, isEditing),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _buildProfileDetail('Correo electrónico :', emailController, isEditing),
                        _buildProfileDetail('Nombre de usuario :', TextEditingController(text: widget.username), false),
                        _buildProfileDetail('Número teléfonico :', movilController, isEditing),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEditButton() {
    return Center(
      child: ElevatedButton(
        onPressed: _enableEditing,
        child: Text(
          'Editar perfil',
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          primary: Color(0xFFCD104D), // Orange color
        ),
      ),
    );
  }

  Widget _buildEditButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: _cancelEditing,
          child: Text(
            'Cancelar',
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.grey, // Grey color
          ),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: _saveChanges,
          child: Text(
            'Guardar',
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            primary: Color(0xFFCD104D), // Orange color
          ),
        ),
      ],
    );
  }

  Widget _buildProfileDetail(String label, TextEditingController controller, bool enabled) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFFA53D),
          ),
        ),
        SizedBox(height: 5),
        enabled
            ? TextFormField(
                controller: controller,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              )
            : Text(
                controller.text,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
        SizedBox(height: 10),
      ],
    );
  }
}

