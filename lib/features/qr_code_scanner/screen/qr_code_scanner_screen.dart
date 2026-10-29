import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sumadhura/features/register_visitor/screen/register_visitor_screen.dart';

class QRCodeScannerScreen extends StatefulWidget {
  final bool isActive;
  const QRCodeScannerScreen({super.key, required this.isActive});

  @override
  State<QRCodeScannerScreen> createState() => _QRCodeScannerScreenState();
}

class _QRCodeScannerScreenState extends State<QRCodeScannerScreen> {
  final MobileScannerController _scannerController = MobileScannerController();

  bool _hasScanned = false;
  String? _scannedValue;

  @override
  void didUpdateWidget(covariant QRCodeScannerScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isActive && !oldWidget.isActive) {
      if (!_hasScanned) {
        _scannerController.start();
      }
    } else if (!widget.isActive && oldWidget.isActive) {
      _scannerController.stop();
    }
  }

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  void _handleBarcode(BarcodeCapture capture) {
    if (_hasScanned) return;

    for (final barcode in capture.barcodes) {
      final value = barcode.rawValue;

      if (value != null && value.trim().isNotEmpty) {
        setState(() {
          _hasScanned = true;
          _scannedValue = value;
        });

        _scannerController.stop();
        final match = RegExp(r'id\s*:\s*(\d+)').firstMatch(value);

        if (match != null) {
          final int visitorId = int.parse(match.group(1)!);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  RegisterVisitorScreen(isEditMode: true, visitorId: visitorId),
            ),
          );
        }
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Visitor Pass'),
        actions: [
          IconButton(
            tooltip: 'Toggle camera',
            icon: const Icon(Icons.cameraswitch_outlined),
            onPressed: () => _scannerController.switchCamera(),
          ),
          IconButton(
            tooltip: 'Toggle torch',
            icon: const Icon(Icons.flash_on_outlined),
            onPressed: () => _scannerController.toggleTorch(),
          ),
        ],
      ),

      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(24, 24, 24, 16),
            child: Column(
              children: [
                SizedBox(height: 8),
                Text(
                  'Place the visitor QR code inside the frame to scan.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.black,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  MobileScanner(
                    controller: _scannerController,
                    onDetect: _handleBarcode,
                  ),

                  // Dark overlay with a transparent scanning window.
                  IgnorePointer(
                    child: CustomPaint(
                      size: Size.infinite,
                      painter: _ScannerOverlayPainter(),
                    ),
                  ),

                  Positioned(
                    bottom: 28,
                    child: Text(
                      _hasScanned
                          ? 'QR code detected'
                          : 'Align the QR code within the frame',
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_scannedValue != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Scanned value: $_scannedValue',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _hasScanned = false;
                        _scannedValue = null;
                      });
                      _scannerController.start();
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Scan Again'),
                  ),
                ],
              ),
            )
          else
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Camera scanning is ready',
                style: TextStyle(color: Colors.black),
              ),
            ),
        ],
      ),
    );
  }
}

class _ScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const boxSize = 260.0;
    final box = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: boxSize,
      height: boxSize,
    );

    final overlayPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.60)
      ..style = PaintingStyle.fill;

    final background = Path()
      ..addRect(Offset.zero & size)
      ..addRRect(RRect.fromRectAndRadius(box, const Radius.circular(20)))
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(background, overlayPaint);

    final borderPaint = Paint()
      ..color = Colors.greenAccent
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawRRect(
      RRect.fromRectAndRadius(box, const Radius.circular(20)),
      borderPaint,
    );

    const cornerLength = 28.0;
    final cornerPaint = Paint()
      ..color = Colors.greenAccent
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    // Top-left
    canvas.drawLine(
      box.topLeft,
      box.topLeft + const Offset(cornerLength, 0),
      cornerPaint,
    );
    canvas.drawLine(
      box.topLeft,
      box.topLeft + const Offset(0, cornerLength),
      cornerPaint,
    );

    // Top-right
    canvas.drawLine(
      box.topRight,
      box.topRight + const Offset(-cornerLength, 0),
      cornerPaint,
    );
    canvas.drawLine(
      box.topRight,
      box.topRight + const Offset(0, cornerLength),
      cornerPaint,
    );

    // Bottom-left
    canvas.drawLine(
      box.bottomLeft,
      box.bottomLeft + const Offset(cornerLength, 0),
      cornerPaint,
    );
    canvas.drawLine(
      box.bottomLeft,
      box.bottomLeft + const Offset(0, -cornerLength),
      cornerPaint,
    );

    // Bottom-right
    canvas.drawLine(
      box.bottomRight,
      box.bottomRight + const Offset(-cornerLength, 0),
      cornerPaint,
    );
    canvas.drawLine(
      box.bottomRight,
      box.bottomRight + const Offset(0, -cornerLength),
      cornerPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
