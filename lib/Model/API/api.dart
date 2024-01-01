import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Machine/machine.dart';
import '../Unit/unit.dart';

class Api {
  final String baseUrl = 'http://localhost:3002';

  Future<List<Unit>> fetchLastUnits(String machineId) async {
    //simple test for the machineId, control if it's an int
    int testId = int.parse(machineId);

    //Return a list of the ten last units
    final response =
        await http.get(Uri.parse('$baseUrl/LastUnits?machineId=$machineId'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => Unit.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load last units');
    }
  }

  Future<Unit> fetchLastUnit(String machineId) async {
    int testId = int.parse(machineId);

    final response =
        await http.get(Uri.parse('$baseUrl/LastUnit?machineId=$machineId'));

    if (response.statusCode == 200) {
      return Unit.fromJson(json.decode(response.body)[0]);
    } else {
      throw Exception('Failed to load last unit');
    }
  }

  Future<List<Machine>> fetchMachines() async {
    final response = await http.get(Uri.parse('$baseUrl/AllMachines'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => Machine.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load machines');
    }
  }

  Future<Machine> fetchMachine(String id) async {

    int testId = int.parse(id);

    final response =
        await http.get(Uri.parse('$baseUrl/Machine?machineId=$id'));
    if (response.statusCode == 200) {
      return Machine.fromJson(json.decode(response.body)[0]);
    } else {
      throw Exception('Failed to load machine');
    }
  }

  createMachine(String productionGoal, String sendingTime, String name) async {
    http.post(
      Uri.parse('$baseUrl/NewMachine'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'ProductionGoal': productionGoal,
        'SendingTime': sendingTime,
        'Name': name
      }),
    );
  }

  updateMachine(String id, String productionGoal, String sendingTime, String name) {
    print("update machine");
    print(id);
    int testId = int.parse(id);
    print(testId);

    //I've to use post instead of put because it doesn't work with put
    http.post(
      Uri.parse('$baseUrl/UpdateMachine'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'Id': id,
        'ProductionGoal': productionGoal,
        'SendingTime': sendingTime,
        'Name': name
      }),
    );
  }
}
