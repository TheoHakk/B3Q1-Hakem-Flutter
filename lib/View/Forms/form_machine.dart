import 'package:b3q1_hakem_projet_flutter/BloC/Machine/machine_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../BloC/Machine/machine_event.dart';

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

  void validateForm() {
    if (_formKey.currentState!.validate()) {
      try {
        int.parse(_goalController.text);
        int.parse(_dataDelayController.text);
      } catch (e) {
        return;
      }

      try {
        if (widget.machineId == null) {
          BlocProvider.of<MachineBloc>(context).add(CreateMachineEvent(
              _goalController.text,
              _dataDelayController.text,
              _nameController.text));
        } else {
          BlocProvider.of<MachineBloc>(context).add(UpdateMachineEvent(
              widget.machineId!,
              _goalController.text,
              _dataDelayController.text,
              _nameController.text));
        }
      } catch (e) {
        SnackBar snackBar = SnackBar(content: Text(e.toString()));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.title),
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
                validator: (value) =>
                value!.isEmpty ? 'Please enter a name' : null,
                onFieldSubmitted: (_) => validateForm(),
              ),
              TextFormField(
                controller: _goalController,
                decoration:
                const InputDecoration(labelText: 'Production Goal'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a production goal';
                  } else if (!RegExp(r'^\d+$').hasMatch(value)) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onFieldSubmitted: (_) => validateForm(),
              ),
              TextFormField(
                controller: _dataDelayController,
                decoration: const InputDecoration(
                    labelText: 'Time before sending data in second'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a delay for the data';
                  } else if (!RegExp(r'^\d+$').hasMatch(value)) {
                    return 'Please enter a valid number';
                  }
                  if(int.parse(value) > 1000){
                    return 'The delay must be less than 1000 seconds';
                  }
                  if(int.parse(value) < 1){
                    return 'The delay must be greater than 1 second';
                  }
                  return null;
                },
                onFieldSubmitted: (value) {
                  value *= 1000;
                  validateForm();
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: validateForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
