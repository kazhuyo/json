class JadwalModel {
  String response;
  String timezone;
  Debug debug;
  List<Jadwal> jadwal;
  Location location;

  JadwalModel(
      {this.response, this.timezone, this.debug, this.jadwal, this.location});

  JadwalModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    timezone = json['timezone'];
    debug = json['debug'] != null ? new Debug.fromJson(json['debug']) : null;
    if (json['jadwal'] != null) {
      jadwal = new List<Jadwal>();
      json['jadwal'].forEach((v) {
        jadwal.add(new Jadwal.fromJson(v));
      });
    }
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response'] = this.response;
    data['timezone'] = this.timezone;
    if (this.debug != null) {
      data['debug'] = this.debug.toJson();
    }
    if (this.jadwal != null) {
      data['jadwal'] = this.jadwal.map((v) => v.toJson()).toList();
    }
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
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

class Jadwal {
  int id;
  String name;
  String time;
  String image;

  Jadwal({this.id, this.name, this.time, this.image});

  Jadwal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    time = json['time'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['time'] = this.time;
    data['image'] = this.image;
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
