import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:toshare_flutter/views/welcome.dart';
import 'package:toshare_flutter/service/constants.dart';
import 'package:toshare_flutter/service/classes.dart';
import 'package:flutter_session/flutter_session.dart';

HttpService service = HttpService();

class HttpService {
  final _client = http.Client();
//  var _loginUrl = Uri.parse('http://192.168.217.104:5000/login');
//  var _registerUrl = Uri.parse('http://192.168.217.104:5000/register');

  login(email, password, context) async {
    //print("Dentro login");
    http.Response response = await _client.post(Uri.parse(loginUrl),
        body: {"email": email, "password": password});
    //print(response);
    if (response.statusCode == 200) {
      await FlutterSession().set("serial", "default");
      var json = jsonDecode(response.body);
      if (json[0] == 'Success User') {
        await FlutterSession().set('user_id', json[1]['user_id']);
        EasyLoading.showSuccess('Success');
        Navigator.pushReplacementNamed(context, "/userdashboard");
      } else if (json[0] == 'Success Customer') {
        await FlutterSession().set('user_id', json[1]['user_id']);
        Navigator.pushReplacementNamed(context, "/customerdashboard");
      } else if (json[0] == 'Success Admin') {
        await FlutterSession().set('user_id', json[1]['user_id']);
        EasyLoading.showSuccess('Success');
        //service.admindashboard(context);
        Navigator.pushReplacementNamed(context, "/customerlist");
      } else {
        EasyLoading.showError('Invalid Credentials');
      }
    } else {
      EasyLoading.showError("Error Code : ${response.statusCode.toString()}");
    }
  }

  register(name, surname, email, password, repassword, context) async {
    http.Response response = await _client.post(Uri.parse(registerUrl), body: {
      "name": name,
      "surname": surname,
      "email": email,
      "password": password,
      "rewrite password": repassword,
    });

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == 'success') {
        EasyLoading.showSuccess(json[0]);
        Navigator.pushReplacementNamed(
          context,
          "/welcome",
        );
      } else {
        EasyLoading.showSuccess(json[0]);

        Navigator.pushReplacementNamed(
          context,
          "/welcome",
        );
      }
    } else {
      await EasyLoading.showError(
          "Error Code : ${response.statusCode.toString()}");
    }
  }

  addcustomer(name, website, context) async {
    http.Response response = await _client.post(Uri.parse(addcustomerUrl),
        body: {"website_name": name, "website_address": website});

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == 'success') {
        EasyLoading.showSuccess(json[0]);
        Navigator.pushReplacementNamed(
          context,
          "/customerlist",
        );
      } else {
        EasyLoading.showSuccess(json[0]);
      }
    } else {
      await EasyLoading.showError(
          "Error Code : ${response.statusCode.toString()}");
    }
  }

  editcustomer(customerid, name, website, context) async {
    http.Response response = await _client.post(Uri.parse(editcustomerUrl),
        body: {
          "id": customerid,
          "website_name": name,
          "website_address": website
        });

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == 'success') {
        EasyLoading.showSuccess(json[0]);
        Navigator.pushReplacementNamed(
          context,
          "/customerlist",
        );
      } else {
        EasyLoading.showSuccess(json[0]);
      }
    } else {
      await EasyLoading.showError(
          "Error Code : ${response.statusCode.toString()}");
    }
  }

  adduser(name, surname, email, cardid, password, usertype, context) async {
    http.Response response = await _client.post(Uri.parse(adduserUrl), body: {
      "name": name,
      "surname": surname,
      "email": email,
      "cardid": cardid,
      "password": password,
      "usertype": usertype,
    });

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == 'success') {
        EasyLoading.showSuccess(json[0]);
        Navigator.pushReplacementNamed(
          context,
          "/userlist",
        );
      } else {
        EasyLoading.showSuccess(json[0]);
      }
    } else {
      await EasyLoading.showError(
          "Error Code : ${response.statusCode.toString()}");
    }
  }

  edituser(
      userid, name, surname, email, cardid, password, usertype, context) async {
    http.Response response = await _client.post(Uri.parse(edituserUrl), body: {
      "id": userid,
      "name": name,
      "surname": surname,
      "usr": email,
      "card_id": cardid,
      "pwd": password,
      "user_type": usertype,
    });

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == 'success') {
        EasyLoading.showSuccess(json[0]);
        Navigator.pushReplacementNamed(
          context,
          "/userlist",
        );
      } else {
        EasyLoading.showSuccess(json[0]);
      }
    } else {
      await EasyLoading.showError(
          "Error Code : ${response.statusCode.toString()}");
    }
  }

  additem(bikeid, cardid, category, description, context) async {
    http.Response response = await _client.post(Uri.parse(additemUrl), body: {
      "bike_id": bikeid,
      "card_id": cardid,
      "category": category,
      "description": description,
    });

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == 'success') {
        EasyLoading.showSuccess(json[0]);
        Navigator.pushReplacementNamed(
          context,
          "/itemlist",
        );
      } else {
        EasyLoading.showSuccess(json[0]);
      }
    } else {
      await EasyLoading.showError(
          "Error Code : ${response.statusCode.toString()}");
    }
  }

  edititem(itemid, bikeid, cardid, category, description, context) async {
    http.Response response = await _client.post(Uri.parse(edititemUrl), body: {
      "id": itemid,
      "bike_id": bikeid,
      "card_id": cardid,
      "category": category,
      "description": description,
    });

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == 'success') {
        EasyLoading.showSuccess(json[0]);
        Navigator.pushReplacementNamed(
          context,
          "/itemlist",
        );
      } else {
        EasyLoading.showSuccess(json[0]);
      }
    } else {
      await EasyLoading.showError(
          "Error Code : ${response.statusCode.toString()}");
    }
  }

  totemlogin(context) async {
    //var rfidvalue = "191728618729";
    http.Response response = await _client.post(Uri.parse(rfidUrl), body: {});
    var json = jsonDecode(response.body);
    var rfidvalue = json[0];
    if (response.statusCode == 200) {
      EasyLoading.showSuccess("Login...");
      return rfidvalue.toString();
    } else {
      var json = jsonDecode(response.body);
      EasyLoading.showError(json[0]);
    }
    return rfidvalue.toString();
  }

  loginwithrfid(rfidvalue, context) async {
    var serial = await FlutterSession().get('serial');
    http.Response response = await _client
        //final prefs = await SharedPreferences.getInstance();
        .post(Uri.parse(loginwithrfidUrl),
            body: {"rfidvalue": rfidvalue, "serial": serial.toString()});
    if (response.statusCode == 200) {
      //print(jsonDecode(response.body));
      var json = jsonDecode(response.body);
      //print(response.body);
      if (json[0] == 'Success User') {
        await FlutterSession().set('user_id', json[1]['user_id']);
        EasyLoading.showSuccess('Success');
        Navigator.pushReplacementNamed(context, "/userdashboard");
      } else if (json[0] == 'Success Customer') {
        await FlutterSession().set('user_id', json[1]['user_id']);
        Navigator.pushReplacementNamed(context, "/customerdashboard");
      } else if (json[0] == 'Success Admin') {
        await FlutterSession().set('user_id', json[1]['user_id']);
        EasyLoading.showSuccess('Success');
        //service.admindashboard(context);
        Navigator.pushReplacementNamed(context, "/customerlist");
      } else {
        EasyLoading.showError('Invalid Credentials');
      }
    } else {
      EasyLoading.showError("Error Code : ${response.statusCode.toString()}");
    }
  }

  removeuser(int userid, context) async {
    var usid = userid.toString();
    http.Response response =
        await _client.post(Uri.parse(removeuserUrl), body: {
      "id": userid.toString(),
    });
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == 'success') {
        EasyLoading.showSuccess(json[0]);
        //Navigator.pushReplacementNamed(context, "/admindashboard");
      } else {
        EasyLoading.showError(json[0]);
      }
    } else {
      await EasyLoading.showError(
          "Error Code : ${response.statusCode.toString()}");
    }
  }

  removecustomer(int customerid, context) async {
    var cusid = customerid.toString();
    http.Response response =
        await _client.post(Uri.parse(removecustomerUrl), body: {
      "id": customerid.toString(),
    });
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == 'success') {
        EasyLoading.showSuccess(json[0]);
        //Navigator.pushReplacementNamed(context, "/admindashboard");
      } else {
        EasyLoading.showError(json[0]);
      }
    } else {
      await EasyLoading.showError(
          "Error Code : ${response.statusCode.toString()}");
    }
  }

  removeitem(int itemid, context) async {
    var itid = itemid.toString();
    http.Response response =
        await _client.post(Uri.parse(removeitemUrl), body: {
      "id": itid.toString(),
    });
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == 'success') {
        EasyLoading.showSuccess(json[0]);
        //Navigator.pushReplacementNamed(context, "/admindashboard");
      } else {
        EasyLoading.showError(json[0]);
      }
    } else {
      await EasyLoading.showError(
          "Error Code : ${response.statusCode.toString()}");
    }
  }

  //this is responsible for returning an item from the userdashboard, with the use of the apposite button
  update_rent_user() async {
    try {
      var user_id = await FlutterSession().get('user_id');
      final response = await http.post(Uri.parse(rfidUrl));
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        var rfid = json[0].toString();

        final response2 = await http.post(Uri.parse(userdashboardUrl), body: {
          'rfid': rfid.toString(),
          'update_rent': 'true',
          'user_id': user_id.toString(),
          'date': DateTime.now().toString()
        });
        if (response2.statusCode == 200) {
          json = jsonDecode(response2.body);
          EasyLoading.showInfo(json);
        }
      }
    } catch (err) {
      print(err);
      print('Error into updating the rent state');
    }
  }

  //This is responsible for returning an item directly from the totem welcome screen
  update_rent_totem(context) async {
    try {
      final response = await http.post(Uri.parse(rfidUrl));
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        var rfid = json[0].toString();
        final response2 =
            await http.post(Uri.parse(base + '/totemreturnrent'), body: {
          'rfid': rfid.toString(),
          'update_rent': 'true',
          'date': DateTime.now().toString()
        });
        if (response2.statusCode == 200) {
          json = jsonDecode(response2.body);
          EasyLoading.showInfo(json);
        }
      }
    } catch (err) {
      print('Error into updating the rent state');
    }
  }

  readrfid(userid, context) async {
    print("Hi, i'm here ");
    http.Response rfid = await http.post(Uri.parse(rfidUrl));
    var json = jsonDecode(rfid.body);
    var rfidvalue = json[0].toString();
    return rfidvalue;
  }

  updateuserrfid(userid, rfidvalue, context) async {
    http.Response updateuserrfid =
        await http.post(Uri.parse(updateuserrfidUrl), body: {
      "userid": userid,
      "card_id": rfidvalue,
    });
    EasyLoading.showSuccess("RFID updated");
  }

  updateitemrfid(itemid, rfidvalue, context) async {
    http.Response updateuserrfid =
        await http.post(Uri.parse(updateitemrfidUrl), body: {
      "itemid": itemid,
      "card_id": rfidvalue,
    });
    EasyLoading.showSuccess("RFID updated");
  }
}

/*
http.Response response =
        await _client.post(Uri.parse(removeuserUrl), body: {
      "id": userid,
    });
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      print('Hello im here');

      if (json[0] == 'success') {
        print('SUCCESS');
        //EasyLoading.showSuccess(json[0]);
        //Navigator.pushReplacementNamed(context, "/admindashboard");
      } else {
        EasyLoading.showSuccess(json[0]);
      }
    } else {
      await EasyLoading.showError(
          "Error Code : ${response.statusCode.toString()}");
    }

*/