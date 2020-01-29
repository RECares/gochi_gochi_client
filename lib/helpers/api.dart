import 'package:http/http.dart' as http;
import 'package:inflection2/inflection2.dart';

import 'package:gochi_gochi_client/models/api_model.dart';
import 'package:gochi_gochi_client/models/user.dart';

/// Contains information related to the application API.
class Api {
  /// The base URI of the application API.
  static Uri get uri => Uri.parse('https://recares2019.herokuapp.com');

  /// Returns the URI access point for the type of given ApiType instance.
  ///
  /// @param model The ApiModel instance.
  ///
  /// @return The API URI access point for the instance's type.
  static Uri uriForType(ApiModel model) {
    var name = pluralize(model.runtimeType.toString());
    return Uri.parse(Api.uri.toString() + '/' + name);
  }

  /// Returns the URI access point for the given ApiModel instance.
  ///
  /// @param model The ApiModel instance.
  ///
  /// @return The API URI access point for the given instance.
  static Uri uriFor(ApiModel model) {
    var id = model.id.toString();
    return Uri.parse(Api.uriForType(model).toString() + '/' + id);
  }

  /// Gets the properties of an ApiModel instance from the API given its set ID.
  ///
  /// @param model The ApiModel.
  ///
  /// @return The API response.
  ///
  /// @post The instance's properties are set to the values received on success.
  static Future<http.Response> get(ApiModel model) async {
    var uri = Api.uriFor(model);
    var headers = {'Content-Type': 'application/json'};
    if (User.currentUser != null) {
      headers['X-User-Email'] = User.currentUser.email;
      headers['X-User-Token'] = User.currentUser.authenticationToken;
    }
    return await http.get(uri, headers: headers);
  }

  /// Posts an ApiModel instance to the API.
  ///
  /// @param model The ApiModel.
  ///
  /// @return The API response.
  ///
  /// @post The instance's properties are set to the values received on success.
  static Future<http.Response> post(ApiModel model) async {
    var uri = Api.uriForType(model);
    var headers = {'Content-Type': 'application/json'};
    if (User.currentUser != null) {
      headers['X-User-Email'] = User.currentUser.email;
      headers['X-User-Token'] = User.currentUser.authenticationToken;
    }
    var body = {model.runtimeType.toString(): model.toJson()};
    return await http.post(uri, headers: headers, body: body);
  }

  /// Patches an ApiModel instance in the API.
  ///
  /// @param model The ApiModel.
  ///
  /// @return The API response.
  ///
  /// @post The instance's properties are set to the values received on success.
  static Future<http.Response> patch(ApiModel model) async {
    var uri = Api.uriFor(model);
    var headers = {'Content-Type': 'application/json'};
    if (User.currentUser != null) {
      headers['X-User-Email'] = User.currentUser.email;
      headers['X-User-Token'] = User.currentUser.authenticationToken;
    }
    var body = {model.runtimeType.toString(): model.toJson()};
    return await http.patch(uri, headers: headers, body: body);
  }

  /// Deletes an ApiModel instance from the API.
  ///
  /// @param model The ApiModel.
  ///
  /// @return The API response.
  static Future<http.Response> delete(ApiModel model) async {
    var uri = Api.uriFor(model);
    var headers = {'Content-Type': 'application/json'};
    if (User.currentUser != null) {
      headers['X-User-Email'] = User.currentUser.email;
      headers['X-User-Token'] = User.currentUser.authenticationToken;
    }
    return await http.delete(uri, headers: headers);
  }
}
