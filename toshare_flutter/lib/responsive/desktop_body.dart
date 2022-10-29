// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:toshare_flutter/widgets/Swatch.dart';

class DesktopBody extends StatelessWidget {
  DesktopBody({Key? key, required this.user_info, required this.user_rents})
      : super(key: key);
  var user_info;
  List<dynamic> user_rents = [];

  @override
  Widget build(BuildContext context) {
    bool isRentActive = false;
    if (user_rents.isNotEmpty) {
      //print(user_rents[0]['return_date']);
      isRentActive = user_rents[0]['return_date'] == 'None' ? true : false;
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(199, 39, 43, 44),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 320,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Recent rents',
                          style: TextStyle(
                            color: Color.fromARGB(255, 215, 194, 6),
                            fontSize: 12,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w900,
                            letterSpacing: 3,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Rent date',
                              style: TextStyle(
                                color: Color.fromARGB(255, 215, 194, 6),
                                fontSize: 10,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w900,
                                letterSpacing: 3,
                              ),
                            ),
                            Text(
                              'Return date',
                              style: TextStyle(
                                color: Color.fromARGB(255, 215, 194, 6),
                                fontSize: 10,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w900,
                                letterSpacing: 3,
                              ),
                            ),
                          ],
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                              user_rents.length > 4 ? 4 : user_rents.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(0, 1, 0, 1),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Container(
                                        constraints:
                                            const BoxConstraints(maxWidth: 500),
                                        color: Color.fromARGB(255, 24, 27, 28),
                                        height: 70,
                                        child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  isRentActive == true
                                                      ? user_rents[index + 1]
                                                          ['rent_date']
                                                      : user_rents[index]
                                                          ['rent_date'],
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 215, 194, 6),
                                                    fontSize: 9,
                                                    fontFamily: 'Raleway',
                                                    fontWeight: FontWeight.w900,
                                                    letterSpacing: 3,
                                                  ),
                                                ),
                                                Text(
                                                  isRentActive == true
                                                      ? user_rents[index + 1]
                                                          ['return_date']
                                                      : user_rents[index]
                                                          ['return_date'],
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 215, 194, 6),
                                                    fontSize: 9,
                                                    fontFamily: 'Raleway',
                                                    fontWeight: FontWeight.w900,
                                                    letterSpacing: 3,
                                                  ),
                                                ),
                                              ],
                                            ))),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
              // First column
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 500,
                        ),
                        child: Column(children: [
                          Text(
                            'Active rent',
                            style: TextStyle(
                              color: Color.fromARGB(255, 215, 194, 6),
                              fontSize: 12,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w900,
                              letterSpacing: 3,
                            ),
                          ),
                          Container(
                            color: Color.fromARGB(255, 24, 27, 28),
                            height: 200,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  isRentActive == true
                                      ? Swatch(
                                          startTime: DateTime.parse(
                                              user_rents[0]['rent_date']))
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            TextButton(
                                              child: Text("Rent an item",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              style: TextButton.styleFrom(
                                                backgroundColor: Colors.green,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 12.0,
                                                    horizontal: 24.0),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0)),
                                              ),
                                              onPressed: () =>
                                                  service.update_rent_user(),
                                            )
                                          ],
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ])),
                  ],
                ),
              ),
              // second column
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 50),
                      Container(
                        width: 200,
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: AlignmentDirectional.topCenter,
                          fit: StackFit.loose,
                          children: <Widget>[
                            Container(
                              height: 400,
                              width: 200,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 24, 27, 28),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20))),
                            ),
                            Positioned(
                              top: -50,
                              child: CircleAvatar(
                                radius: 50,
                                //child: SizedBox(
                                //   width: 60,
                                //   height: 60,
                                //child: ClipOval(
                                // child: Image.asset(
                                //  "asset/images/rfid.jpg",
                                // ),
                                //))

                                backgroundImage: AssetImage(
                                    'asset/images/profile_pics/devil-duck.jpg'),
                              ),
                            ),
                            Positioned(
                              top: 55,
                              child: Column(
                                children: user_info == null
                                    ? []
                                    : [
                                        Text(
                                          user_info['name'].toString(),
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 215, 194, 6),
                                            fontSize: 11,
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.w900,
                                            letterSpacing: 3,
                                          ),
                                        ),
                                        Text(
                                          user_info['surname'].toString(),
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 215, 194, 6),
                                            fontSize: 11,
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.w900,
                                            letterSpacing: 3,
                                          ),
                                        ),
                                      ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
