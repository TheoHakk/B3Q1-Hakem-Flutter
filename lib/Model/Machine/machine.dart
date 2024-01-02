class Machine {
  final int id;
  final int productionGoal;
  final int sendingTime;
  final String name;

  int totalProd = 0;
  double averageProdDay = 0;
  double averageProdHour = 0;
  String startHour = "";

  Machine(
      {required this.id,
      required this.productionGoal,
      required this.sendingTime,
      required this.name});

  void setTotalProd(int totalProd) {
    this.totalProd = totalProd;
  }

  void setAverageProdDay(double averageProdDay) {
    this.averageProdDay = averageProdDay;
  }

  void setAverageProdHour(double averageProdHour) {
    this.averageProdHour = averageProdHour;
  }

  void setStartHour(String startHour) {
    this.startHour = startHour;
  }

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
