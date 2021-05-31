import 'dart:convert';

QueryResponse queryResponseFromJson(String str) => QueryResponse.fromJson(json.decode(str));

String queryResponseToJson(QueryResponse data) => json.encode(data.toJson());

class QueryResponse {
  QueryResponse({
    this.success,
    this.message,
  });

  int success;
  String message;

  factory QueryResponse.fromJson(Map<String, dynamic> json) => QueryResponse(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}