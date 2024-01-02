import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Machine/machine.dart';
import '../Unit/unit.dart';

class Api {
  final String baseUrl = 'http://10.0.70.50:3002';

  Future<List<Unit>> fetchLastUnits(String machineId) async {
    //simple test for the machineId, control if it's an int
    int testId = int.parse(machineId);
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

  updateMachine(
      String id, String productionGoal, String sendingTime, String name) {
    int testId = int.parse(id);
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

  deleteMachine(String id) {
    int testId = int.parse(id);
    http.get(Uri.parse('$baseUrl/DeleteMachine?machineId=$id'));
  }

  Future<int> fetchTotalProd(String id) async {
    int testId = int.parse(id);
    final response =
        await http.get(Uri.parse('$baseUrl/TotalProduction?machineId=$id'));

    if (response.statusCode == 200) {
      return int.parse(response.body);
    } else {
      throw Exception('Failed to load total prod');
    }
  }


  Future<double> fetchAverageProdDay(String id) async {
    int testId = int.parse(id);
    final response =
    await http.get(Uri.parse('$baseUrl/AverageProdDay?machineId=$id'));

    if (response.statusCode == 200) {
      double averageProdDay = double.parse(response.body);
      return double.parse(averageProdDay.toStringAsFixed(2));
    } else {
      throw Exception('Failed to load average prod day');
    }
  }

  Future<double> fetchAverageProdHour(String id) async {
    int testId = int.parse(id);
    final response =
        await http.get(Uri.parse('$baseUrl/AverageProdHour?machineId=$id'));

    if (response.statusCode == 200) {
      double averageProdDay = double.parse(response.body);
      return double.parse(averageProdDay.toStringAsFixed(2));
    } else {
      throw Exception('Failed to load average prod hour');
    }
  }

  Future<String> fetchStartHour(String id) async {
    int testId = int.parse(id);
    final response =
        await http.get(Uri.parse('$baseUrl/StartHour?machineId=$id'));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load average prod hour');
    }
  }
}
