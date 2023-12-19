class Machine {
  final int id;
  final int productionGoal;
  final int sendingTime;
  final String name;

  Machine({required this.id, required this.productionGoal, required this.sendingTime, required this.name});

  factory Machine.fromJson(Map<String, dynamic> json) {
    return Machine(
      id: json['Id'],
      productionGoal: json['ProductionGoal'],
      sendingTime: json['SendingTime'],
      name: json['Name'],
    );
  }

  Map<String, dynamic> toJson() => {
    'Id': id,
    'Name': name,
    'ProductionGoal': productionGoal,
    'SendingTime': sendingTime,
  };
}
