import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ReportNetwork {
  static Future<void> addreport1({
    required availableTripID,
    required boardingPointId,
    required droppingPointId,
    required destination,
    required source,
    required userid,
    required franid,
    //pass1
    required fare,
    required ladiesSeat,
    required age,
//required address,
    required email,
    required gender,
    required idNumber,
    required mobile,
    required name,
    required primary,
    required title,
    required seatName,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final franid = sharedPreferences.getString('fran_id');
    final userid = sharedPreferences.getString('userdbid');
    log(franid.toString());
    log(userid.toString());

    var bodyParams = {
      "availableTripID": availableTripID,
      "boardingPointId": boardingPointId,
      "destination": destination,
      "droppingPointId": droppingPointId,
      "source": source,
      "user_id": userid,
      "franch_id": franid,
      "inventory": jsonEncode([
        {
          "fare": fare,
          "ladiesSeat": ladiesSeat,
          "passenger": {
            "address": "some address",
            "age": age,
            "email": email,
            "gender": gender,
            "idNumber": idNumber,
            "idType": "PAN_CARD",
            "mobile": mobile,
            "name": name,
            "primary": primary,
            "title": "Mr"
          },
          "seatName": seatName
        }
      ])
    };

    // log(json.toString());
    final url = Uri.parse('https://tictechnologies.in/stage/redbus/BlockReq');

    final resp = await http.post(url, body: bodyParams);
    log(resp.statusCode.toString());
    log(resp.body.toString());
  }

  static Future<void> addreport2({
    required availableTripID,
    required boardingPointId,
    required droppingPointId,
    required destination,
    required source,
    required userid,
    required franid,
    //pass1
    required fare,
    required ladiesSeat,
    required age,
    required address,
    required email,
    required gender,
    required idNumber,
    required mobile,
    required name,
    required primary,
    required title,
    required seatName,
    //pass2
    required fare2,
    required ladiesSeat2,
    required age2,
    required address2,
    required email2,
    required gender2,
    required idNumber2,
    required mobile2,
    required name2,
    required primary2,
    required title2,
    required seatName2,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final franid = sharedPreferences.getString('fran_id');
    final userid = sharedPreferences.getString('userdbid');
    log(franid.toString());
    log(userid.toString());

    var bodyParams = {
      "availableTripID": "6547",
      "boardingPointId": "6",
      "destination": "89",
      "droppingPointId": "3",
      "source": "99",
      "user_id": "userid",
      "franch_id": "franid",
      "inventory": jsonEncode([
        {
          "fare": "122",
          "ladiesSeat": "1",
          "passenger": {
            "address": "some address",
            "age": "23",
            "email": "riyaz.tictich@gmail.com",
            "gender": "Male",
            "idNumber": "ID123",
            "idType": "PAN_CARD",
            "mobile": "7034612195",
            "name": "riyaz",
            "primary": "true",
            "title": "Mr"
          },
          "seatName": "c2"
        },
        {
          "fare": "122",
          "ladiesSeat": "1",
          "passenger": {
            "address": "some address",
            "age": "23",
            "email": "riyaz.tictich@gmail.com",
            "gender": "Male",
            "idNumber": "ID123",
            "idType": "PAN_CARD",
            "mobile": "7034612195",
            "name": "riyaz",
            "primary": "true",
            "title": "Mr"
          },
          "seatName": "c2"
        }
      ])
    };

    // log(json.toString());
    final url = Uri.parse('https://tictechnologies.in/stage/redbus/BlockReq');

    final resp = await http.post(url, body: bodyParams);
    log(resp.statusCode.toString());
    log(resp.body.toString());
  }

  static Future<void> addreport3({
    required availableTripID,
    required boardingPointId,
    required droppingPointId,
    required destination,
    required source,
    required userid,
    required franid,
    //pass1
    required fare,
    required ladiesSeat,
    required age,
    required address,
    required email,
    required gender,
    required idNumber,
    required mobile,
    required name,
    required primary,
    required title,
    required seatName,
    //pass2
    required fare2,
    required ladiesSeat2,
    required age2,
    required address2,
    required email2,
    required gender2,
    required idNumber2,
    required mobile2,
    required name2,
    required primary2,
    required title2,
    required seatName2,
    //pass3
    required fare3,
    required ladiesSeat3,
    required age3,
    required address3,
    required email3,
    required gender3,
    required idNumber3,
    required mobile3,
    required name3,
    required primary3,
    required title3,
    required seatName3,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final franid = sharedPreferences.getString('fran_id');
    final userid = sharedPreferences.getString('userdbid');
    log(franid.toString());
    log(userid.toString());

    var bodyParams = {
      "availableTripID": "6547",
      "boardingPointId": "6",
      "destination": "89",
      "droppingPointId": "3",
      "source": "99",
      "user_id": "userid",
      "franch_id": "franid",
      "inventory": jsonEncode([
        {
          "fare": "122",
          "ladiesSeat": "1",
          "passenger": {
            "address": "some address",
            "age": "23",
            "email": "riyaz.tictich@gmail.com",
            "gender": "Male",
            "idNumber": "ID123",
            "idType": "PAN_CARD",
            "mobile": "7034612195",
            "name": "riyaz",
            "primary": "true",
            "title": "Mr"
          },
          "seatName": "c2"
        },
        {
          "fare": "122",
          "ladiesSeat": "1",
          "passenger": {
            "address": "some address",
            "age": "23",
            "email": "riyaz.tictich@gmail.com",
            "gender": "Male",
            "idNumber": "ID123",
            "idType": "PAN_CARD",
            "mobile": "7034612195",
            "name": "riyaz",
            "primary": "true",
            "title": "Mr"
          },
          "seatName": "c2"
        },
        {
          "fare": "122",
          "ladiesSeat": "1",
          "passenger": {
            "address": "some address",
            "age": "23",
            "email": "riyaz.tictich@gmail.com",
            "gender": "Male",
            "idNumber": "ID123",
            "idType": "PAN_CARD",
            "mobile": "7034612195",
            "name": "riyaz",
            "primary": "true",
            "title": "Mr"
          },
          "seatName": "c2"
        }
      ])
    };

    // log(json.toString());
    final url = Uri.parse('https://tictechnologies.in/stage/redbus/BlockReq');

    final resp = await http.post(url, body: bodyParams);
    log(resp.statusCode.toString());
    log(resp.body.toString());
  }

  static Future<void> addreport4({
    required availableTripID,
    required boardingPointId,
    required droppingPointId,
    required destination,
    required source,
    required userid,
    required franid,
    //pass1
    required fare,
    required ladiesSeat,
    required age,
    required address,
    required email,
    required gender,
    required idNumber,
    required mobile,
    required name,
    required primary,
    required title,
    required seatName,
    //pass2
    required fare2,
    required ladiesSeat2,
    required age2,
    required address2,
    required email2,
    required gender2,
    required idNumber2,
    required mobile2,
    required name2,
    required primary2,
    required title2,
    required seatName2,
    //pass3
    required fare3,
    required ladiesSeat3,
    required age3,
    required address3,
    required email3,
    required gender3,
    required idNumber3,
    required mobile3,
    required name3,
    required primary3,
    required title3,
    required seatName3,
    //pass4
    required fare4,
    required ladiesSeat4,
    required age4,
    required address4,
    required email4,
    required gender4,
    required idNumber4,
    required mobile4,
    required name4,
    required primary4,
    required title4,
    required seatName4,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final franid = sharedPreferences.getString('fran_id');
    final userid = sharedPreferences.getString('userdbid');
    log(franid.toString());
    log(userid.toString());

    var bodyParams = {
      "availableTripID": "6547",
      "boardingPointId": "6",
      "destination": "89",
      "droppingPointId": "3",
      "source": "99",
      "user_id": "userid",
      "franch_id": "franid",
      "inventory": jsonEncode([
        {
          "fare": "122",
          "ladiesSeat": "1",
          "passenger": {
            "address": "some address",
            "age": "23",
            "email": "riyaz.tictich@gmail.com",
            "gender": "Male",
            "idNumber": "ID123",
            "idType": "PAN_CARD",
            "mobile": "7034612195",
            "name": "riyaz",
            "primary": "true",
            "title": "Mr"
          },
          "seatName": "c2"
        },
        {
          "fare": "122",
          "ladiesSeat": "1",
          "passenger": {
            "address": "some address",
            "age": "23",
            "email": "riyaz.tictich@gmail.com",
            "gender": "Male",
            "idNumber": "ID123",
            "idType": "PAN_CARD",
            "mobile": "7034612195",
            "name": "riyaz",
            "primary": "true",
            "title": "Mr"
          },
          "seatName": "c2"
        },
        {
          "fare": "122",
          "ladiesSeat": "1",
          "passenger": {
            "address": "some address",
            "age": "23",
            "email": "riyaz.tictich@gmail.com",
            "gender": "Male",
            "idNumber": "ID123",
            "idType": "PAN_CARD",
            "mobile": "7034612195",
            "name": "riyaz",
            "primary": "true",
            "title": "Mr"
          },
          "seatName": "c2"
        },
        {
          "fare": "122",
          "ladiesSeat": "1",
          "passenger": {
            "address": "some address",
            "age": "23",
            "email": "riyaz.tictich@gmail.com",
            "gender": "Male",
            "idNumber": "ID123",
            "idType": "PAN_CARD",
            "mobile": "7034612195",
            "name": "riyaz",
            "primary": "true",
            "title": "Mr"
          },
          "seatName": "c2"
        }
      ])
    };

    // log(json.toString());
    final url = Uri.parse('https://tictechnologies.in/stage/redbus/BlockReq');

    final resp = await http.post(url, body: bodyParams);
    log(resp.statusCode.toString());
    log(resp.body.toString());
  }

  static Future<void> addreport5({
    required availableTripID,
    required boardingPointId,
    required droppingPointId,
    required destination,
    required source,
    required userid,
    required franid,
    //pass1
    required fare,
    required ladiesSeat,
    required age,
    required address,
    required email,
    required gender,
    required idNumber,
    required mobile,
    required name,
    required primary,
    required title,
    required seatName,
    //pass2
    required fare2,
    required ladiesSeat2,
    required age2,
    required address2,
    required email2,
    required gender2,
    required idNumber2,
    required mobile2,
    required name2,
    required primary2,
    required title2,
    required seatName2,
    //pass3
    required fare3,
    required ladiesSeat3,
    required age3,
    required address3,
    required email3,
    required gender3,
    required idNumber3,
    required mobile3,
    required name3,
    required primary3,
    required title3,
    required seatName3,
    //pass4
    required fare4,
    required ladiesSeat4,
    required age4,
    required address4,
    required email4,
    required gender4,
    required idNumber4,
    required mobile4,
    required name4,
    required primary4,
    required title4,
    required seatName4,
    //pass5
    required fare5,
    required ladiesSeat5,
    required age5,
    required address5,
    required email5,
    required gender5,
    required idNumber5,
    required mobile5,
    required name5,
    required primary5,
    required title5,
    required seatName5,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final franid = sharedPreferences.getString('fran_id');
    final userid = sharedPreferences.getString('userdbid');
    log(franid.toString());
    log(userid.toString());

    var bodyParams = {
      "availableTripID": "6547",
      "boardingPointId": "6",
      "destination": "89",
      "droppingPointId": "3",
      "source": "99",
      "user_id": "userid",
      "franch_id": "franid",
      "inventory": jsonEncode([
        {
          "fare": "122",
          "ladiesSeat": "1",
          "passenger": {
            "address": "some address",
            "age": "23",
            "email": "riyaz.tictich@gmail.com",
            "gender": "Male",
            "idNumber": "ID123",
            "idType": "PAN_CARD",
            "mobile": "7034612195",
            "name": "riyaz",
            "primary": "true",
            "title": "Mr"
          },
          "seatName": "c2"
        },
        {
          "fare": "122",
          "ladiesSeat": "1",
          "passenger": {
            "address": "some address",
            "age": "23",
            "email": "riyaz.tictich@gmail.com",
            "gender": "Male",
            "idNumber": "ID123",
            "idType": "PAN_CARD",
            "mobile": "7034612195",
            "name": "riyaz",
            "primary": "true",
            "title": "Mr"
          },
          "seatName": "c2"
        },
        {
          "fare": "122",
          "ladiesSeat": "1",
          "passenger": {
            "address": "some address",
            "age": "23",
            "email": "riyaz.tictich@gmail.com",
            "gender": "Male",
            "idNumber": "ID123",
            "idType": "PAN_CARD",
            "mobile": "7034612195",
            "name": "riyaz",
            "primary": "true",
            "title": "Mr"
          },
          "seatName": "c2"
        },
        {
          "fare": "122",
          "ladiesSeat": "1",
          "passenger": {
            "address": "some address",
            "age": "23",
            "email": "riyaz.tictich@gmail.com",
            "gender": "Male",
            "idNumber": "ID123",
            "idType": "PAN_CARD",
            "mobile": "7034612195",
            "name": "riyaz",
            "primary": "true",
            "title": "Mr"
          },
          "seatName": "c2"
        },
        {
          "fare": "122",
          "ladiesSeat": "1",
          "passenger": {
            "address": "some address",
            "age": "23",
            "email": "riyaz.tictich@gmail.com",
            "gender": "Male",
            "idNumber": "ID123",
            "idType": "PAN_CARD",
            "mobile": "7034612195",
            "name": "riyaz",
            "primary": "true",
            "title": "Mr"
          },
          "seatName": "c2"
        }
      ])
    };

    // log(json.toString());
    final url = Uri.parse('https://tictechnologies.in/stage/redbus/BlockReq');

    final resp = await http.post(url, body: bodyParams);
    log(resp.statusCode.toString());
    log(resp.body.toString());
  }

  static Future<void> addreport6({
    required availableTripID,
    required boardingPointId,
    required droppingPointId,
    required destination,
    required source,
    required userid,
    required franid,
    //pass1
    required fare,
    required ladiesSeat,
    required age,
    required address,
    required email,
    required gender,
    required idNumber,
    required mobile,
    required name,
    required primary,
    required title,
    required seatName,
    //pass2
    required fare2,
    required ladiesSeat2,
    required age2,
    required address2,
    required email2,
    required gender2,
    required idNumber2,
    required mobile2,
    required name2,
    required primary2,
    required title2,
    required seatName2,
    //pass3
    required fare3,
    required ladiesSeat3,
    required age3,
    required address3,
    required email3,
    required gender3,
    required idNumber3,
    required mobile3,
    required name3,
    required primary3,
    required title3,
    required seatName3,
    //pass4
    required fare4,
    required ladiesSeat4,
    required age4,
    required address4,
    required email4,
    required gender4,
    required idNumber4,
    required mobile4,
    required name4,
    required primary4,
    required title4,
    required seatName4,
    //pass5
    required fare5,
    required ladiesSeat5,
    required age5,
    required address5,
    required email5,
    required gender5,
    required idNumber5,
    required mobile5,
    required name5,
    required primary5,
    required title5,
    required seatName5,
    //pass6
    required fare6,
    required ladiesSeat6,
    required age6,
    required address6,
    required email6,
    required gender6,
    required idNumber6,
    required mobile6,
    required name6,
    required primary6,
    required title6,
    required seatName6,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final franid = sharedPreferences.getString('fran_id');
    final userid = sharedPreferences.getString('userdbid');
    log(franid.toString());
    log(userid.toString());

    var bodyParams = {
      "availableTripID": "6547",
      "boardingPointId": "6",
      "destination": "89",
      "droppingPointId": "3",
      "source": "99",
      "user_id": "userid",
      "franch_id": "franid",
      "inventory": jsonEncode([
        {
          "fare": "122",
          "ladiesSeat": "1",
          "passenger": {
            "address": "some address",
            "age": "23",
            "email": "riyaz.tictich@gmail.com",
            "gender": "Male",
            "idNumber": "ID123",
            "idType": "PAN_CARD",
            "mobile": "7034612195",
            "name": "riyaz",
            "primary": "true",
            "title": "Mr"
          },
          "seatName": "c2"
        },
        {
          "fare": "122",
          "ladiesSeat": "1",
          "passenger": {
            "address": "some address",
            "age": "23",
            "email": "riyaz.tictich@gmail.com",
            "gender": "Male",
            "idNumber": "ID123",
            "idType": "PAN_CARD",
            "mobile": "7034612195",
            "name": "riyaz",
            "primary": "true",
            "title": "Mr"
          },
          "seatName": "c2"
        },
        {
          "fare": "122",
          "ladiesSeat": "1",
          "passenger": {
            "address": "some address",
            "age": "23",
            "email": "riyaz.tictich@gmail.com",
            "gender": "Male",
            "idNumber": "ID123",
            "idType": "PAN_CARD",
            "mobile": "7034612195",
            "name": "riyaz",
            "primary": "true",
            "title": "Mr"
          },
          "seatName": "c2"
        },
        {
          "fare": "122",
          "ladiesSeat": "1",
          "passenger": {
            "address": "some address",
            "age": "23",
            "email": "riyaz.tictich@gmail.com",
            "gender": "Male",
            "idNumber": "ID123",
            "idType": "PAN_CARD",
            "mobile": "7034612195",
            "name": "riyaz",
            "primary": "true",
            "title": "Mr"
          },
          "seatName": "c2"
        },
        {
          "fare": "122",
          "ladiesSeat": "1",
          "passenger": {
            "address": "some address",
            "age": "23",
            "email": "riyaz.tictich@gmail.com",
            "gender": "Male",
            "idNumber": "ID123",
            "idType": "PAN_CARD",
            "mobile": "7034612195",
            "name": "riyaz",
            "primary": "true",
            "title": "Mr"
          },
          "seatName": "c2"
        }
      ])
    };

    // log(json.toString());
    final url = Uri.parse('https://tictechnologies.in/stage/redbus/BlockReq');

    final resp = await http.post(url, body: bodyParams);
    log(resp.statusCode.toString());
    log(resp.body.toString());
  }
}
