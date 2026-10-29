import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class VisitorQrCode extends StatelessWidget {
  final int? visitorId;

  const VisitorQrCode({super.key, required this.visitorId});

  @override
  Widget build(BuildContext context) {
    return QrImageView(
      data: "{id:$visitorId}",
      version: QrVersions.auto,
      size: 200,
      backgroundColor: Colors.white,
    );
  }
}
