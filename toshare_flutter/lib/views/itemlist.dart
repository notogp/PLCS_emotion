import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:toshare_flutter/service/constants.dart';
import 'package:toshare_flutter/service/classes.dart';
import 'package:toshare_flutter/widgets/searchwidgetitems.dart';
import 'package:toshare_flutter/service/http_service.dart';

//HttpService service = new HttpService();

class itemlist extends StatefulWidget {
  const itemlist({Key? key}) : super(key: key);
  @override
  _itemlistState createState() => _itemlistState();
}

class _itemlistState extends State<itemlist> {
  //declaration of a list called usersFuture
  //after the declaration the function getUsers
  //is called and the list is generated after
  //an http request is made.
  // Future<List<User>> usersFuture = getUsers();
  late String itemid;
  late String bikeid;
  late String cardid;
  late String category;
  late String description;
  late String scanrfid;
  late String rfidvalue;
  List<Item> items = [];
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
    final items = await itemApi.getSearch(search);
    setState(() {
      this.items = items;
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
                  'Item List',
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
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
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
                                item.description +
                                "   " +
                                "Bike id: " +
                                item.bike_id,
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
                                  itemid = item.id.toString();
                                  bikeid = item.bike_id;
                                  cardid = item.card_id;
                                  category = item.category;
                                  description = item.description;
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
                                                service.edititem(
                                                    itemid,
                                                    bikeid,
                                                    cardid,
                                                    category,
                                                    description,
                                                    context);
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                'Add',
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 215, 194, 6),
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ],
                                          title: const Text(
                                            'Create new user',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                          content: SingleChildScrollView(
                                            child: Column(
                                              children: <Widget>[
                                                //Name
                                                TextFormField(
                                                  initialValue: item.bike_id,
                                                  obscureText: false,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                  decoration:
                                                      const InputDecoration(
                                                    hintText: 'bike id',
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
                                                              255,
                                                              215,
                                                              194,
                                                              6)),
                                                    ),
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      bikeid = value;
                                                    });
                                                  },
                                                ),
                                                const SizedBox(height: 10),

                                                //Surname
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 50,
                                                      width: 190,
                                                      child: TextFormField(
                                                        initialValue:
                                                            item.card_id,
                                                        obscureText: false,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                        decoration:
                                                            const InputDecoration(
                                                          hintText: 'card id',
                                                          hintStyle: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide: BorderSide(
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
                                                                        child: Image.asset(
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
                                                                            Radius.circular(15.0))),
                                                                actions: <
                                                                    Widget>[
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
                                                                title:
                                                                    const Text(
                                                                  'Scan the RFID and assign it to the item',
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
                                                        itemid =
                                                            item.id.toString();
                                                        rfidvalue =
                                                            await service
                                                                .readrfid(
                                                                    itemid,
                                                                    context);
                                                        await service
                                                            .updateitemrfid(
                                                                itemid,
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
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                        height: 45,
                                                        width: 90,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        215,
                                                                        194,
                                                                        6)),
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    24,
                                                                    27,
                                                                    28),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                TextFormField(
                                                  initialValue: item.category,
                                                  obscureText: false,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                  decoration:
                                                      const InputDecoration(
                                                    hintText:
                                                        'category EB or ES',
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
                                                              255,
                                                              215,
                                                              194,
                                                              6)),
                                                    ),
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      category = value;
                                                    });
                                                  },
                                                ),

                                                TextFormField(
                                                  initialValue:
                                                      item.description,
                                                  obscureText: false,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                  decoration:
                                                      const InputDecoration(
                                                    hintText: 'description',
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
                                                              255,
                                                              215,
                                                              194,
                                                              6)),
                                                    ),
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      description = value;
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
                                                int itemid = item.id;
                                                service.removeitem(
                                                    itemid, context);
                                                print('After delete');
                                                Navigator.pop(context);

                                                //after a time of 1 second we refresh the list with
                                                //the user removed
                                                Timer(
                                                    const Duration(seconds: 1),
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
                                            'Are you sure you want to delete this Item?',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        );
                                      });
                                },
                              )
                            ],
                          )),
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

  Widget buildSearch() => SearchWidgetItem(
        text: search,
        hintText: 'Name',
        onChanged: searchUser,
      );

  Future searchUser(String search) async => debounce(() async {
        final items = await itemApi.getSearch(search);

        if (!mounted) return;

        setState(() {
          this.items = items;
          this.search = search;
        });
      });
}

class itemApi {
  static Future<List<Item>> getSearch(String search) async {
    final response = await http.post(Uri.parse(itemlistUrl));

    if (response.statusCode == 200) {
      final List items = json.decode(response.body);
      return items.map((json) => Item.fromJson(json)).where((item) {
        final descriptionLower = item.description.toLowerCase();
        final bike_id_Lower = item.bike_id.toLowerCase();
        final searchLower = search.toLowerCase();
        return descriptionLower.contains(searchLower) ||
            bike_id_Lower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
