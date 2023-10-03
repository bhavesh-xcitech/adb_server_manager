// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class PM2ProcessInfo extends Equatable {
  final int? pId;
  final String? name;
  final Pm2Env? pm2Env;
  final Monitoring? monitoring;

  const PM2ProcessInfo({
    this.pId,
    this.name,
    this.pm2Env,
    this.monitoring,
  });

  PM2ProcessInfo copyWith({
    int? pId,
    final Pm2Env? pm2Env,
    final String? name,
    final Monitoring? monitoring,
  }) {
    return PM2ProcessInfo(
        name: name ?? this.name,
        pId: pId ?? this.pId,
        monitoring: monitoring ?? this.monitoring,
        pm2Env: pm2Env ?? this.pm2Env);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pid': pId,
      'name': name,
      'pm2_env': pm2Env,
      'monit': monitoring
    };
  }

  factory PM2ProcessInfo.fromMap(Map<String, dynamic> map) {
    return PM2ProcessInfo(
      pId: map['pid'] as int?,
      name: map['name'] as String?,
      monitoring: map['monit'] != null
          ? Monitoring.fromMap(map['monit'] as Map<String, dynamic>)
          : null,
      pm2Env: map['pm2_env'] != null
          ? Pm2Env.fromMap(map['pm2_env'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PM2ProcessInfo.fromJson(String source) =>
      PM2ProcessInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PM2ProcessInfo(pid: $pId,)';
  }

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class Pm2Env {
  int? createdAt;
  int? pmUpTime;
  String? status;
  String? nodeVersion;

  Pm2Env({this.createdAt, this.pmUpTime, this.status, this.nodeVersion});

  Pm2Env copyWith({
    int? createdAt,
    int? pmUpTime,
    String? status,
    String? nodeVersion,
  }) {
    return Pm2Env(
      createdAt: createdAt ?? this.createdAt,
      pmUpTime: pmUpTime ?? this.pmUpTime,
      status: status ?? this.status,
      nodeVersion: nodeVersion ?? this.nodeVersion,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'created_at': createdAt,
      'pm_uptime': pmUpTime,
      'status': status,
      'node_version': nodeVersion,
    };
  }

  factory Pm2Env.fromMap(Map<String, dynamic> map) {
    return Pm2Env(
      createdAt: map['created_at'] != null ? map['created_at'] as int : null,
      pmUpTime: map['pm_uptime'] != null ? map['pm_uptime'] as int : null,
      status: map['status'] != null ? map['status'] as String : null,
      nodeVersion:
          map['node_version'] != null ? map['node_version'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Pm2Env.fromJson(String source) =>
      Pm2Env.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Pm2Env(created_at: $createdAt, pmUpTime: $pmUpTime, status: $status)';
}

class Monitoring extends Equatable {
  final int? memory;
  final double? cpu;
  const Monitoring({
    this.memory,
    this.cpu,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [memory, cpu];

  Monitoring copyWith({
    final int? memory,
    final double? cpu,
  }) {
    return Monitoring(
      memory: memory ?? this.memory,
      cpu: cpu ?? this.cpu,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'memory': memory,
      'cpu': cpu,
    };
  }

  factory Monitoring.fromMap(Map<String, dynamic> map) {
    return Monitoring(
      memory: map['memory'] != null ? map['memory'] as int : null,
      cpu: map['cpu'] != null ? map['cpu'].toDouble() as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Monitoring.fromJson(String source) =>
      Monitoring.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
