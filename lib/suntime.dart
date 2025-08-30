class SunTimes {
  Results? results;
  String? status;

  SunTimes({this.results, this.status});

  SunTimes.fromJson(Map<String, dynamic> json) {
    results =
        json['results'] != null ? new Results.fromJson(json['results']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Results {
  String? date;
  String? sunrise;
  String? sunset;
  String? firstLight;
  String? lastLight;
  String? dawn;
  String? dusk;
  String? solarNoon;
  String? goldenHour;
  String? dayLength;
  String? timezone;
  int? utcOffset;

  Results({
    this.date,
    this.sunrise,
    this.sunset,
    this.firstLight,
    this.lastLight,
    this.dawn,
    this.dusk,
    this.solarNoon,
    this.goldenHour,
    this.dayLength,
    this.timezone,
    this.utcOffset,
  });

  Results.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    firstLight = json['first_light'];
    lastLight = json['last_light'];
    dawn = json['dawn'];
    dusk = json['dusk'];
    solarNoon = json['solar_noon'];
    goldenHour = json['golden_hour'];
    dayLength = json['day_length'];
    timezone = json['timezone'];
    utcOffset = json['utc_offset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['sunrise'] = this.sunrise;
    data['sunset'] = this.sunset;
    data['first_light'] = this.firstLight;
    data['last_light'] = this.lastLight;
    data['dawn'] = this.dawn;
    data['dusk'] = this.dusk;
    data['solar_noon'] = this.solarNoon;
    data['golden_hour'] = this.goldenHour;
    data['day_length'] = this.dayLength;
    data['timezone'] = this.timezone;
    data['utc_offset'] = this.utcOffset;
    return data;
  }
}
