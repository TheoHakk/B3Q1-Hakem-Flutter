import 'package:flutter/material.dart';
import '../../Firebase/Repositories/user_repository.dart';
import '../../Model/user.dart';

class LoginPage extends StatefulWidget {
  final UserRepository userRepository;
  const LoginPage({super.key, required this.userRepository});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Connection page"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFFADE8F4),
                Color(0xFF90E0EF),
                Color(0xFF48CAE4),
                Color(0xFF00B4D8),
              ],
            ),
          ),
        ),
      ),
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
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: "Username",
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    hintText: "Password",
                  ),
                  obscureText: true,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        await widget.userRepository.signIn(
                          _emailController.text,
                          _passwordController.text,
                        );
                        User user = User(
                          name: _emailController.text,
                          logged: true,
                        );
                        Navigator.pushReplacementNamed(
                          context,
                          "/machineSelection",
                          arguments: user,
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(e.toString()),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text("Login"),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    User user = User(
                      name: "Visitor",
                      logged: false,
                    );
                    Navigator.pushReplacementNamed(
                      context,
                      "/machineSelection",
                      arguments: user,
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
        onPressed: () async {
          try {
            await widget.userRepository.resetPassword(
              _emailController.text,
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Changing password request sent to your mail"),
              ),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(e.toString == "Exception: Error"
                    ? "Please enter a valid mail address"
                    : e.toString()),
              ),
            );
          }
        },
        child: const Text('Forgot password ?'),
      ),
    );
  }
}
