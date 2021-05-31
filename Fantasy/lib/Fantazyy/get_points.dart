import 'dart:convert';

GetPoints getPointsFromJson(String str) => GetPoints.fromJson(json.decode(str));

String getPointsToJson(GetPoints data) => json.encode(data.toJson());

class GetPoints {
  GetPoints({
    this.success,
    this.message,
    this.data,
  });

  int success;
  String message;
  List<Datum> data;

  factory GetPoints.fromJson(Map<String, dynamic> json) => GetPoints(
    success: json["success"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.points,
  });

  int points;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    points: json["points"],
  );

  Map<String, dynamic> toJson() => {
    "points": points,
  };
}