import 'package:bloc/bloc.dart';
import 'package:mis_recetas/sign_up_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  signUp(
      String email, String password, String name, String repeatPassword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
    if (email.isEmpty ||
        password.isEmpty ||
        name.isEmpty ||
        repeatPassword.isEmpty) {
      emit(SignUpFailure("Todos los campos son obligatorios"));
      return;
    }

    if (password != repeatPassword) {
      emit(SignUpFailure("Las contraseñas no coinciden"));
      return;
    }

    emit(SignUpLoading());
    Future.delayed(const Duration(seconds: 1), () {
      emit(SignUpSuccess());
    });
  }
}
