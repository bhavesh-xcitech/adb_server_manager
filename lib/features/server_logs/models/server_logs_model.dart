// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:adb_server_manager/features/server_logs/models/connection_response.dart';
import 'package:equatable/equatable.dart';

class ServerLogs extends Equatable {
  final String? id;
  final String? name;
  final String? type;
  final String? ip;
  final String? status;
  final bool? connections;
  // final ConnectionResponse? connectionResponse;
  final String? createdAt;
  const ServerLogs({
    this.id,
    this.name,
    this.type,
    this.ip,
    this.status,
    this.connections,
    // this.connectionResponse,
    this.createdAt,
  });

  ServerLogs copyWith({
    String? id,
    String? name,
    String? type,
    String? ip,
    String? status,
    bool? connections,
    // ConnectionResponse? connectionResponse,
    String? createdAt,
  }) {
    return ServerLogs(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      ip: ip ?? this.ip,
      status: status ?? this.status,
      connections: connections ?? this.connections,
      // connectionResponse: connectionResponse ?? this.connectionResponse,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'type': type,
      'ip': ip,
      'status': status,
      'connections': connections,
      // 'connectionResponse': connectionResponse?.toMap(),
      'created_at': createdAt,
    };
  }

  factory ServerLogs.fromMap(Map<String, dynamic> map) {
    return ServerLogs(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      ip: map['ip'] != null ? map['ip'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      connections:
          map['connections'] != null ? map['connections'] as bool : null,
      // connectionResponse: map['connectionResponse'] != null
      //     ? ConnectionResponse.fromMap(
      //         map['connectionResponse'] as Map<String, dynamic>)
      //     : null,
      createdAt: map['created_at'] != null ? map['created_at'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServerLogs.fromJson(String source) =>
      ServerLogs.fromMap(json.decode(source) as Map<String, dynamic>);

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
      connections,
      // connectionResponse,
      createdAt,
    ];
  }
}
