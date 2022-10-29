import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

class nfcandroid extends StatefulWidget {
  const nfcandroid({Key? key}) : super(key: key);

  @override
  _nfcandroidState createState() => _nfcandroidState();
}

class _nfcandroidState extends State<nfcandroid> {
  ValueNotifier<dynamic> result = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('NfcManager Plugin Example')),
        body: SafeArea(
          child: FutureBuilder<bool>(
            future: NfcManager.instance.isAvailable(),
            builder: (context, ss) => ss.data != true
                ? Center(child: Text('NfcManager.isAvailable(): ${ss.data}'))
                : Flex(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    direction: Axis.vertical,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Container(
                          margin: EdgeInsets.all(4),
                          constraints: BoxConstraints.expand(),
                          decoration: BoxDecoration(border: Border.all()),
                          child: SingleChildScrollView(
                            child: ValueListenableBuilder<dynamic>(
                              valueListenable: result,
                              builder: (context, value, _) => Text(
                                  '${value["mifareclassic"]["identifier"] ?? ''}'),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: GridView.count(
                          padding: EdgeInsets.all(4),
                          crossAxisCount: 2,
                          childAspectRatio: 4,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                          children: [
                            ElevatedButton(
                                child: Text('Tag Read'), onPressed: _tagRead),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  void _tagRead() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      result.value = tag.data;
      var identifier = result.value["mifareclassic"]["identifier"];
      NfcManager.instance.stopSession();
    });
  }
}
