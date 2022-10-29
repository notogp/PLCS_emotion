import 'package:flutter/material.dart';
import 'package:toshare_flutter/service/http_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late String name;
  late String surname;
  late String email;
  late String password;
  late String repassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Register Page')),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
//--------------------------------------------------------
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
//---------------------------------------------------------
              SizedBox(
                width: 400,
                child: TextField(
                  obscureText: false,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'name',
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
                      name = value;
                    });
                  },
                ),
              ),
              //---------------------------------------------------------
              SizedBox(
                width: 400,
                child: TextField(
                  obscureText: false,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'surname',
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
                      surname = value;
                    });
                  },
                ),
              ),

              //---------------------------------------------------------
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

              //---------------------------------------------------------
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
              SizedBox(
                width: 400,
                child: TextField(
                  obscureText: true,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'confirm password',
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
                      repassword = value;
                    });
                  },
                ),
              ),

              InkWell(
                  onTap: () {
                    HttpService service = new HttpService();
                    service.register(
                        name, surname, email, password, repassword, context);
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child: const Center(
                      child: Text(
                        "Register",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Color.fromARGB(255, 215, 194, 6)),
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
