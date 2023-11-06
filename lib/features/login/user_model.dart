// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  final String? phone;
  final Token? token;
  final String? id;
  const UserData({
    this.phone,
    this.token,
    this.id,
  });

  @override
  List<Object?> get props => [phone, token, id];

  UserData copyWith({
    String? phone,
    Token? token,
    String? id,
  }) {
    return UserData(
      phone: phone ?? this.phone,
      token: token ?? this.token,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'phone': phone,
      'token': token?.toMap(),
      'id': id,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      phone: map['phone'] != null ? map['phone'] as String : null,
      token: map['token'] != null
          ? Token.fromMap(map['token'] as Map<String, dynamic>)
          : null,
      id: map['id'] != null ? map['id'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}

class Token extends Equatable {
  final String? token;
  final bool? notificationEnable;
  const Token({
    this.token,
    this.notificationEnable,
  });

  Token copyWith({
    String? token,
    bool? notificationEnable,
  }) {
    return Token(
      token: token ?? this.token,
      notificationEnable: notificationEnable ?? this.notificationEnable,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'notification_enable': notificationEnable,
    };
  }

  factory Token.fromMap(Map<String, dynamic> map) {
    return Token(
      token: map['token'] != null ? map['token'] as String : null,
      notificationEnable: map['notification_enable'] != null
          ? map['notification_enable'] as bool
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Token.fromJson(String source) =>
      Token.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Token(token: $token, notification_enable: $notificationEnable)';

  @override
  // TODO: implement props
  List<Object?> get props => [token, notificationEnable];
}
