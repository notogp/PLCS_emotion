import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:toshare_flutter/service/constants.dart';
import 'package:toshare_flutter/service/classes.dart';
import 'package:toshare_flutter/widgets/searchwidgetcustomers.dart';
import 'package:toshare_flutter/service/http_service.dart';

//HttpService service = new HttpService();

class customerlist extends StatefulWidget {
  const customerlist({Key? key}) : super(key: key);
  @override
  _customerlistState createState() => _customerlistState();
}

class _customerlistState extends State<customerlist> {
  late String customerid;
  late String name;
  late String website;

  List<Customer> customers = [];
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
    final customers = await customerApi.getSearch(search);
    setState(() {
      this.customers = customers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 24, 27, 28),
        title: const Text(
          "Admin dashboard",
          textAlign: TextAlign.left,
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 30),
              Container(
                margin: const EdgeInsets.only(top: 30.0),
                child: const Text(
                  'Customer List',
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
              itemCount: customers.length,
              itemBuilder: (context, index) {
                final customer = customers[index];
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
                              "       " +
                              customer.name +
                              "       " +
                              customer.website,
                          style: const TextStyle(
                              //fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () async {
                                  customerid = customer.id.toString();
                                  name = customer.name;
                                  website = customer.website;
                                  print(customerid);

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
                                                service.editcustomer(customerid,
                                                    name, website, context);
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
                                                  initialValue: customer.name,
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
                                                              255,
                                                              215,
                                                              194,
                                                              6)),
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
                                                  initialValue:
                                                      customer.website,
                                                  obscureText: false,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                  decoration:
                                                      const InputDecoration(
                                                    hintText: 'website',
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
                                                      website = value;
                                                    });
                                                  },
                                                ),

                                                //email
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                )),
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
                                              int customerid = customer.id;
                                              service.removecustomer(
                                                  customerid, context);
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
                                          'Are you sure you want to delete this Customer?',
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
                        onTap: () {
                          if (customer.name == 'e-motion') {
                            Navigator.pushNamed(context, "/customerdashboard");
                          }
                        },
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

  Widget buildSearch() => SearchWidgetCustomer(
        text: search,
        hintText: 'Name',
        onChanged: searchCustomer,
      );

  Future searchCustomer(String search) async => debounce(() async {
        final customers = await customerApi.getSearch(search);

        if (!mounted) return;

        setState(() {
          this.customers = customers;
          this.search = search;
        });
      });
}

class customerApi {
  static Future<List<Customer>> getSearch(String search) async {
    final response = await http.post(Uri.parse(customerlistUrl));

    if (response.statusCode == 200) {
      final List customers = json.decode(response.body);
      return customers.map((json) => Customer.fromJson(json)).where((customer) {
        final nameLower = customer.name.toLowerCase();
        final websiteLower = customer.website.toLowerCase();
        final searchLower = search.toLowerCase();
        return nameLower.contains(searchLower) ||
            websiteLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
