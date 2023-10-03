// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class StartReqModel extends Equatable {
  final String? script;
  final String? name;
  final String? execMode;
  final String? incrementVar;
  final Env? env;
  const StartReqModel({
    this.script,
    this.name,
    this.execMode,
    this.incrementVar,
    this.env,
  });

  StartReqModel copyWith({
    String? script,
    String? name,
    String? execMode,
    String? incrementVar,
    Env? env,
  }) {
    return StartReqModel(
      script: script ?? this.script,
      name: name ?? this.name,
      execMode: execMode ?? this.execMode,
      incrementVar: incrementVar ?? this.incrementVar,
      env: env ?? this.env,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'script': script,
      'name': name,
      'exec_mode': execMode,
      'increment_var': incrementVar,
      'env': env?.toMap(),
    };
  }

  factory StartReqModel.fromMap(Map<String, dynamic> map) {
    return StartReqModel(
      script: map['script'] != null ? map['script'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      execMode: map['exec_mode'] != null ? map['exec_mode'] as String : null,
      incrementVar:
          map['increment_var'] != null ? map['increment_var'] as String : null,
      env: map['env'] != null
          ? Env.fromMap(map['env'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory StartReqModel.fromJson(String source) =>
      StartReqModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StartReqModel(script: $script, name: $name, exec_mode: $execMode, increment_var: $incrementVar, env: $env)';
  }

  @override
  // TODO: implement props
  List<Object?> get props => [incrementVar, script, name, execMode, env];
}

class Env {
  final int? port;
  Env({
    this.port,
  });

  Env copyWith({
    int? port,
  }) {
    return Env(
      port: port ?? this.port,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'port': port,
    };
  }

  factory Env.fromMap(Map<String, dynamic> map) {
    return Env(
      port: map['port'] != null ? map['port'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Env.fromJson(String source) =>
      Env.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Env(port: $port)';

  @override
  bool operator ==(covariant Env other) {
    if (identical(this, other)) return true;

    return other.port == port;
  }

  @override
  int get hashCode => port.hashCode;
}
