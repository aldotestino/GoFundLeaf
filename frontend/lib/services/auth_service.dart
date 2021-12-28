import 'dart:convert';
import 'dart:io';

import 'package:gofundleaf/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static final _uri = Platform.isAndroid
      ? 'http://10.0.2.2:8080/auth'
      : 'http://localhost:8080/auth';

  static final _googleSignIn = GoogleSignIn();

  static Future<User?> login() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      return null;
    }

    final auth = await googleUser.authentication;

    try {
      final response = await http.post(
        Uri.parse('$_uri/login'),
        body: json.encode(
          {'token': auth.idToken},
        ),
        headers: {'Content-Type': 'application/json'},
      );

      return User.fromJson(jsonDecode(response.body));
    } catch (error) {
      print(error);
      return null;
    }
  }

  static Future<GoogleSignInAccount?> logout() {
    return _googleSignIn.disconnect();
  }

  static Future<bool> deleteProfile(String googleId) async {
    logout();

    try {
      final response = await http.delete(
        Uri.parse('$_uri/delete'),
        body: json.encode(
          {'googleId': googleId},
        ),
        headers: {'Content-Type': 'application/json'},
      );

      final jsonRes = jsonDecode(response.body);
      if (jsonRes['status'] == 'ok') {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print(error);
      return false;
    }
  }
}
