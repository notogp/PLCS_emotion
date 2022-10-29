import 'package:flutter/material.dart';
import 'package:toshare_flutter/service/http_service.dart';
import 'package:toshare_flutter/views/userlist.dart';

class SearchWidgetCustomer extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;

  const SearchWidgetCustomer({
    Key? key,
    required this.text,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  _SearchWidgetCustomerState createState() => _SearchWidgetCustomerState();
}

class _SearchWidgetCustomerState extends State<SearchWidgetCustomer> {
  final controller = TextEditingController();

  late String name;
  late String website;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.fromLTRB(
          16, 16, 16, 16), //padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  suffixIcon: widget.text.isNotEmpty
                      ? GestureDetector(
                          child: Icon(Icons.close, color: Colors.red),
                          onTap: () {
                            controller.clear();
                            widget.onChanged('');
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                        )
                      : null,
                  hintText: widget.hintText,
                  hintStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 215, 194, 6), width: 2))),
              style: TextStyle(color: Colors.white),
              onChanged: widget.onChanged,
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (param) {
                    return AlertDialog(
                      backgroundColor: const Color.fromARGB(255, 24, 27, 28),
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                                color: Color.fromARGB(255, 215, 194, 6),
                                fontSize: 20),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            HttpService service = new HttpService();
                            service.addcustomer(name, website, context);
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Add',
                            style: TextStyle(
                                color: Color.fromARGB(255, 215, 194, 6),
                                fontSize: 20),
                          ),
                        ),
                      ],
                      title: const Text(
                        'Create new user',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      content: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            //Name
                            TextField(
                              obscureText: false,
                              style: TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: 'name',
                                hintStyle: TextStyle(color: Colors.grey),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 65, 65, 65)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 215, 194, 6)),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  name = value;
                                });
                              },
                            ),

                            //Surname
                            TextField(
                              obscureText: false,
                              style: TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: 'website',
                                hintStyle: TextStyle(color: Colors.grey),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 65, 65, 65)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 215, 194, 6)),
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
            child: Container(
              child: const Center(
                child: Icon(
                  Icons.add,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromARGB(255, 215, 194, 6), width: 2),
                  color: Color.fromARGB(255, 24, 27, 28),
                  borderRadius: BorderRadius.circular(15)),
            ),
          ),
        ],
      ),
    );
  }
}
