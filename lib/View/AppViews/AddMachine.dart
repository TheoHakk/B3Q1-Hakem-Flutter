import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddMachine extends StatefulWidget {
  const AddMachine({super.key, required this.title});

  final String title;

  @override
  State<AddMachine> createState() => _AddMachine();
}

class _AddMachine extends State<AddMachine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Color(0xFF00B4D8),
                Color(0xFF48CAE4),
                Color(0xFF90E0EF),
                Color(0xFFADE8F4),
              ],
            ),
          ),
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Select a machine',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          }, child: const Icon(Icons.check)),
    );
  }
}
