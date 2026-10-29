import 'package:flutter/material.dart';

class UiEssential {
  static Color getStatusColor(String status) {
    switch (status) {
      case 'Registered':
        return Colors.orange;
      case 'Checked In':
        return Colors.green;
      case 'Checked Out':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
