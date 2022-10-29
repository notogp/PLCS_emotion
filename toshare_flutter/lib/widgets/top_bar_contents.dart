// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:toshare_flutter/service/constants.dart';
import 'package:flutter_session/flutter_session.dart';

class TopBarContents extends StatefulWidget {
  TopBarContents();

  @override
  _TopBarContentsState createState() => _TopBarContentsState();
}

class _TopBarContentsState extends State<TopBarContents> {
  final List<String> MenuEntries = [
    'Logout',
  ];

  final List _isHovering = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      color: Color.fromARGB(255, 24, 27, 28),
      child: Flex(direction: Axis.horizontal, children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  iconSize: 20.0,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'e-motion',
                  style: TextStyle(
                    color: Color.fromARGB(255, 215, 194, 6),
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 3,
                  ),
                ),
              ),
              Expanded(child: Container()),
              for (var i = 0; i < MenuEntries.length; i++) ...[
                InkWell(
                  onHover: (value) {
                    setState(() {
                      value ? _isHovering[i] = true : _isHovering[i] = false;
                    });
                  },
                  onTap: () async {
                    await FlutterSession().set("user_id", 0);
                    switch (MenuEntries[i]) {
                      case 'Logout':
                        //Navigator.pop(context);
                        if (isTotem == true) {
                          Navigator.pushNamed(context, '/totem');
                        } else {
                          Navigator.pushNamed(context, '/welcome');
                        }
                        break;
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: AlignmentDirectional.bottomCenter,
                        fit: StackFit.loose,
                        children: [
                          Positioned(
                            top: -1,
                            child: Visibility(
                              maintainAnimation: true,
                              maintainState: true,
                              maintainSize: true,
                              visible: _isHovering[i],
                              child: Container(
                                height: 30,
                                width: 52,
                                //color: Color.fromARGB(255, 215, 194, 6),
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(199, 39, 43, 44),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5))),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.exit_to_app_rounded,
                            color: _isHovering[i]
                                ? Color.fromARGB(255, 215, 194, 6)
                                : Color.fromARGB(255, 255, 255, 255),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                ),
              ],
            ],
          ),
        ),
      ]),
    );
    //);
  }
}
