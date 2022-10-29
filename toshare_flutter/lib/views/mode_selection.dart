import 'package:flutter/material.dart';

class ModeSelection extends StatefulWidget {
  const ModeSelection({Key? key}) : super(key: key);

  @override
  _ModeSelectionState createState() => _ModeSelectionState();
}

class _ModeSelectionState extends State<ModeSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('ToShare')),
      backgroundColor: Color.fromARGB(200, 24, 27, 28),
      body: Center(
          child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Container(
                              width: 250,
                              height: 200,
                              color: Color.fromARGB(255, 24, 27, 28),
                              //child: Image.asset('asset/images/toshare.png')
                            ),
                          ),
                          Flexible(
                              child: InkWell(
                                  onTap: () {
                                    //Navigator.push(context,
                                    //MaterialPageRoute(builder: (context) => LoginPage()));
                                    Navigator.pushNamed(context, '/login');
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 10),
                                    child: const Center(
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                    height: 50,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                  ))),
                        ],
                      )),
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/register');
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 10),
                                  child: const Center(
                                    child: Text(
                                      "Register",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  height: 50,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(25)),
                                )),
                          ),
                          Flexible(
                              child: Container(
                                  width: 250,
                                  height: 200,
                                  //color: Color.fromARGB(255, 24, 27, 28))),
                                  child:
                                      Image.asset('asset/images/toshare.png'))),
                        ],
                      ))
                ],
              ))),
    );
  }
}
