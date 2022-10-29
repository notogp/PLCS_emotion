// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:toshare_flutter/widgets/top_bar_contents.dart';
import 'package:toshare_flutter/responsive/responsive.dart';
import 'package:toshare_flutter/responsive/mobile_body.dart';
import 'package:toshare_flutter/responsive/tablet_body.dart';
import 'package:toshare_flutter/responsive/desktop_body.dart';
import 'package:toshare_flutter/service/constants.dart';
import 'package:flutter_session/flutter_session.dart';

int maxindex = 5;

class Userdashboard extends StatefulWidget {
  Userdashboard({Key? key}) : super(key: key);

  @override
  _UserdashboardState createState() => _UserdashboardState();
}

class _UserdashboardState extends State<Userdashboard> {
  //Map<String, dynamic> rents_info = {};
  dynamic user_info;
  List<dynamic> user_rents =
      []; //not a var because this is a variable list of maps that is needed in the bodies

  Future init() async {
    var data;
    try {
      var user_id = await FlutterSession().get('user_id');
      var serial = await FlutterSession().get('serial');
      final response = await http.post(Uri.parse(userdashboardUrl),
          body: {'update_rent': 'false', 'user_id': user_id.toString()});

      if (response.statusCode == 200) {
        data = json.decode(response.body);
        setState(() {
          //print(data['user_info']);
          //print(data['user_rents']);
          this.user_info = data['user_info'];
          this.user_rents = data['user_rents'];
          isTotem = serial.toString() != 'default' ? true : false;
        });
        //print(this.user_rents);
      }
    } catch (err) {
      print(err);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    //var arg = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 50),
        child: TopBarContents(), //this is the navigation bar
      ),
      //endDrawer: MenuDrawer(),
      body: ResponsiveLayout(
        mobileBody:
            MobileBody(user_info: this.user_info, user_rents: this.user_rents),
        tabletBody:
            TabletBody(user_info: this.user_info, user_rents: this.user_rents),
        desktopBody: TabletBody(
            //for future implementations
            user_info: this.user_info,
            user_rents: this.user_rents),
      ),
    );
  }
}
