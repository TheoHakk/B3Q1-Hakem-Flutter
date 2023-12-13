import 'package:flutter/material.dart';

class FormMachine extends StatefulWidget {
  const FormMachine({super.key, required this.title, required this.machineId});

  final String title;
  final String? machineId;

  @override
  State<FormMachine> createState() => _FormMachine();
}

class _FormMachine extends State<FormMachine> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _goalController = TextEditingController();
  final TextEditingController _dataDelayController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _goalController,
                decoration: const InputDecoration(labelText: 'Production Goal'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a production goal';
                  } else if (int.parse(value) < 0) {
                    return 'Please enter a positive number';
                  } else if (!RegExp(r'^-?[0-9]+$').hasMatch(value)) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dataDelayController,
                decoration: const InputDecoration(
                    labelText: 'Time before sending data'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a production goal';
                  } else if (int.parse(value) < 0) {
                    return 'Please enter a positive number';
                  } else if (!RegExp(r'^-?[0-9]+$').hasMatch(value)) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print('Machine Name: ${_nameController.text}');
                    print('Production Goal: ${_goalController.text}');
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
