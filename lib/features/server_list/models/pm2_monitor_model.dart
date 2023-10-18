
import 'dart:convert';

import 'package:equatable/equatable.dart';

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
