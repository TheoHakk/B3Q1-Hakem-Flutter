import 'package:b3q1_hakem_projet_flutter/View/AppViews/MachineSelection.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Model/Credential.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Credential credential;

  @override
  void initState() {
    super.initState();
    credential = Credential();

  }

  void setUsername(String username) {
    setState(() {
      credential.setUsername(username);
    });
  }

  void setPassword(String password) {
    setState(() {
      credential.setPassword(password);
    });
  }

  void validConnection() {
    // if (credential.getUsername() == "" || credential.getPassword() == "") {
    //   return;
    // }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const MachineSelection(title: "Machine selection"),
        settings: RouteSettings(
          arguments: credential,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromRGBO(87, 185, 246, 1.0),
                Color.fromRGBO(23, 134, 195, 1.0),
                Color.fromRGBO(0, 77, 123, 1.0),
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Connection to your account',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: "Username",
                ),
                onChanged: (String? value) {
                  setUsername(value!);
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: "Password",
                ),
                obscureText: true,
                onChanged: (String? value) {
                  setPassword(value!);
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            ElevatedButton(
                onPressed: validConnection, child: const Text("Connecting"))
          ],
        ),
      ),
      floatingActionButton: TextButton(
        onPressed: () => {
          launch(
              "mailto:theohakem@gmail.com?subject=Oubli &body=J'ai oublié mon mot de passe !")
        },
        child: const Text('Forgot password ?'),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
