import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Machine/machine.dart';

class Api {
  final String baseUrl = 'http://10.0.70.50:3002';

  Future<List<Map<String, dynamic>>> fetchLastUnits(String machineId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/LastUnits?machineId=$machineId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load last units');
    }
  }

  Future<List<Map<String, dynamic>>> fetchLastUnit(String machineId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/LastUnit?machineId=$machineId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load last unit');
    }
  }

  Future<List<Map<String, dynamic>>> fetchAllUnits(String machineId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/AllUnits?machineId=$machineId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load all units');
    }
  }

  Future<void> flushProductionData() async {
    final response = await http.delete(Uri.parse('$baseUrl/Flush'));

    if (response.statusCode != 200) {
      throw Exception('Failed to flush production data');
    }
  }

  Future<List<Machine>> fetchAllMachines() async {
    final response = await http.get(Uri.parse('$baseUrl/AllMachines'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => Machine.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load machines');
    }
  }

  Future<void> addNewMachine(String machineId, String sendingTime,
      String machineName, String machineGoal) async {
    final response = await http.post(
      Uri.parse(
          '$baseUrl/NewMachine?machineId=$machineId&sendingTime=$sendingTime&machineName=$machineName&machineGoal=$machineGoal'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add new machine');
    }
  }
}
