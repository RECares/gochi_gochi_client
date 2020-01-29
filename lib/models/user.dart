import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

import 'package:gochi_gochi_client/helpers/api.dart';
import 'package:gochi_gochi_client/models/api_model.dart';

part 'user.g.dart';

@JsonSerializable()
class User implements ApiModel {
  /// The instance of the User currently signed in.
  static User currentUser;

  /// The API URI for sending sign-in requests.
  static Uri get signInUri => Uri.parse(Api.uri.toString() + '/users/sign_in');

  /// The API URI for sending sign-up requests.
  static Uri get signUpUri => Uri.parse(Api.uri.toString() + '/users');

  int id;

  @JsonKey(name: 'created_at')
  DateTime createdAt;

  @JsonKey(name: 'updated_at')
  DateTime updatedAt;

  /// The User email.
  String email;

  /// The User password.
  String password;

  /// The authentication token used in lieu of a password for API requests.
  @JsonKey(name: 'authentication_token')
  String authenticationToken;

  User(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.email,
      this.password,
      this.authenticationToken});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  /// Sign in the user.
  ///
  /// @post The static member `currentUser` is set to the caller on success.
  ///
  /// @return The API response.
  Future<http.Response> signIn() async {
    var headers = {'Content-Type': 'application/json'};
    var body = json.encode({
      'user': {'email': this.email, 'password': this.password}
    });
    var response =
        await http.post(User.signInUri, headers: headers, body: body);
    if (response.statusCode == 201) {
      var user = User.fromJson(json.decode(response.body));
      this.id = user.id;
      this.email = user.email;
      this.createdAt = user.createdAt;
      this.updatedAt = user.updatedAt;
      this.authenticationToken = user.authenticationToken;
      User.currentUser = user;
    }
    return response;
  }

  /// Sign up the user.
  ///
  /// @post The static member `currentUser` is set to the caller on success.
  ///
  /// @return The API response.
  Future<http.Response> signUp() async {
    var headers = {'Content-Type': 'application/json'};
    var body = json.encode({
      'user': {'email': this.email, 'password': this.password}
    });
    var response =
        await http.post(User.signUpUri, headers: headers, body: body);
    if (response.statusCode == 201) {
      var user = User.fromJson(json.decode(response.body));
      this.id = user.id;
      this.email = user.email;
      this.createdAt = user.createdAt;
      this.updatedAt = user.updatedAt;
      this.authenticationToken = user.authenticationToken;
      User.currentUser = user;
    }
    return response;
  }
}
