import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:toshare_flutter/views/userdashboard.dart';
import 'package:toshare_flutter/views/userlist.dart';
import 'package:toshare_flutter/views/itemlist.dart';
import 'package:toshare_flutter/views/customerdashboard.dart';
import 'package:toshare_flutter/views/customerlist.dart';
import 'package:toshare_flutter/views/totem.dart';
import 'package:toshare_flutter/views/login.dart';
import 'package:toshare_flutter/views/register.dart';
import 'package:toshare_flutter/views/welcome.dart';
import 'package:toshare_flutter/views/registerqrcode.dart';
import 'package:toshare_flutter/views/loginrfid.dart';
import 'package:toshare_flutter/views/returnrfid.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  runApp(MyApp());
  setPathUrlStrategy(); //this function removes the /#/ from the url
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'e-motion',
      theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          scaffoldBackgroundColor: Color.fromARGB(255, 24, 27, 28)),
      home: WelcomePage(),
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      routes: {
        '/welcome': (context) => WelcomePage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/userdashboard': (context) => Userdashboard(),
        '/customerdashboard': (context) => Customerdashboard(),
        '/customerlist': (context) => customerlist(),
        '/userlist': (context) => userlist(),
        '/itemlist': (context) => itemlist(),
        '/totem': (context) => TotemPage(),
        '/registerqrcode': (context) => RegQRCode(),
        '/loginrfid': (context) => LogRFID(),
        '/returnrfid': (context) => RetRFID(),
      },
    );
  }
}


//C:\Users\Pk\OneDrive - Politecnico di Torino\Projects and and laboratory on comunication systems\common sources\gianpietro\ToShare\toshare_flask\venv