import 'dart:convert';

import 'package:adb_server_manager/features/alert_logs/models/connection_response.dart';

class DashBoardLogs {
  String? sId;
  String? name;
  String? type;
  String? ip;
  String? status;
  bool? server;
  ConnectionResponse? connectionResponse;
  int? iV;
  DashBoardLogs({
    this.sId,
    this.name,
    this.type,
    this.ip,
    this.status,
    this.server,
    this.connectionResponse,
    this.iV,
  });

  DashBoardLogs copyWith({
    String? sId,
    String? name,
    String? type,
    String? ip,
    String? status,
    bool? server,
    ConnectionResponse? connectionResponse,
    int? iV,
  }) {
    return DashBoardLogs(
      sId: sId ?? this.sId,
      name: name ?? this.name,
      type: type ?? this.type,
      ip: ip ?? this.ip,
      status: status ?? this.status,
      server: server ?? this.server,
      connectionResponse: connectionResponse ?? this.connectionResponse,
      iV: iV ?? this.iV,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': sId,
      'name': name,
      'type': type,
      'ip': ip,
      'status': status,
      'server': server,
      'connection_response': connectionResponse?.toMap(),
      '__v': iV,
    };
  }

  factory DashBoardLogs.fromMap(Map<String, dynamic> map) {
    return DashBoardLogs(
      sId: map['_id'] != null ? map['_id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      ip: map['ip'] != null ? map['ip'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      server: map['server'] != null ? map['server'] as bool : null,
      connectionResponse: map['connection_response'] != null
          ? ConnectionResponse.fromMap(
              map['connection_response'] as Map<String, dynamic>)
          : null,
      iV: map['__v'] != null ? map['__v'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DashBoardLogs.fromJson(String source) =>
      DashBoardLogs.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DashBoardLogs(_id: $sId, name: $name, type: $type, ip: $ip, status: $status, server: $server, connectionResponse: $connectionResponse, __v: $iV)';
  }

  @override
  bool operator ==(covariant DashBoardLogs other) {
    if (identical(this, other)) return true;

    return other.sId == sId &&
        other.name == name &&
        other.type == type &&
        other.ip == ip &&
        other.status == status &&
        other.server == server &&
        other.connectionResponse == connectionResponse &&
        other.iV == iV;
  }

  @override
  int get hashCode {
    return sId.hashCode ^
        name.hashCode ^
        type.hashCode ^
        ip.hashCode ^
        status.hashCode ^
        server.hashCode ^
        connectionResponse.hashCode ^
        iV.hashCode;
  }
}
