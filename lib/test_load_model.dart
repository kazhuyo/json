// To parse this JSON data, do
//
//     final jadwalModel = jadwalModelFromJson(jsonString);

import 'dart:convert';

JadwalModel jadwalModelFromJson(String str) => JadwalModel.fromJson(json.decode(str));

String jadwalModelToJson(JadwalModel data) => json.encode(data.toJson());

class JadwalModel {
    Data data;
    Time time;
    Location location;
    Debug debug;
    String status;

    JadwalModel({
        this.data,
        this.time,
        this.location,
        this.debug,
        this.status,
    });

    factory JadwalModel.fromJson(Map<String, dynamic> json) => new JadwalModel(
        data: Data.fromJson(json["data"]),
        time: Time.fromJson(json["time"]),
        location: Location.fromJson(json["location"]),
        debug: Debug.fromJson(json["debug"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "time": time.toJson(),
        "location": location.toJson(),
        "debug": debug.toJson(),
        "status": status,
    };
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

    Data({
        this.fajr,
        this.sunrise,
        this.dhuhr,
        this.asr,
        this.sunset,
        this.maghrib,
        this.isha,
        this.sepertigaMalam,
        this.tengahMalam,
        this.duapertigaMalam,
        this.method,
    });

    factory Data.fromJson(Map<String, dynamic> json) => new Data(
        fajr: json["Fajr"],
        sunrise: json["Sunrise"],
        dhuhr: json["Dhuhr"],
        asr: json["Asr"],
        sunset: json["Sunset"],
        maghrib: json["Maghrib"],
        isha: json["Isha"],
        sepertigaMalam: json["SepertigaMalam"],
        tengahMalam: json["TengahMalam"],
        duapertigaMalam: json["DuapertigaMalam"],
        method: new List<String>.from(json["method"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "Fajr": fajr,
        "Sunrise": sunrise,
        "Dhuhr": dhuhr,
        "Asr": asr,
        "Sunset": sunset,
        "Maghrib": maghrib,
        "Isha": isha,
        "SepertigaMalam": sepertigaMalam,
        "TengahMalam": tengahMalam,
        "DuapertigaMalam": duapertigaMalam,
        "method": new List<dynamic>.from(method.map((x) => x)),
    };
}

class Debug {
    String sunrise;
    String sunset;

    Debug({
        this.sunrise,
        this.sunset,
    });

    factory Debug.fromJson(Map<String, dynamic> json) => new Debug(
        sunrise: json["sunrise"],
        sunset: json["sunset"],
    );

    Map<String, dynamic> toJson() => {
        "sunrise": sunrise,
        "sunset": sunset,
    };
}

class Location {
    String latitude;
    String longitude;

    Location({
        this.latitude,
        this.longitude,
    });

    factory Location.fromJson(Map<String, dynamic> json) => new Location(
        latitude: json["latitude"],
        longitude: json["longitude"],
    );

    Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
    };
}

class Time {
    DateTime date;
    String time;
    String timezone;
    int offset;

    Time({
        this.date,
        this.time,
        this.timezone,
        this.offset,
    });

    factory Time.fromJson(Map<String, dynamic> json) => new Time(
        date: DateTime.parse(json["date"]),
        time: json["time"],
        timezone: json["timezone"],
        offset: json["offset"],
    );

    Map<String, dynamic> toJson() => {
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "time": time,
        "timezone": timezone,
        "offset": offset,
    };
}
