// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:toshare_flutter/service/http_service.dart';

HttpService service = HttpService();

class RetRFID extends StatefulWidget {
  const RetRFID({Key? key}) : super(key: key);

  @override
  _RetRFIDState createState() => _RetRFIDState();
}

class _RetRFIDState extends State<RetRFID> {
  @override
  Widget build(BuildContext context) {
    service.update_rent_totem(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Scan the item RFID"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Scan your bike or scooter to return the rental",
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
