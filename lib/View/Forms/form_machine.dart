import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../BloC/User/user_bloc.dart';
import '../../BloC/User/user_state.dart';
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
      print('Machine Name: ${_nameController.text}');
      print('Production Goal: ${_goalController.text}');
      print('Data Delay: ${_dataDelayController.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserLoadedState && !state.user.logged) {
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/login', (route) => false);
          });
        }
      },
      builder: (context, state) {
        if (state is UserErrorState) {
          return const Text('Une erreur est survenue');
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(
                '${widget.title} ${(state is UserLoadedState) ? state.user.name : 'Loading...'}'),
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
      },
    );
  }
}