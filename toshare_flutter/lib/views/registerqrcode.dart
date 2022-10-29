// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class RegQRCode extends StatefulWidget {
  const RegQRCode({Key? key}) : super(key: key);

  @override
  _RegQRCodeState createState() => _RegQRCodeState();
}

class _RegQRCodeState extends State<RegQRCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 24, 27, 28),
        title: Text("Register QRCode"),
      ),
      body: Container(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Scan the QRCode with your smartphone and complete the registration",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Center(
                child: Container(
                    width: 300,
                    height: 300,
                    child: Image.asset('asset/images/registerqrcode.png')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
