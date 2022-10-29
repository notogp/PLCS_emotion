import 'package:flutter/material.dart';
import 'package:toshare_flutter/service/http_service.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:toshare_flutter/service/constants.dart';
import 'package:toshare_flutter/widgets/num_pad.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_session/flutter_session.dart';

class TotemPage extends StatefulWidget {
  const TotemPage({Key? key}) : super(key: key);

  @override
  _TotemPageState createState() => _TotemPageState();
}

class _TotemPageState extends State<TotemPage> {
  bool match = false;
  var data;

  Future init() async {
    try {
      await FlutterSession().set('serial', "0193cd");

      final response = await http.post(Uri.parse(base + '/totem'), body: {
        "link_request": 'false',
        "serial": "0193cd"
      }); //to add a real implementation

      if (response.statusCode == 200) {
        data = json.decode(response.body);
        print(data);
        if (data[0] == "Totem linked to customer") {
          setState(() {
            match = true;
          });
        }
        //if not linked match is false by default
      }
    } catch (err) {
      print('Error into link initialization response');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  Future link_totem() async {
    try {
      //final rent_info = await user_rents.getRents(userID);
      final response = await http.post(Uri.parse(base + '/totem'), body: {
        "link_request": 'true',
        "serial": "0193cd",
        "customer_code": _myController.text
      }); //to add a real implementation
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        if (data[0] == "Totem linked to customer") {
          EasyLoading.showSuccess(data[0]);
          setState(() {
            match = true;
          });
        } else if (data[0] == "Customer code doesn't exist") {
          EasyLoading.showError(data[0]);
        }
      }
    } catch (err) {
      print('Error');
    }
  }

  final TextEditingController _myController =
      TextEditingController(); //for the numpad

  @override
  Widget build(BuildContext context) {
    //if the post request of the serial number has a response with "match", then the standard scaffold can be returned, otherwise the numpad must be returned.

    return match != true
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 24, 27, 28),
              title: const Text('Totem not linked'),
              automaticallyImplyLeading: false,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // display the entered numbers
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: SizedBox(
                    height: 20,
                    child: Center(
                        child: TextField(
                      controller: _myController,
                      textAlign: TextAlign.center,
                      showCursor: false,
                      style: const TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 215, 194, 6)),
                      // Disable the default soft keybaord
                      keyboardType: TextInputType.none,
                      decoration: InputDecoration.collapsed(
                          hintText: 'Customer code',
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 61, 61, 61))),
                    )),
                  ),
                ),
                // implement the custom NumPad
                NumPad(
                  buttonSize: 50,
                  buttonColor: Color.fromARGB(255, 61, 61, 61),
                  iconColor: Color.fromARGB(255, 215, 194, 6),
                  controller: _myController,
                  delete: () {
                    _myController.text = _myController.text
                        .substring(0, _myController.text.length - 1);
                  },
                  // do something with the input numbers
                  onSubmit: () {
                    link_totem();
                    //showDialog(
                    //context: context,
                    //builder: (_) => AlertDialog(
                    //   content: Text(
                    //     data,
                    //     style: const TextStyle(fontSize: 30),
                    //   ),
                    // ));
                  },
                ),
              ],
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 24, 27, 28),
              centerTitle: true,
              title: const Text('e-motion'),
              automaticallyImplyLeading: false,
            ),
            body: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 1.0),
                    child: Center(
                      child: Container(
                          width: 450,
                          height: 150,
                          child: Image.asset('asset/images/e-motion.jpeg')),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .center, //Center Row contents horizontally,
                    crossAxisAlignment: CrossAxisAlignment
                        .center, //Center Column contents horizontally,

                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const SizedBox(height: 10),
                              InkWell(
                                  onTap: () async {
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
                                                const Color.fromARGB(
                                                    255, 24, 27, 28),
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15.0))),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 215, 194, 6),
                                                      fontSize: 20),
                                                ),
                                              ),
                                            ],
                                            title: const Text(
                                              'Scan the RFID and assign it to the user',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                          );
                                        });
                                    var rfidvalue =
                                        await service.totemlogin(context);
                                    await service.loginwithrfid(
                                        rfidvalue, context);
                                    //Navigator.pushNamed(context, "/loginrfid");
                                    //HttpService service = HttpService();
                                    //service.totemlogin(context);
                                    //Navigator.pushNamed(context, '/register');
                                  },
                                  child: Container(
                                    width: 250.0,
                                    height: 100.0,
                                    child: const Center(
                                      child: Text(
                                        "Click and scan your RFID",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2,
                                            color: Color.fromARGB(
                                                255, 215, 194, 6)),
                                        color: Color.fromARGB(255, 24, 27, 28),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                  onTap: () async {
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
                                                const Color.fromARGB(
                                                    255, 24, 27, 28),
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15.0))),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 215, 194, 6),
                                                      fontSize: 20),
                                                ),
                                              ),
                                            ],
                                            title: const Text(
                                              'Scan the RFID and assign it to the user',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                          );
                                        });
                                    await service.update_rent_totem(context);
                                    //await service.returnwithrfid(rfidvalue, context); <-------
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    width: 250.0,
                                    height: 100.0,
                                    child: const Center(
                                      child: Text(
                                        "Return the item",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2,
                                            color: Color.fromARGB(
                                                255, 215, 194, 6)),
                                        color: Color.fromARGB(255, 24, 27, 28),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                  )),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/registerqrcode');
                          },
                          child: Container(
                            width: 300.0,
                            height: 50.0,
                            child: const Center(
                              child: Text(
                                "Register",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2,
                                  color: Color.fromARGB(255, 215, 194, 6)),
                              color: Color.fromARGB(255, 24, 27, 28),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          )),
                    ],
                  )
                ],
              ),
            ),
          );
  }
}
