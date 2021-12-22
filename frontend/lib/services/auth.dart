import 'dart:convert';
import 'dart:io';

import 'package:gofundleaf/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class Auth {
  static final _uri = Uri.parse(Platform.isIOS
      ? 'http://localhost:8080/auth/login'
      : 'http://10.0.2.2:8000/auth/login');

  static final _googleSignIn = GoogleSignIn();

  static Future<User?> login() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      return null;
    }

    final auth = await googleUser.authentication;

    final response = await http.post(
      _uri,
      body: json.encode(
        {'token': auth.idToken},
      ),
      headers: {'Content-Type': 'application/json'},
    );

    print(response.body);

    final user = User.fromJson(jsonDecode(response.body));

    return user;
  }

  static Future<GoogleSignInAccount?> logout() {
    return _googleSignIn.disconnect();
  }
}
