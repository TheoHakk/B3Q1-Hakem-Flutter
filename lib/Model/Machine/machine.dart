class Machine {
  final int id;
  final String name;
  final int goal;
  final int delaySendingData;

  Machine(this.id, this.name, this.goal, this.delaySendingData);


  factory Machine.fromJson(Map<String, dynamic> json) {
    return Machine(
      json['id'],
      json['name'],
      json['goal'],
      json['delaySendingData'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'goal': goal,
    'delaySendingData': delaySendingData,
  };
}
