// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  final String? PhoneNum;
  final String? token;
  const UserData({
    this.PhoneNum,
    this.token,
  });

  @override
  List<Object?> get props => [PhoneNum, token];

  UserData copyWith({
    String? PhoneNum,
    String? token,
  }) {
    return UserData(
      PhoneNum: PhoneNum ?? this.PhoneNum,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'PhoneNum': PhoneNum,
      'token': token,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      PhoneNum: map['PhoneNum'] != null ? map['PhoneNum'] as String : null,
      token: map['token'] != null ? map['token'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
