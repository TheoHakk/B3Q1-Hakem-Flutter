class Unit {
  final int id;
  final int nbUnits;
  final int hour;
  final int minute;
  final int second;

  Unit({required this.id, required this.nbUnits, required this.hour, required this.minute, required this.second});

  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
      id: json['Id'],
      nbUnits: json['NbUnits'],
      hour: json['Hour'],
      minute: json['Minute'],
      second: json['Second'],
    );
  }

  Map<String, dynamic> toJson() => {
    'Id': id,
    'NbUnits': nbUnits,
    'Hour': hour,
    'Minute': minute,
    'Second': second,
  };
}