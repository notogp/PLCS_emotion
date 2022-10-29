import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:toshare_flutter/service/constants.dart';
import 'package:toshare_flutter/service/classes.dart';
import 'package:toshare_flutter/widgets/searchwidgetusers.dart';
import 'package:toshare_flutter/service/http_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

//HttpService service = new HttpService();

class userlist extends StatefulWidget {
  const userlist({Key? key}) : super(key: key);
  @override
  _userlistState createState() => _userlistState();
}

class _userlistState extends State<userlist> {
  //declaration of a list called usersFuture
  //after the declaration the function getUsers
  //is called and the list is generated after
  //an http request is made.
  // Future<List<User>> usersFuture = getUsers();
  late String userid;
  late String name;
  late String surname;
  late String email;
  late String password;
  late String usertype;
  late String cardid;
  late String scanrfid;
  late String rfidvalue;
  List<User> users = [];
  String search = '';
  Timer? debouncer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 500),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    final users = await userApi.getSearch(search);
    setState(() {
      this.users = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 24, 27, 28),
      ),
      body: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 30),
              Container(
                margin: const EdgeInsets.only(top: 30.0),
                child: const Text(
                  'User List',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 30),
                ),
              ),
            ],
          ),
          buildSearch(),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return SizedBox(
                  height: 80,
                  child: Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    color: const Color.fromARGB(255, 24, 27, 28),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          color: Color.fromARGB(255, 215, 194, 6), width: 2),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Center(
                      child: ListTile(
                        leading: const CircleAvatar(
                          radius: 28,
                        ),
                        title: Text(
                          (index + 1).toString() +
                              ".  " +
                              user.surname +
                              " " +
                              user.name +
                              "    " +
                              user.user_type,
                          style: const TextStyle(
                              //fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                              onPressed: () async {
                                userid = user.id.toString();
                                name = user.name;
                                surname = user.surname;
                                email = user.usr;
                                cardid = user.card_id;
                                password = user.pwd;
                                usertype = user.user_type;
                                showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (param) {
                                      return AlertDialog(
                                        backgroundColor: const Color.fromARGB(
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
                                          TextButton(
                                            onPressed: () async {
                                              HttpService service =
                                                  new HttpService();
                                              service.edituser(
                                                  userid,
                                                  name,
                                                  surname,
                                                  email,
                                                  cardid,
                                                  password,
                                                  usertype,
                                                  context);
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              'Edit',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 215, 194, 6),
                                                  fontSize: 20),
                                            ),
                                          ),
                                        ],
                                        title: const Text(
                                          'Edit user',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                        content: SingleChildScrollView(
                                          child: Column(
                                            children: <Widget>[
                                              //Name
                                              TextFormField(
                                                initialValue: user.name,
                                                obscureText: false,
                                                style: TextStyle(
                                                    color: Colors.white),
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: 'name',
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            255, 65, 65, 65)),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            255, 215, 194, 6)),
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    name = value;
                                                  });
                                                },
                                              ),

                                              //Surname
                                              TextFormField(
                                                initialValue: user.surname,
                                                obscureText: false,
                                                style: TextStyle(
                                                    color: Colors.white),
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: 'surname',
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            255, 65, 65, 65)),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            255, 215, 194, 6)),
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    surname = value;
                                                  });
                                                },
                                              ),

                                              //email
                                              TextFormField(
                                                initialValue: user.usr,
                                                obscureText: false,
                                                style: TextStyle(
                                                    color: Colors.white),
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: 'email',
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            255, 65, 65, 65)),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            255, 215, 194, 6)),
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    email = value;
                                                  });
                                                },
                                              ),
                                              const SizedBox(height: 10),

                                              Row(
                                                children: [
                                                  Container(
                                                    height: 50,
                                                    width: 190,
                                                    child: TextFormField(
                                                      initialValue:
                                                          user.card_id,
                                                      obscureText: false,
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                      decoration:
                                                          const InputDecoration(
                                                        hintText: 'card id',
                                                        hintStyle: TextStyle(
                                                            color: Colors.grey),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          65,
                                                                          65,
                                                                          65)),
                                                        ),
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          215,
                                                                          194,
                                                                          6)),
                                                        ),
                                                      ),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          cardid = value;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  InkWell(
                                                    onTap: () async {
                                                      showDialog(
                                                          context: context,
                                                          barrierDismissible:
                                                              true,
                                                          builder: (param) {
                                                            return AlertDialog(
                                                              content: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center, //Center Row contents horizontally,

                                                                children: [
                                                                  Container(
                                                                      width:
                                                                          100,
                                                                      height:
                                                                          100,
                                                                      child: Image
                                                                          .asset(
                                                                              'asset/images/rfid3.png')),
                                                                ],
                                                              ),
                                                              backgroundColor:
                                                                  const Color
                                                                          .fromARGB(
                                                                      255,
                                                                      24,
                                                                      27,
                                                                      28),
                                                              shape: const RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              15.0))),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context),
                                                                  child:
                                                                      const Text(
                                                                    'Cancel',
                                                                    style: TextStyle(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            215,
                                                                            194,
                                                                            6),
                                                                        fontSize:
                                                                            20),
                                                                  ),
                                                                ),
                                                                TextButton(
                                                                  onPressed:
                                                                      () async {
                                                                    Navigator.pop(
                                                                        context);
                                                                    Navigator.pop(
                                                                        context);
                                                                    init();
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                    'Done',
                                                                    style: TextStyle(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            215,
                                                                            194,
                                                                            6),
                                                                        fontSize:
                                                                            20),
                                                                  ),
                                                                ),
                                                              ],
                                                              title: const Text(
                                                                'Scan the RFID and assign it to the user',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20),
                                                              ),
                                                            );
                                                          });
                                                      HttpService service =
                                                          new HttpService();
                                                      userid =
                                                          user.id.toString();
                                                      rfidvalue = await service
                                                          .readrfid(
                                                              userid, context);
                                                      await service
                                                          .updateuserrfid(
                                                              userid,
                                                              rfidvalue,
                                                              context);
                                                    },
                                                    child: Container(
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5,
                                                          vertical: 5),
                                                      child: const Center(
                                                        child: Text(
                                                          "Scan RFID",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                      height: 45,
                                                      width: 90,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  215,
                                                                  194,
                                                                  6)),
                                                          color: const Color
                                                                  .fromARGB(
                                                              255, 24, 27, 28),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              //password
                                              TextFormField(
                                                initialValue: user.pwd,
                                                obscureText: false,
                                                style: TextStyle(
                                                    color: Colors.white),
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: 'password',
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            255, 65, 65, 65)),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            255, 215, 194, 6)),
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    password = value;
                                                  });
                                                },
                                              ),

                                              TextFormField(
                                                initialValue: user.user_type,
                                                obscureText: false,
                                                style: TextStyle(
                                                    color: Colors.white),
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: 'user type',
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            255, 65, 65, 65)),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            255, 215, 194, 6)),
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    usertype = value;
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              onPressed: () async {
                                showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (param) {
                                      return AlertDialog(
                                        backgroundColor: const Color.fromARGB(
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
                                          TextButton(
                                            onPressed: () async {
                                              HttpService service =
                                                  new HttpService();
                                              //print(user.id);
                                              int userid = user.id;
                                              service.removeuser(
                                                  userid, context);
                                              print('After delete');
                                              Navigator.pop(context);

                                              //after a time of 1 second we refresh the list with
                                              //the user removed
                                              Timer(const Duration(seconds: 1),
                                                  () {
                                                init();
                                              });
                                            },
                                            child: const Text(
                                              'Delete',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 215, 194, 6),
                                                  fontSize: 20),
                                            ),
                                          ),
                                        ],
                                        title: const Text(
                                          'Are you sure you want to delete this User?',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      );
                                    });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget buildSearch() => SearchWidget(
        text: search,
        hintText: 'Name',
        onChanged: searchUser,
      );

  Future searchUser(String search) async => debounce(() async {
        final users = await userApi.getSearch(search);

        if (!mounted) return;

        setState(() {
          this.users = users;
          this.search = search;
        });
      });
}

class userApi {
  static Future<List<User>> getSearch(String search) async {
    final response = await http.post(Uri.parse(userlistUrl));

    if (response.statusCode == 200) {
      final List users = json.decode(response.body);
      return users.map((json) => User.fromJson(json)).where((user) {
        final nameLower = user.name.toLowerCase();
        final surnameLower = user.surname.toLowerCase();
        final emailLower = user.usr.toLowerCase();
        final searchLower = search.toLowerCase();
        return nameLower.contains(searchLower) ||
            surnameLower.contains(searchLower) ||
            emailLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
