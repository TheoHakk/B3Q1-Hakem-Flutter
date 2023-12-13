class Machine {
  late int _id;
  late String _name;
  late String _startHour;
  late int _averageDailyProduction;
  late int _averageHourProduction;
  late int _averageMinuteProductionGoal;
  late bool _isRunning;
  late int _timeInactivity;

  Machine(String name, int id, int averageMinuteProductionGoal) {
    _name = name;
    _id = id;
    _averageMinuteProductionGoal = averageMinuteProductionGoal;
    putDefaultValues();
  }

  putDefaultValues() {
    _startHour = "5:35";
    _averageDailyProduction = 6;
    _averageHourProduction = 4;
    _isRunning = false;
    _timeInactivity = 13;
  }

  getAverageDailyProduction() {

    return _averageDailyProduction;
  }

  getAverageHourProduction() {
    int actualHour = DateTime.now().hour;
    //TODO calculate average hour production
    return _averageHourProduction;
  }

  getAverageMinuteProductionGoal() {
    return _averageMinuteProductionGoal;
  }

  getStartHour() {
    //TODO calculate start hour
    return _startHour;
  }

  getTimeInactivity() {
    //Différence entre l'heure actuelle et l'heure du dernier passage de paquet positif
    return _timeInactivity;
  }

  getId() {
    return _id;
  }

  getName() {
    return _name;
  }
}
