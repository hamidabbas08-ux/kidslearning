import 'dart:math';
import 'package:flutter/material.dart';

class AdsMascotService {
  static final AdsMascotService _instance = AdsMascotService._internal();
  factory AdsMascotService() => _instance;
  AdsMascotService._internal();

  final List<String> _mascotPraises = [
    "Amazing! You did it!",
    "Fantastic Try! Keep going!",
    "Wonderful! Let's learn more!"
  ];

  String getRandomPraise() {
    return _mascotPraises[Random().nextInt(_mascotPraises.length)];
  }

  Widget showBottomBannerAd() {
    return Container(
      width: double.infinity,
      height: 50,
      color: Colors.white12,
      child: const Center(
        child: Text(
          "Child-Safe Banner Ad",
          style: TextStyle(fontSize: 12, color: Colors.black38, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
