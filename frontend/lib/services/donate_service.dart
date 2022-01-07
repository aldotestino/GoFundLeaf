import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gofundleaf/models/donation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import 'notification_service.dart';

class DonateService {
  static final _uri = Platform.isAndroid
      ? 'http://10.0.2.2:8080/donate'
      : 'http://localhost:8080/donate';

  static Future<List<Donation>> donate(
      String googleId, int prevNumDonations) async {
    await launch(_uri + '?googleId=$googleId');

    // rimani in ascolto per sapere quando viene chiuso il browser
    await Future.delayed(const Duration(milliseconds: 100));
    while (
        WidgetsBinding.instance?.lifecycleState != AppLifecycleState.resumed) {
      await Future.delayed(const Duration(milliseconds: 100));
    }

    // fetch di tutte le donazioni, perchè non so se la transizione è andata a termine con successo
    final response = await http.get(
      Uri.parse(_uri + '/all?googleId=$googleId'),
    );

    List<Donation> newDonations = (jsonDecode(response.body) as List)
        .map((d) => Donation.fromJson(d))
        .toList();

    if (newDonations.length > prevNumDonations) {
      NotificationService.showNotification(
        title: 'GoFundLeaf',
        body:
            'Donazione di € ${newDonations[0].amt.toStringAsFixed(2)} effettuata con successo!',
      );
    }

    return newDonations;
  }
}
