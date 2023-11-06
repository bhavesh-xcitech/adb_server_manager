// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:adb_server_manager/features/alert_logs/models/connection_response.dart';
import 'package:equatable/equatable.dart';

class AlertLogs extends Equatable {
  final String? id;
  final String? name;
  final String? type;
  final String? ip;
  final String? status;
  final bool? server;
  final ConnectionResponse? connectionResponse;
  final String? createdAt;
  const AlertLogs({
    this.id,
    this.name,
    this.type,
    this.ip,
    this.status,
    this.server,
    this.connectionResponse,
    this.createdAt,
  });

  AlertLogs copyWith({
    String? id,
    String? name,
    String? type,
    String? ip,
    String? status,
    bool? server,
    ConnectionResponse? connectionResponse,
    String? createdAt,
  }) {
    return AlertLogs(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      ip: ip ?? this.ip,
      status: status ?? this.status,
      server: server ?? this.server,
      connectionResponse: connectionResponse ?? this.connectionResponse,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'name': name,
      'type': type,
      'ip': ip,
      'status': status,
      'server': server,
      'connection_response': connectionResponse?.toMap(),
      'created_at': createdAt,
    };
  }

  factory AlertLogs.fromMap(Map<String, dynamic> map) {
    return AlertLogs(
      id: map['_id'] != null ? map['_id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      ip: map['ip'] != null ? map['ip'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      server: map['server'] != null ? map['server'] as bool : null,
      connectionResponse: map['connection_response'] != null
          ? ConnectionResponse.fromMap(
              map['connection_response'] as Map<String, dynamic>)
          : null,
      createdAt:
          map['created_at'] != null ? (map['created_at'] as String) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AlertLogs.fromJson(String source) =>
      AlertLogs.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      name,
      type,
      ip,
      status,
      server,
      connectionResponse,
      createdAt,
    ];
  }
}

class CreatedAt {
  int? seconds;
  int? nanoseconds;
  CreatedAt({
    this.seconds,
    this.nanoseconds,
  });

  CreatedAt copyWith({
    int? seconds,
    int? nanoseconds,
  }) {
    return CreatedAt(
      seconds: seconds ?? this.seconds,
      nanoseconds: nanoseconds ?? this.nanoseconds,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'seconds': seconds,
      'nanoseconds': nanoseconds,
    };
  }

  factory CreatedAt.fromMap(Map<String, dynamic> map) {
    return CreatedAt(
      seconds: map['seconds'] != null ? map['seconds'] as int : null,
      nanoseconds:
          map['nanoseconds'] != null ? map['nanoseconds'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreatedAt.fromJson(String source) =>
      CreatedAt.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CreatedAt(seconds: $seconds, nanoseconds: $nanoseconds)';

  @override
  bool operator ==(covariant CreatedAt other) {
    if (identical(this, other)) return true;

    return other.seconds == seconds && other.nanoseconds == nanoseconds;
  }

  @override
  int get hashCode => seconds.hashCode ^ nanoseconds.hashCode;
}
