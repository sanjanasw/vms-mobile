import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomQrScanner extends StatefulWidget {
  static String routeName = '/QRScreen';
  @override
  State<CustomQrScanner> createState() => _CustomQrScannerState();
}

class _CustomQrScannerState extends State<CustomQrScanner> {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode barcode;
  QRViewController controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderRadius: 10,
              borderColor: Colors.green,
              borderLength: 20,
              borderWidth: 10,
              cutOutSize: MediaQuery.of(context).size.width * 0.8,
            ),
          ),
          // QRView(
          //   key: qrKey,
          //   onQRViewCreated: _onQRViewCreated,
          // ),
          (barcode != null)
              ? GestureDetector(
                  onTap: () {
                    _launchURL(barcode.code);
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white.withOpacity(1),
                    ),
                    child: Text(
                      barcode.code,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                )
              : Text('Scan a code'),
        ],
      ),
    );
  }

  // void _onQRViewCreated(QRViewController controller) {
  //   this.controller = controller;
  //   controller.scannedDataStream.listen((scanData) {
  //     setState(() {
  //       result = scanData;
  //     });
  //   });
  // }
  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((barcode) {
      setState(() {
        this.barcode = barcode;
      });
    });
  }
}
