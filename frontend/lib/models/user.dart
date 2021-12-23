import 'donation.dart';

class User {
  String googleId;
  String name;
  String surname;
  String email;
  String? photoUrl;
  List<Donation> donations;

  User(this.googleId, this.name, this.surname, this.email, this.photoUrl,
      this.donations);

  factory User.fromJson(dynamic json) {
    return User(
      json['googleId'] as String,
      json['name'] as String,
      json['surname'] as String,
      json['email'] as String,
      json['photoUrl'] as String,
      (json['donations'] as List).map((d) => Donation.fromJson(d)).toList(),
    );
  }

  @override
  String toString() {
    return '{ $googleId, $name, $surname, $email, $photoUrl, $donations }';
  }
}
