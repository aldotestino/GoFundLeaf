import 'package:flutter/material.dart';
import 'package:gofundleaf/models/donation.dart';

class DonationList extends StatelessWidget {
  final List<Donation> donations;

  const DonationList({Key? key, required this.donations}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: donations.length,
      separatorBuilder: (context, index) => const Divider(
        thickness: 1,
        color: Colors.grey,
      ),
      itemBuilder: (context, index) => ListTile(
        title: Padding(
          padding: const EdgeInsets.fromLTRB(4, 16, 4, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '€ ${donations[index].amt.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 30),
              ),
              Text(
                donations[index].date,
                style: const TextStyle(fontSize: 18),
              )
            ],
          ),
        ),
      ),
    );
  }
}
