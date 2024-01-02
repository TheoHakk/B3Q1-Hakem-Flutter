import 'package:b3q1_hakem_projet_flutter/BloC/User/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../BloC/User/user_event.dart';
import '../../BloC/User/user_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool hasNavigate = false;

  void _login() {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<UserBloc>(context).add(
        UserLoginEvent(
          _emailController.text,
          _passwordController.text,
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserLoadedState && state.user.logged && !hasNavigate) {
          hasNavigate = true;
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/machineSelection',
            (route) => false,
          );
        } else if (state is UserErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Connection to your account',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(_emailController, 'Username'),
                  const SizedBox(height: 20),
                  _buildTextField(_passwordController, 'Password',
                      obscureText: true),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _login,
                    child: const Text("Login"),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        "/machineSelection",
                        (route) => false,
                      );
                    },
                    child: const Text("Observer mode"),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: TextButton(
          onPressed: () {
            BlocProvider.of<UserBloc>(context).add(
              UserResetPasswordEvent(_emailController.text),
            );
          },
          child: const Text('Forgot password ?'),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText,
      {bool obscureText = false}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
        ),
        obscureText: obscureText,
        validator: (value) => value!.isEmpty ? 'Please enter some text' : null,
        onFieldSubmitted: (_) => _login(),
      ),
    );
  }
}
