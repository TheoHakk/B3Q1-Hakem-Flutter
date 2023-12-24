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
    //Return a the last registerd unit
    final response =
        await http.get(Uri.parse('$baseUrl/LastUnit?machineId=$machineId'));

    if (response.statusCode == 200) {
      return Unit.fromJson(json.decode(response.body)[0]);
    } else {
      throw Exception('Failed to load last unit');
    }
  }

  Future<void> flushProductionData() async {
    final response = await http.delete(Uri.parse('$baseUrl/Flush'));

    if (response.statusCode != 200) {
      throw Exception('Failed to flush production data');
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
      //[{"Id":1,"ProductionGoal":15,"SendingTime":30000,"Name":"Schaeffer"}]
      return Machine.fromJson(json.decode(response.body)[0]);
    } else {
      throw Exception('Failed to load machine');
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
