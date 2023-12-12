import 'package:flutter/cupertino.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("404", style: TextStyle(fontSize: 50)),
        Text("Page not found", style: TextStyle(fontSize: 25)),
      ],
    ));
  }
}
