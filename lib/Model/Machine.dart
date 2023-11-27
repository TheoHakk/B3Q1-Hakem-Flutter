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
    //SELECT AVG(NbUnits)
    // FROM Main
    // WHERE MachineID = ${_id}
    return _averageDailyProduction;
  }

  getAverageHourProduction() {
    int actualHour = DateTime.now().hour;
    //TODO calculate average hour production
    //For this, I will do a SQL query to get
    //the average production of the last hour
    //SELECT AVG(NbUnits)
    // FROM Main
    // WHERE MachineID = ${_id}
    // AND Hour = actualHour
    return _averageHourProduction;
  }

  getAverageMinuteProductionGoal() {
    return _averageMinuteProductionGoal;
  }

  getStartHour() {
    //TODO calculate start hour
    //For this, I will do a SQL query to get
    //the start hour of the machine
    // SELECT (Hour, Minute)
    // FROM Main
    // WHERE MachineID = ${_id}
    // ORDER BY Hour, Minute ASC
    // LIMIT 1
    return _startHour;
  }

  getTimeInactivity() {
    return _timeInactivity;
  }

  isRunning() {
    return _isRunning;
  }

  getId() {
    return _id;
  }

  getName() {
    return _name;
  }
}
