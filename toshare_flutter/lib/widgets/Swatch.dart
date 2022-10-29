// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:http/http.dart' as http;
import 'package:toshare_flutter/service/constants.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:toshare_flutter/service/http_service.dart';

HttpService service = HttpService();

class Swatch extends StatefulWidget {
  Swatch({Key? key, required this.startTime}) : super(key: key);
  DateTime startTime;

  @override
  State<Swatch> createState() => _SwatchState();
}

class _SwatchState extends State<Swatch> {
  final CustomTimerController _controller = CustomTimerController();

  @override
  Widget build(BuildContext context) {
    //print(widget.startTime);
    _controller.start();
    return Center(
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <
            Widget>[
      CustomTimer(
          controller: _controller,
          begin: DateTime.now().difference(widget.startTime),
          end: Duration(days: 365),
          builder: (remaining) {
            return Column(
              children: [
                Text(
                    "${remaining.days}d ${remaining.hours}h ${remaining.minutes}m ${remaining.seconds}s",
                    style: TextStyle(
                        fontSize: 24.0,
                        color: Color.fromARGB(255, 215, 194, 6))),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "€ ${((double.parse(remaining.days) * 60 * 24 + double.parse(remaining.hours) * 60 + double.parse(remaining.minutes)) * fee).toStringAsFixed(2)}",
                    style: TextStyle(
                        fontSize: 24.0,
                        color: Color.fromARGB(255, 215, 194, 6))),
              ],
            );
          }),
      SizedBox(width: 24.0),
      isTotem == true
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    child:
                        Text("Return", style: TextStyle(color: Colors.white)),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 24.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                    ),
                    onPressed: () async {
                      showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (param) {
                            return AlertDialog(
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, //Center Row contents horizontally,

                                children: [
                                  Container(
                                      width: 100,
                                      height: 100,
                                      child: Image.asset(
                                          'asset/images/rfid3.png')),
                                ],
                              ),
                              backgroundColor:
                                  const Color.fromARGB(255, 24, 27, 28),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0))),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 215, 194, 6),
                                        fontSize: 20),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Done',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 215, 194, 6),
                                        fontSize: 20),
                                  ),
                                ),
                              ],
                              title: const Text(
                                'Scan the RFID and assign it to the user',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            );
                          });
                      await service.update_rent_totem(context);
                      Navigator.pushNamed(context, "/userdashboard");
                    }
                    //onPressed: () => service.update_rent_user(),
                    )
              ],
            )
          : Flexible(
              child: Text("Please use a totem to rent an item.",
                  maxLines: 4,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                      color: Color.fromARGB(198, 134, 134, 134),
                      fontSize: 9,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w900,
                      letterSpacing: 3)),
            )
    ]));
  }
}
