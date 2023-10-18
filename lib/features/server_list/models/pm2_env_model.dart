import 'dart:convert';

class Pm2Env {
  int? port;
  int? createdAt;
  int? pmUpTime;
  String? status;
  String? nodeVersion;

  Pm2Env(
      {this.createdAt,
      this.pmUpTime,
      this.status,
      this.nodeVersion,
      this.port});

  Pm2Env copyWith({
    int? port,
    int? createdAt,
    int? pmUpTime,
    String? status,
    String? nodeVersion,
  }) {
    return Pm2Env(
      port: port ?? this.port,
      createdAt: createdAt ?? this.createdAt,
      pmUpTime: pmUpTime ?? this.pmUpTime,
      status: status ?? this.status,
      nodeVersion: nodeVersion ?? this.nodeVersion,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'port': port,
      'created_at': createdAt,
      'pm_uptime': pmUpTime,
      'status': status,
      'node_version': nodeVersion,
    };
  }

  factory Pm2Env.fromMap(Map<String, dynamic> map) {
    return Pm2Env(
      createdAt: map['created_at'] != null ? map['created_at'] as int : null,
      port: map['port'] != null ? map['port'] as int : null,
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
