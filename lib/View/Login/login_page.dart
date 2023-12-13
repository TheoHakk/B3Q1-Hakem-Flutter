import 'package:flutter/material.dart';
import '../../Firebase/Repositories/user_repository.dart';

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
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Connection ..."),
                        ),
                      );
                      try {
                        await widget.userRepository.signIn(
                          _emailController.text,
                          _passwordController.text,
                        );
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Successfully logged in"),
                          ),
                        );
                        //We use this method to remove the login page from the stack and use a route to go to the machine selection page
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          "/machineSelection",
                          (route) => false,
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
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    //We use this method to remove the login page from the stack and use a route to go to the machine selection page
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
        onPressed: () async {
          try {
            await widget.userRepository.resetPassword(
              _emailController.text,
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
