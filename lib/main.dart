import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login page',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Connectez-vous à votre compte',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: "Entrez votre nom d'utilisateur",
                ),
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
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: "Entrez votre mot de passe",
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            const TextButton(onPressed: null, child: Text("Se connecter"))
          ],
        ),
      ),
      floatingActionButton: TextButton(
        onPressed: () => {
          launch(
              "mailto:theohakem@gmail.com?subject=Oubli &body=J'ai oublié mon mot de passe !")
        },
        child: const Text('Un oubli ?'),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
