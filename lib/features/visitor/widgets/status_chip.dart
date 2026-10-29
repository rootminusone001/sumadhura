import 'package:flutter/material.dart';

class StatusChip extends StatelessWidget {
  final String status;

  const StatusChip({super.key, required this.status});

  Color get backgroundColor {
    switch (status) {
      case 'Registered':
        return Colors.amber.shade100;
      case 'Checked In':
        return Colors.green.shade100;
      case 'Checked Out':
        return Colors.grey.shade200;
      default:
        return Colors.blueGrey.shade100;
    }
  }

  Color get foregroundColor {
    switch (status) {
      case 'Registered':
        return Colors.brown.shade800;
      case 'Checked In':
        return Colors.green.shade800;
      case 'Checked Out':
        return Colors.grey.shade800;
      default:
        return Colors.blueGrey.shade800;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: foregroundColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
