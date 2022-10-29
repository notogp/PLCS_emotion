import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:toshare_flutter/service/constants.dart';

//HttpService service = new HttpService();

class Customerdashboard extends StatefulWidget {
  const Customerdashboard({Key? key}) : super(key: key);
  @override
  _customerdashboardState createState() => _customerdashboardState();
}

class _customerdashboardState extends State<Customerdashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 24, 27, 28),
      ),
      body: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 30),
              Container(
                margin: const EdgeInsets.only(top: 30.0),
                child: const Text(
                  'Customer Dashboard  e-motion',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 30),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
          ),
          const SizedBox(height: 30),
          InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/userlist');
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: const Center(
                  child: Text(
                    "Users list",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(255, 215, 194, 6)),
                    color: Color.fromARGB(255, 24, 27, 28),
                    borderRadius: BorderRadius.circular(15)),
              )),
          InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/itemlist');
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: const Center(
                  child: Text(
                    "Items list",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(255, 215, 194, 6)),
                    color: Color.fromARGB(255, 24, 27, 28),
                    borderRadius: BorderRadius.circular(15)),
              )),
          InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/userdashboard');
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: const Center(
                  child: Text(
                    "Login as User",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(255, 215, 194, 6)),
                    color: Color.fromARGB(255, 24, 27, 28),
                    borderRadius: BorderRadius.circular(15)),
              ))
        ],
      ),
    );
  }
}
