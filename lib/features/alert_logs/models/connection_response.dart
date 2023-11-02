// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ConnectionResponse {
   bool? redis;
  String? random;
  List<dynamic>? notes;
  String? app;
  bool? mongodb;
  ConnectionResponse({
    this.redis,
    this.random,
    this.notes,
    this.app,
    this.mongodb,
  });

  ConnectionResponse copyWith({
    bool? redis,
    String? random,
    List<dynamic>? notes,
    String? app,
    bool? mongodb,
  }) {
    return ConnectionResponse(
      redis: redis ?? this.redis,
      random: random ?? this.random,
      notes: notes ?? this.notes,
      app: app ?? this.app,
      mongodb: mongodb ?? this.mongodb,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'redis': redis,
      'random': random,
      'notes': notes,
      'app': app,
      'mongodb': mongodb,
    };
  }

  factory ConnectionResponse.fromMap(Map<String, dynamic> map) {
    return ConnectionResponse(
      redis: map['redis'] != null ? map['redis'] as bool : null,
      random: map['random'] != null ? map['random'] as String : null,
      notes: map['notes'] != null ? List<dynamic>.from((map['notes'] as List<dynamic>)) : null,
      app: map['app'] != null ? map['app'] as String : null,
      mongodb: map['mongodb'] != null ? map['mongodb'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConnectionResponse.fromJson(String source) => ConnectionResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ConnectionResponse(redis: $redis, random: $random, notes: $notes, app: $app, mongodb: $mongodb)';
  }

  @override
  bool operator ==(covariant ConnectionResponse other) {
    if (identical(this, other)) return true;
  
    return 
      other.redis == redis &&
      other.random == random &&
      listEquals(other.notes, notes) &&
      other.app == app &&
      other.mongodb == mongodb;
  }

  @override
  int get hashCode {
    return redis.hashCode ^
      random.hashCode ^
      notes.hashCode ^
      app.hashCode ^
      mongodb.hashCode;
  }
}
