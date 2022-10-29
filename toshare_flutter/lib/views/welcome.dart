import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(centerTitle: true, title: const Text('ToShare')),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Center(
                child: Container(
                    width: 700,
                    //height: 300,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('asset/images/e-motion.jpeg')),
              ),
            ),
            const SizedBox(height: 30),
            InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
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
                      border:
                          Border.all(color: Color.fromARGB(255, 215, 194, 6)),
                      color: Color.fromARGB(255, 24, 27, 28),
                      borderRadius: BorderRadius.circular(25)),
                )),
            InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/register');
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
      ),
    );
  }
}
