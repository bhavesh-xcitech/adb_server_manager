// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


import 'package:equatable/equatable.dart';

import 'package:adb_server_manager/features/server_list/models/pm2_env_model.dart';
import 'package:adb_server_manager/features/server_list/models/pm2_processinfo_model.dart';

class ServerLogs extends Equatable {
  final Pm2Env? pm2Env;
  final String? name;
  final Monitoring? monit;
  final int? pid;
  final TimeStamp? timestamp;
  const ServerLogs({
    this.pm2Env,
    this.name,
    this.monit,
    this.pid,
    this.timestamp,
  });

  @override
  // TODO: implement props
  List<Object?> get props {
    return [
      pm2Env,
      name,
      monit,
      pid,
      timestamp,
    ];
  }

  ServerLogs copyWith({
    Pm2Env? pm2Env,
    String? name,
    Monitoring? monit,
    int? pid,
    TimeStamp? timestamp,
  }) {
    return ServerLogs(
      pm2Env: pm2Env ?? this.pm2Env,
      name: name ?? this.name,
      monit: monit ?? this.monit,
      pid: pid ?? this.pid,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pm2_env': pm2Env?.toMap(),
      'name': name,
      'monit': monit?.toMap(),
      'pid': pid,
      'timestamp': timestamp,
    };
  }

  factory ServerLogs.fromMap(Map<String, dynamic> map) {
    return ServerLogs(
      pm2Env: map['pm2_env'] != null
          ? Pm2Env.fromMap(map['pm2_env'] as Map<String, dynamic>)
          : null,
      name: map['name'] != null ? map['name'] as String : null,
      monit: map['monit'] != null
          ? Monitoring.fromMap(map['monit'] as Map<String, dynamic>)
          : null,
      pid: map['pid'] != null ? map['pid'] as int : null,
     timestamp: map['timestamp'] != null
          ? TimeStamp.fromMap(map['timestamp'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServerLogs.fromJson(String source) =>
      ServerLogs.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}

class TimeStamp extends Equatable {
  final int? seconds;
  final int? nanoseconds;
  const TimeStamp({
    this.seconds,
    this.nanoseconds,
  });

  TimeStamp copyWith({
    int? seconds,
    int? nanoseconds,
  }) {
    return TimeStamp(
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

  factory TimeStamp.fromMap(Map<String, dynamic> map) {
    return TimeStamp(
      seconds: map['seconds'] != null ? map['seconds'] as int : null,
      nanoseconds: map['nanoseconds'] != null ? map['nanoseconds'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TimeStamp.fromJson(String source) => TimeStamp.fromMap(json.decode(source) as Map<String, dynamic>);

  

  @override
  List<Object?> get props => [seconds, nanoseconds];
}
