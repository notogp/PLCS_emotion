import 'package:flutter/material.dart';
import 'package:toshare_flutter/service/constants.dart';
import 'package:toshare_flutter/widgets/Swatch.dart';
import 'package:intl/intl.dart';
import 'package:toshare_flutter/service/http_service.dart';
import 'package:toshare_flutter/widgets/top_bar_contents.dart';

HttpService service = HttpService();

class MobileBody extends StatelessWidget {
  MobileBody({Key? key, required this.user_info, required this.user_rents})
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                // First row
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 45),
                        Container(
                          width: double.infinity,
                          child: Stack(
                            clipBehavior: Clip.none,
                            alignment: AlignmentDirectional.topCenter,
                            fit: StackFit.loose,
                            children: <Widget>[
                              Container(
                                height: 105,
                                width: double.infinity,
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
                                top: 60,
                                child: Row(
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
                                          SizedBox(width: 7),
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

                // second row
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // youtube video

                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 490),
                        child: Divider(
                          color: Color.fromARGB(255, 215, 194, 6),
                          thickness: 2,
                        ),
                      ),
                    ),

                    Padding(padding: const EdgeInsets.all(4)),
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
                        constraints:
                            const BoxConstraints(minWidth: 500, maxWidth: 500),
                        color: Color.fromARGB(200, 24, 27, 28),
                        height: 150,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              isRentActive == true
                                  ? Swatch(
                                      startTime: DateTime.parse(
                                          user_rents[0]['rent_date']))
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: isTotem == false
                                          ? [
                                              Center(
                                                child: Text(
                                                    "Please use a totem to rent an item.",
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            198, 134, 134, 134),
                                                        fontSize: 9,
                                                        fontFamily: 'Raleway',
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        letterSpacing: 3)),
                                              )
                                            ]
                                          : [
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
                        )),

                    // comment section & recommended videos
                    Padding(padding: const EdgeInsets.all(8)),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 500),
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
                            itemCount: user_rents.isEmpty == true
                                ? 1 //for the message of no previous rents
                                : isRentActive == true
                                    ? user_rents.length - 1
                                    : user_rents.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(0, 1, 0, 1),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Container(
                                          constraints: const BoxConstraints(
                                              maxWidth: 500),
                                          color:
                                              Color.fromARGB(255, 24, 27, 28),
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
                                                  /* DateFormat().format(
                                                          DateTime.parse(
                                                              user_rents[index][
                                                                  'rent_date'])), */
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 215, 194, 6),
                                                    fontSize: 9,
                                                    fontFamily: 'Raleway',
                                                    fontWeight: FontWeight.w900,
                                                    letterSpacing: 3,
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      isRentActive == true
                                                          ? user_rents[index +
                                                              1]['return_date']
                                                          : user_rents[index]
                                                              ['return_date'],
                                                      style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 215, 194, 6),
                                                        fontSize: 9,
                                                        fontFamily: 'Raleway',
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        letterSpacing: 3,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
