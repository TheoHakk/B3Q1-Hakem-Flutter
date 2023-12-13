import 'package:b3q1_hakem_projet_flutter/Model/Machine/machine.dart';
import 'package:http/http.dart' as http;

class HttpService {
  final String _baseUrl = "http://localhost:3002";

  //TODO verify each request

  Future<List<Machine>> getMachines() async {
    final response = await http.get(Uri.parse('$_baseUrl/machines'));
    if (response.statusCode == 200) {
      return machineListFromJson(response.body);
    } else {
      throw Exception('Failed to load machines');
    }
  }

  Future<void> addMachine(Machine machine) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/machines'),
      body: machineToJson(machine),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add machine');
    }
  }

  Future<void> updateMachine(Machine machine) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/machines/${machine.getId()}'),
      body: machineToJson(machine),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update machine');
    }
  }

  Future<void> deleteMachine(String machineId) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/machines/$machineId'),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete machine');
    }
  }

  Future<List<Machine>> machineListFromJson(String body) {
    Machine machine = Machine("Awesome machine", 8, 8);
    List<Machine> machines = List;
    machines.add(machine);
  }
}
