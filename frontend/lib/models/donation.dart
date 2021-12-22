class Donation {
  String date;
  num amt;

  Donation(this.date, this.amt);

  factory Donation.fromJson(dynamic json) {
    return Donation(json['date'] as String, json['amt'] as num);
  }

  @override
  String toString() {
    return '{ $date, $amt }';
  }
}
