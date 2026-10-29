import 'package:flutter/material.dart';
import 'package:sumadhura/utils/time_stamp_formats.dart';

class TimeInfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const TimeInfoCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: Colors.grey.shade600),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        Expanded(
          child: Text(
            TimeStampFormats.formatTimestamp(value),
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
