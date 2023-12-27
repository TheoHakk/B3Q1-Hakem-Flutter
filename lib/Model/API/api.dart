import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Machine/machine.dart';
import '../Unit/unit.dart';

class Api {
  final String baseUrl = 'http://10.0.70.50:3002';

  Future<List<Unit>> fetchLastUnits(String machineId) async {
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
    final response =
        await http.get(Uri.parse('$baseUrl/Machine?machineId=$id'));
    if (response.statusCode == 200) {
      return Machine.fromJson(json.decode(response.body)[0]);
    } else {
      throw Exception('Failed to load machine');
    }
  }
}
