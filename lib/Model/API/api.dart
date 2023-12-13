import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  final String baseUrl = 'http://10.0.70.50:3002';
  Future<List<Map<String, dynamic>>> fetchAverageOfDay(String machineId) async {
    final response = await http.get(Uri.parse('$baseUrl/AverageOfDay?machineId=$machineId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load average of day');
    }
  }

  Future<List<Map<String, dynamic>>> fetchAverageOfHour(String machineId, String hour) async {
    final response = await http.get(Uri.parse('$baseUrl/AverageOfHour?machineId=$machineId&hour=$hour'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load average of hour');
    }
  }

  Future<List<Map<String, dynamic>>> fetchStartHour(String machineId) async {
    final response = await http.get(Uri.parse('$baseUrl/StartHour?machineId=$machineId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load start hour');
    }
  }

  Future<List<Map<String, dynamic>>> fetchLastHourProduction() async {
    final response = await http.get(Uri.parse('$baseUrl/LastHourProduction'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load last hour production');
    }
  }

  Future<List<Map<String, dynamic>>> fetchLastUnits(String machineId) async {
    final response = await http.get(Uri.parse('$baseUrl/LastUnits?machineId=$machineId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load last units');
    }
  }

  Future<List<Map<String, dynamic>>> fetchLastUnit(String machineId) async {
    final response = await http.get(Uri.parse('$baseUrl/LastUnit?machineId=$machineId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load last unit');
    }
  }

  Future<List<Map<String, dynamic>>> fetchAllUnits(String machineId) async {
    final response = await http.get(Uri.parse('$baseUrl/AllUnits?machineId=$machineId'));

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

  Future<List<Map<String, dynamic>>> fetchAllMachines() async {
    final response = await http.get(Uri.parse('$baseUrl/AllMachines'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load all machines');
    }
  }

  Future<void> addNewMachine(String machineId, String sendingTime, String machineName, String machineGoal) async {
    final response = await http.post(
      Uri.parse('$baseUrl/NewMachine?machineId=$machineId&sendingTime=$sendingTime&machineName=$machineName&machineGoal=$machineGoal'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add new machine');
    }
  }
}
