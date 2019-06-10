class JadwalModel {
  Data data;
  Time time;
  Location location;
  Debug debug;
  String status;

  JadwalModel({this.data, this.time, this.location, this.debug, this.status});

  JadwalModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    time = json['time'] != null ? new Time.fromJson(json['time']) : null;
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    debug = json['debug'] != null ? new Debug.fromJson(json['debug']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    if (this.time != null) {
      data['time'] = this.time.toJson();
    }
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    if (this.debug != null) {
      data['debug'] = this.debug.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Data {
  String fajr;
  String sunrise;
  String dhuhr;
  String asr;
  String sunset;
  String maghrib;
  String isha;
  String sepertigaMalam;
  String tengahMalam;
  String duapertigaMalam;
  List<String> method;

  Data(
      {this.fajr,
      this.sunrise,
      this.dhuhr,
      this.asr,
      this.sunset,
      this.maghrib,
      this.isha,
      this.sepertigaMalam,
      this.tengahMalam,
      this.duapertigaMalam,
      this.method});

  Data.fromJson(Map<String, dynamic> json) {
    fajr = json['Fajr'];
    sunrise = json['Sunrise'];
    dhuhr = json['Dhuhr'];
    asr = json['Asr'];
    sunset = json['Sunset'];
    maghrib = json['Maghrib'];
    isha = json['Isha'];
    sepertigaMalam = json['SepertigaMalam'];
    tengahMalam = json['TengahMalam'];
    duapertigaMalam = json['DuapertigaMalam'];
    method = json['method'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Fajr'] = this.fajr;
    data['Sunrise'] = this.sunrise;
    data['Dhuhr'] = this.dhuhr;
    data['Asr'] = this.asr;
    data['Sunset'] = this.sunset;
    data['Maghrib'] = this.maghrib;
    data['Isha'] = this.isha;
    data['SepertigaMalam'] = this.sepertigaMalam;
    data['TengahMalam'] = this.tengahMalam;
    data['DuapertigaMalam'] = this.duapertigaMalam;
    data['method'] = this.method;
    return data;
  }
}

class Time {
  String date;
  String time;
  String timezone;
  int offset;

  Time({this.date, this.time, this.timezone, this.offset});

  Time.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    time = json['time'];
    timezone = json['timezone'];
    offset = json['offset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['time'] = this.time;
    data['timezone'] = this.timezone;
    data['offset'] = this.offset;
    return data;
  }
}

class Location {
  String latitude;
  String longitude;

  Location({this.latitude, this.longitude});

  Location.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}

class Debug {
  String sunrise;
  String sunset;

  Debug({this.sunrise, this.sunset});

  Debug.fromJson(Map<String, dynamic> json) {
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sunrise'] = this.sunrise;
    data['sunset'] = this.sunset;
    return data;
  }
}
