import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;

  const SearchWidget({
    Key? key,
    required this.text,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();

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
              print('Here we need to insert the new user');
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
