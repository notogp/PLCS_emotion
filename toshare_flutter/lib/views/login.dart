import 'package:flutter/material.dart';
import 'package:toshare_flutter/service/http_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

HttpService service = HttpService();

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Center(
              child: Container(
                  width: 471,
                  height: 196,
                  /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                  child: Image.asset('asset/images/e-motion.jpeg')),
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: 400,
            child: TextField(
              obscureText: false,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'email',
                hintStyle: TextStyle(color: Colors.grey),
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 65, 65, 65)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 215, 194, 6)),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
          ),
          SizedBox(
            width: 400,
            child: TextField(
              obscureText: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'password',
                hintStyle: TextStyle(color: Colors.grey),
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 65, 65, 65)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 215, 194, 6)),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
            ),
          ),
          const SizedBox(height: 30),
          InkWell(
              onTap: () {
                //print(email);
                //print(password);
                service.login(email, password, context);
              },
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: const Center(
                  child: Text(
                    "Login",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(255, 215, 194, 6)),
                    color: Color.fromARGB(255, 24, 27, 28),
                    borderRadius: BorderRadius.circular(25)),
              ))
        ],
      ),
    )

        // ignore: avoid_unnecessary_containers
        );
  }
}
