// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:toshare_flutter/service/http_service.dart';

HttpService service = HttpService();

class LogRFID extends StatefulWidget {
  const LogRFID({Key? key}) : super(key: key);

  @override
  _LogRFIDState createState() => _LogRFIDState();
}

class _LogRFIDState extends State<LogRFID> {
  @override
  Widget build(BuildContext context) {
    service.totemlogin(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Login with RFID"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Scan the RFID card to login",
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
                    width: 400,
                    height: 400,
                    child: Image.asset('asset/images/rfid3.png')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
