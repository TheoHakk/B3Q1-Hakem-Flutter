import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '404',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 50,
                  letterSpacing: 2,
                  color: Color(0xff2f3640),
                  fontFamily: 'Anton',
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Sorry, we couldn\'t find the page!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                color: Color(0xff2f3640),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
