/// Represents the overall weather model, containing location and current weather details.
class WeatherModel {
  final Location? location;
  final Current? current;

  WeatherModel({this.location, this.current});

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
    location: json['location'] != null
        ? Location.fromJson(json['location'])
        : null,
    current: json['current'] != null
        ? Current.fromJson(json['current'])
        : null,
  );

  Map<String, dynamic> toJson() => {
    if (location != null) 'location': location!.toJson(),
    if (current != null) 'current': current!.toJson(),
  };
}

/// Represents the location details in the weather model.
class Location {
  final String? name;
  final String? region;
  final String? country;
  final double? lat;
  final double? lon;
  final String? tzId;
  final int? localtimeEpoch;
  final String? localtime;

  Location({
    this.name,
    this.region,
    this.country,
    this.lat,
    this.lon,
    this.tzId,
    this.localtimeEpoch,
    this.localtime,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    name: json['name'],
    region: json['region'],
    country: json['country'],
    lat: json['lat']?.toDouble(),
    lon: json['lon']?.toDouble(),
    tzId: json['tz_id'],
    localtimeEpoch: json['localtime_epoch'],
    localtime: json['localtime'],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'region': region,
    'country': country,
    'lat': lat,
    'lon': lon,
    'tz_id': tzId,
    'localtime_epoch': localtimeEpoch,
    'localtime': localtime,
  };
}

/// Represents the current weather details.
class Current {
  final int? lastUpdatedEpoch;
  final String? lastUpdated;
  final double? tempC;
  final double? tempF;
  final Condition? condition;
  final double? windKph;
  final double? pressureMb;
  final double? humidity;

  Current({
    this.lastUpdatedEpoch,
    this.lastUpdated,
    this.tempC,
    this.tempF,
    this.condition,
    this.windKph,
    this.pressureMb,
    this.humidity,
  });

  factory Current.fromJson(Map<String, dynamic> json) => Current(
    lastUpdatedEpoch: json['last_updated_epoch'],
    lastUpdated: json['last_updated'],
    tempC: json['temp_c']?.toDouble(),
    tempF: json['temp_f']?.toDouble(),
    condition: json['condition'] != null
        ? Condition.fromJson(json['condition'])
        : null,
    windKph: json['wind_kph']?.toDouble(),
    pressureMb: json['pressure_mb']?.toDouble(),
    humidity: json['humidity']?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'last_updated_epoch': lastUpdatedEpoch,
    'last_updated': lastUpdated,
    'temp_c': tempC,
    'temp_f': tempF,
    if (condition != null) 'condition': condition!.toJson(),
    'wind_kph': windKph,
    'pressure_mb': pressureMb,
    'humidity': humidity,
  };
}

/// Represents the weather condition details.
class Condition {
  final String? text;
  final String? icon;
  final int? code;

  Condition({this.text, this.icon, this.code});

  factory Condition.fromJson(Map<String, dynamic> json) => Condition(
    text: json['text'],
    icon: json['icon'],
    code: json['code'],
  );

  Map<String, dynamic> toJson() => {
    'text': text,
    'icon': icon,
    'code': code,
  };
}
