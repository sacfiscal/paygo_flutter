// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AccessTokenModel {
  String? accessToken;
  String? tokenType;
  String? scope;
  int? expiresIn;

  AccessTokenModel({
    required this.accessToken,
    required this.tokenType,
    required this.scope,
    required this.expiresIn,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'access_token': accessToken,
      'token_type': tokenType,
      'scope': scope,
      'expires_in': expiresIn,
    };
  }

  factory AccessTokenModel.fromMap(Map<String, dynamic> map) {
    return AccessTokenModel(
      accessToken: map['access_token'] as String,
      tokenType: map['token_type'] as String,
      scope: map['scope'] as String,
      expiresIn: map['expires_in'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory AccessTokenModel.fromJson(String source) =>
      AccessTokenModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant AccessTokenModel other) {
    if (identical(this, other)) return true;

    return other.accessToken == accessToken &&
        other.tokenType == tokenType &&
        other.scope == scope &&
        other.expiresIn == expiresIn;
  }

  @override
  int get hashCode {
    return accessToken.hashCode ^ tokenType.hashCode ^ scope.hashCode ^ expiresIn.hashCode;
  }
}
