// import 'dart:convert';
// import 'dart:developer';
// import 'package:minna/bus/domain/data_post_redBus.dart';
// import 'package:dartz/dartz_streaming.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:meta/meta.dart';

// import 'package:http/http.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../constants/urls.dart';

// class BlocTicketEvetApiClass {
//   getDataBLocTicket1({
//     required tripId,
//     required bPIdee,
//     required destIdee,
//     required source,
//     required mobPassenger,
//     required emailPassenger,
//     required seatName1,
//     required fare1,
//     required ladiesSeat1,
//     required age1,
//     required gender1,
//     required name1,
//     required droppingPointId,
//     required destinationName,
//     required sourceName,
//   }) async {
//     log(tripId);
//     log(bPIdee);
//     log(destIdee);
//     log(source);
//     log(mobPassenger);
//     log(emailPassenger);
//     log(seatName1);
//     log(fare1);
//     log(ladiesSeat1);
//     log(age1);
//     log(gender1);
//     log(name1);
//     var _urlPhp = '${baseUrlRedBus}CallAPI';

//     print(
//         '**************************************************************************************************');
//     print(_urlPhp);

//     var _bodyParams = {
//       "availableTripId": "${tripId}",
//       "boardingPointId": "${bPIdee}",
//       "destination": "${destIdee}",
//       "inventoryItems": [
//         {
//           "fare": "$fare1",
//           "ladiesSeat": "$ladiesSeat1",
//           "passenger": {
//             "address": "some address",
//             "age": "${age1}",
//             "email": "${emailPassenger}",
//             "gender": "${gender1}",
//             "idNumber": "ID123",
//             "idType": "PAN_CARD",
//             "mobile": "${mobPassenger}",
//             "name": "${name1}",
//             "primary": "true",
//             "title": "Mr"
//           },
//           "seatName": "${seatName1}"
//         },
//       ],
//       "source": "${source}"
//     };
//     // print(_bodyParams);
//     // print('json encode');
//     // print(jsonEncode(_bodyParams));
//     var bodyBackend = {
//       "url": "http://api.seatseller.travel/blockTicket",
//       "method": "POST",
//       "data": jsonEncode(_bodyParams),
//     };
//     Response _resRedBus = await post(Uri.parse(_urlPhp), body: bodyBackend);
//     print(_resRedBus.body);

//     if (_resRedBus.body.toString().characters.length.toInt() <= 12) {
//       //Backend saving
//       String _urlFromBackend =
//           'https://tictechnologies.in/stage/redbus/BlockReq';

//       SharedPreferences sharedPreferences =
//           await SharedPreferences.getInstance();
//       final franid = sharedPreferences.getString('fran_id');
//       final userid = sharedPreferences.getString('userdbid');

//       var inveTory = [
//         {
//           "fare": "$fare1",
//           "ladiesSeat": "$ladiesSeat1",
//           "passenger": {
//             "address": "some address",
//             "age": "${age1}",
//             "email": "${emailPassenger}",
//             "gender": "${gender1}",
//             "idNumber": "ID123",
//             "idType": "PAN_CARD",
//             "mobile": "${mobPassenger}",
//             "name": "${name1}",
//             "primary": "true",
//             "title": "Mr"
//           },
//           "seatName": "${seatName1}"
//         },
//       ];

//       var _bodyFromBackend = {
//         "availableTripID": "${tripId}",
//         "boardingPointId": "${bPIdee}",
//         "droppingPointId": droppingPointId,
//         "destination": destinationName,
//         "source": sourceName,
//         "inventory": jsonEncode(inveTory),
//         "user_id": userid,
//         "franch_id": franid,
//       };
//       print('**************/*******************');
//       print(_bodyFromBackend);
//       print(jsonEncode(inveTory));

//       Response _resToBackend =
//           await post(Uri.parse(_urlFromBackend), body: _bodyFromBackend);
//       print('insert response');
//       print(_resToBackend.body);

//       return _resRedBus.body;
//     } else {
//       return _resRedBus.body;
//     }
//   }

//   getDataBLocTicket2({
//     required tripId,
//     required bPIdee,
//     required destIdee,
//     required source,
//     required mobPassenger,
//     required emailPassenger,
//     required seatName1,
//     required fare1,
//     required ladiesSeat1,
//     required age1,
//     required gender1,
//     required name1,
//     required seatName2,
//     required fare2,
//     required ladiesSeat2,
//     required age2,
//     required gender2,
//     required name2,
//     // report things
//     required boardingPointName,
//     required droppingPointName,
//     required destinationName,
//     required sourceName,
//   }) async {
//     // var _urlPhp = 'https://api.maaxusdigitalhub.com/CallAPI';
//     var _urlPhp = '${baseUrlRedBus}CallAPI';
//     var invenTory2 = [
//       {
//         "fare": "${fare1}",
//         "ladiesSeat": "${ladiesSeat1}",
//         "passenger": {
//           "address": "some address",
//           "age": "${age1}",
//           "email": "${emailPassenger}",
//           "gender": "${gender1}",
//           "idNumber": "ID123",
//           "idType": "PAN_CARD",
//           "mobile": "$mobPassenger",
//           "name": "${name1}",
//           "primary": "true",
//           "title": "Mr"
//         },
//         "seatName": "${seatName1}"
//       },
//       {
//         "fare": "${fare2}",
//         "ladiesSeat": "false",
//         "passenger": {
//           "age": "${age2}",
//           "email": "test1@redbus.in",
//           "gender": "${gender2}",
//           "mobile": "9999999999",
//           "name": "${name2}",
//           "primary": "false",
//           "title": "Mr"
//         },
//         "seatName": "${seatName2}"
//       }
//     ];

//     var _bodyParams = {
//       "availableTripId": "${tripId}",
//       "boardingPointId": "${bPIdee}",
//       "destination": "${destIdee}",
//       "inventoryItems": invenTory2,
//       "source": "${source}"
//     };
//     print(_bodyParams);
//     print('json encode');
//     print(jsonEncode(_bodyParams));
//     var bodyBackend = {
//       "url": "http://api.seatseller.travel/blockTicket",
//       "method": "POST",
//       "data": jsonEncode(_bodyParams),
//     };
//     Response _resRedBus2 = await post(Uri.parse(_urlPhp), body: bodyBackend);
//     if (_resRedBus2.body.toString().characters.length.toInt() <= 12) {
//       //Backend saving
//       String _urlFromBackend =
//           'https://tictechnologies.in/stage/redbus/BlockReq';

//       print('backend url');
//       print(_urlFromBackend);
//       SharedPreferences sharedPreferences =
//           await SharedPreferences.getInstance();
//       final franid = sharedPreferences.getString('fran_id');
//       final userid = sharedPreferences.getString('userdbid');

//       var _bodyFromBackend = {
//         "availableTripID": "${tripId}",
//         "boardingPointId": "${boardingPointName}",
//         "droppingPointId": droppingPointName,
//         "destination": destinationName,
//         "source": sourceName,
//         "inventory": jsonEncode(invenTory2),
//         "user_id": userid,
//         "franch_id": franid,
//       };
//       print('**************/*******************'); ////
//       print(_bodyFromBackend);
//       print(jsonEncode(invenTory2));

//       Response _resToBackend =
//           await post(Uri.parse(_urlFromBackend), body: _bodyFromBackend);
//       print('insert response');
//       print(_resToBackend.body);

//       return _resRedBus2.body;
//     } else {
//       return _resRedBus2.body;
//     }

//     // if (_res.statusCode == 200) {
//     //   final url = Uri.parse(' http://api.seatseller.travel/rtcfarebreakup');

//     //   Response resp = await post(url, body: {"BlockKey": _res.body});
//     //   log(resp.toString());
//     // }

//     // return _res.statusCode == 200
//     //     ? _res.body
//     //     : 'error no data available from backend';
//   }

//   getDataBLocTicket3({
//     required tripId,
//     required bPIdee,
//     required destIdee,
//     required source,
//     required mobPassenger,
//     required emailPassenger,
//     required seatName1,
//     required fare1,
//     required ladiesSeat1,
//     required age1,
//     required gender1,
//     required name1,
//     //passe 2
//     required seatName2,
//     required fare2,
//     required ladiesSeat2,
//     required age2,
//     required gender2,
//     required name2,
//     // passe3
//     required seatName3,
//     required fare3,
//     required ladiesSeat3,
//     required age3,
//     required gender3,
//     required name3,
//     // report things
//     required boardingPointName,
//     required droppingPointName,
//     required destinationName,
//     required sourceName,
//   }) async {
//     var _urlPhp = '${baseUrlRedBus}CallAPI';
//     var invenTory3 = [
//       {
//         "fare": "$fare1",
//         "ladiesSeat": "$ladiesSeat1",
//         "passenger": {
//           "address": "some address",
//           "age": "$age1",
//           "email": "$emailPassenger",
//           "gender": "$gender1",
//           "idNumber": "ID123",
//           "idType": "PAN_CARD",
//           "mobile": "$mobPassenger",
//           "name": "$name1",
//           "primary": "true",
//           "title": "Mr"
//         },
//         "seatName": "$seatName1"
//       },
//       {
//         "fare": "$fare2",
//         "ladiesSeat": "false",
//         "passenger": {
//           "age": "$age2",
//           "email": "test1@redbus.in",
//           "gender": "$gender2",
//           "mobile": "9999999999",
//           "name": "$name2",
//           "primary": "false",
//           "title": "Mr"
//         },
//         "seatName": "$seatName2"
//       },
//       {
//         "fare": "$fare3",
//         "ladiesSeat": "false",
//         "passenger": {
//           "age": "$age3",
//           "email": "test1@redbus.in",
//           "gender": "$gender3",
//           "mobile": "9999999999",
//           "name": "$name3",
//           "primary": "false",
//           "title": "Mr"
//         },
//         "seatName": "$seatName3"
//       }
//     ];

//     var _bodyParams = {
//       "availableTripId": "$tripId",
//       "boardingPointId": "$bPIdee",
//       "destination": "$destIdee",
//       "inventoryItems": invenTory3,
//       "source": "$source"
//     };

//     var bodyBackend = {
//       "url": "http://api.seatseller.travel/blockTicket",
//       "method": "POST",
//       "data": jsonEncode(_bodyParams),
//     };
//     Response _resRedBus3 = await post(Uri.parse(_urlPhp), body: bodyBackend);
//     if (_resRedBus3.body.toString().characters.length.toInt() <= 12) {
//       //Backend saving
//       String _urlFromBackend =
//           'https://tictechnologies.in/stage/redbus/BlockReq';

//       print('backend url');
//       print(_urlFromBackend);
//       SharedPreferences sharedPreferences =
//           await SharedPreferences.getInstance();
//       final franid = sharedPreferences.getString('fran_id');
//       final userid = sharedPreferences.getString('userdbid');

//       var _bodyFromBackend = {
//         "availableTripID": "${tripId}",
//         "boardingPointId": "${boardingPointName}",
//         "droppingPointId": droppingPointName,
//         "destination": destinationName,
//         "source": sourceName,
//         "inventory": jsonEncode(invenTory3),
//         "user_id": userid,
//         "franch_id": franid,
//       };
//       print('**************/*******************'); ////
//       print(_bodyFromBackend);
//       print(jsonEncode(invenTory3));

//       Response _resToBackend =
//           await post(Uri.parse(_urlFromBackend), body: _bodyFromBackend);
//       print('insert response');
//       print(_resToBackend.body);

//       return _resRedBus3.body;
//     } else {
//       return _resRedBus3.body;
//     }

//     // return _res.statusCode == 200
//     //     ? _res.body
//     //     : 'error no data available from backend';
//   }

//   getDataBLocTicket4({
//     required tripId,
//     required bPIdee,
//     required destIdee,
//     required source,
//     required mobPassenger,
//     required emailPassenger,
//     required seatName1,
//     required fare1,
//     required ladiesSeat1,
//     required age1,
//     required gender1,
//     required name1,
//     //passe 2
//     required seatName2,
//     required fare2,
//     required ladiesSeat2,
//     required age2,
//     required gender2,
//     required name2,
//     // passe3
//     required seatName3,
//     required fare3,
//     required ladiesSeat3,
//     required age3,
//     required gender3,
//     required name3,
//     // passenger 4
//     required seatName4,
//     required fare4,
//     required ladiesSeat4,
//     required age4,
//     required gender4,
//     required name4,
//     // report things
//     required boardingPointName,
//     required droppingPointName,
//     required destinationName,
//     required sourceName,
//   }) async {
//     var _urlPhp = '${baseUrlRedBus}CallAPI';
//     var invenTory4 = [
//       {
//         "fare": "${fare1}",
//         "ladiesSeat": "${ladiesSeat1}",
//         "passenger": {
//           "address": "some address",
//           "age": "${age1}",
//           "email": "${emailPassenger}",
//           "gender": "${gender1}",
//           "idNumber": "ID123",
//           "idType": "PAN_CARD",
//           "mobile": "${mobPassenger}",
//           "name": "${name1}",
//           "primary": "true",
//           "title": "Mr"
//         },
//         "seatName": "${seatName1}"
//       },
//       {
//         "fare": "${fare2}",
//         "ladiesSeat": "false",
//         "passenger": {
//           "age": "${age2}",
//           "email": "test1@redbus.in",
//           "gender": "${gender2}",
//           "mobile": "9999999999",
//           "name": "${name2}",
//           "primary": "false",
//           "title": "Mr"
//         },
//         "seatName": "${seatName2}"
//       },
//       {
//         "fare": "${fare3}",
//         "ladiesSeat": "false",
//         "passenger": {
//           "age": "${age3}",
//           "email": "test1@redbus.in",
//           "gender": "${gender3}",
//           "mobile": "9999999999",
//           "name": "${name3}",
//           "primary": "false",
//           "title": "Mr"
//         },
//         "seatName": "${seatName3}"
//       },
//       {
//         "fare": "${fare4}",
//         "ladiesSeat": "false",
//         "passenger": {
//           "age": "${age4}",
//           "email": "test1@redbus.in",
//           "gender": "${gender4}",
//           "mobile": "9999999999",
//           "name": "${name4}",
//           "primary": "false",
//           "title": "Mr"
//         },
//         "seatName": "${seatName4}"
//       }
//     ];

//     var _bodyParams = {
//       "availableTripId": "${tripId}",
//       "boardingPointId": "${bPIdee}",
//       "destination": "${destIdee}",
//       "inventoryItems": invenTory4,
//       "source": "${source}"
//     };
//     print(_bodyParams);
//     print('json encode');
//     print(jsonEncode(_bodyParams));
//     var bodyBackend = {
//       "url": "http://api.seatseller.travel/blockTicket",
//       "method": "POST",
//       "data": jsonEncode(_bodyParams),
//     };
//     Response _resRedBus4 = await post(Uri.parse(_urlPhp), body: bodyBackend);
//     if (_resRedBus4.body.toString().characters.length.toInt() <= 12) {
//       //Backend saving
//       String _urlFromBackend =
//           'https://tictechnologies.in/stage/redbus/BlockReq';

//       print('backend url');
//       print(_urlFromBackend);
//       SharedPreferences sharedPreferences =
//           await SharedPreferences.getInstance();
//       final franid = sharedPreferences.getString('fran_id');
//       final userid = sharedPreferences.getString('userdbid');

//       var _bodyFromBackend = {
//         "availableTripID": "${tripId}",
//         "boardingPointId": "${boardingPointName}",
//         "droppingPointId": droppingPointName,
//         "destination": destinationName,
//         "source": sourceName,
//         "inventory": jsonEncode(invenTory4),
//         "user_id": userid,
//         "franch_id": franid,
//       };
//       print('**************/*******************'); ////
//       print(_bodyFromBackend);
//       print(jsonEncode(invenTory4));

//       Response _resToBackend =
//           await post(Uri.parse(_urlFromBackend), body: _bodyFromBackend);
//       print('insert response');
//       print(_resToBackend.body);

//       return _resRedBus4.body;
//     } else {
//       return _resRedBus4.body;
//     }

//     // print('Blocke key issssssssssss${_res.body}');
//     // return _res.statusCode == 200
//     //     ? _res.body
//     //     : 'error , no response is available';
//   }

//   getDataBLocTicket5({
//     required tripId,
//     required bPIdee,
//     required destIdee,
//     required source,
//     required mobPassenger,
//     required emailPassenger,
//     required seatName1,
//     required fare1,
//     required ladiesSeat1,
//     required age1,
//     required gender1,
//     required name1,
//     //passe 2
//     required seatName2,
//     required fare2,
//     required ladiesSeat2,
//     required age2,
//     required gender2,
//     required name2,
//     // passe3
//     required seatName3,
//     required fare3,
//     required ladiesSeat3,
//     required age3,
//     required gender3,
//     required name3,
//     // passenger 4
//     required seatName4,
//     required fare4,
//     required ladiesSeat4,
//     required age4,
//     required gender4,
//     required name4,
//     // passenger 5

//     required seatName5,
//     required fare5,
//     required ladiesSeat5,
//     required age5,
//     required gender5,
//     required name5,
//     // extra for backend
//     required boardingPointName,
//     required droppingPointName,
//     required destinationName,
//     required sourceName,
//   }) async {
//     var _urlPhp = '${baseUrlRedBus}CallAPI';
//     var inveTory5 = [
//       {
//         "fare": "${fare1}",
//         "ladiesSeat": "${ladiesSeat1}",
//         "passenger": {
//           "address": "some address",
//           "age": "${age1}",
//           "email": "${emailPassenger}",
//           "gender": "${gender1}",
//           "idNumber": "ID123",
//           "idType": "PAN_CARD",
//           "mobile": "${mobPassenger}",
//           "name": "${name1}",
//           "primary": "true",
//           "title": "Mr"
//         },
//         "seatName": "${seatName1}"
//       },
//       {
//         "fare": "${fare2}",
//         "ladiesSeat": "false",
//         "passenger": {
//           "age": "${age2}",
//           "email": "test1@redbus.in",
//           "gender": "${gender2}",
//           "mobile": "9999999999",
//           "name": "${name2}",
//           "primary": "false",
//           "title": "Mr"
//         },
//         "seatName": "$seatName2"
//       },
//       {
//         "fare": "$fare3",
//         "ladiesSeat": "false",
//         "passenger": {
//           "age": "$age3",
//           "email": "test1@redbus.in",
//           "gender": "$gender3",
//           "mobile": "9999999999",
//           "name": "$name3",
//           "primary": "false",
//           "title": "Mr"
//         },
//         "seatName": "$seatName3"
//       },
//       {
//         "fare": "${fare4}",
//         "ladiesSeat": "false",
//         "passenger": {
//           "age": "${age4}",
//           "email": "test1@redbus.in",
//           "gender": "${gender4}",
//           "mobile": "9999999999",
//           "name": "${name4}",
//           "primary": "false",
//           "title": "Mr"
//         },
//         "seatName": "${seatName4}"
//       },
//       {
//         "fare": "${fare5}",
//         "ladiesSeat": "false",
//         "passenger": {
//           "age": "${age5}",
//           "email": "test1@redbus.in",
//           "gender": "${gender5}",
//           "mobile": "9999999999",
//           "name": "${name5}",
//           "primary": "false",
//           "title": "Mr"
//         },
//         "seatName": "${seatName5}"
//       }
//     ];

//     var _bodyParams = {
//       "availableTripId": "${tripId}",
//       "boardingPointId": "${bPIdee}",
//       "destination": "${destIdee}",
//       "inventoryItems": inveTory5,
//       "source": "${source}"
//     };
//     print(_bodyParams);
//     print('json encode');
//     print(jsonEncode(_bodyParams));
//     var bodyBackend = {
//       "url": "http://api.seatseller.travel/blockTicket",
//       "method": "POST",
//       "data": jsonEncode(_bodyParams),
//     };
//     Response _resRedBus5 = await post(Uri.parse(_urlPhp), body: bodyBackend);
//     if (_resRedBus5.body.toString().characters.length.toInt() <= 12) {
//       //Backend saving
//       String _urlFromBackend =
//           'https://tictechnologies.in/stage/redbus/BlockReq';

//       print('backend url');
//       print(_urlFromBackend);
//       SharedPreferences sharedPreferences =
//           await SharedPreferences.getInstance();
//       final franid = sharedPreferences.getString('fran_id');
//       final userid = sharedPreferences.getString('userdbid');

//       var _bodyFromBackend = {
//         "availableTripID": "${tripId}",
//         "boardingPointId": "${boardingPointName}",
//         "droppingPointId": droppingPointName,
//         "destination": destinationName,
//         "source": sourceName,
//         "inventory": jsonEncode(inveTory5),
//         "user_id": userid,
//         "franch_id": franid,
//       };
//       print('**************/*******************'); ////
//       print(_bodyFromBackend);
//       print(jsonEncode(inveTory5));

//       Response _resToBackend =
//           await post(Uri.parse(_urlFromBackend), body: _bodyFromBackend);
//       print('insert response');
//       print(_resToBackend.body);

//       return _resRedBus5.body;
//     } else {
//       return _resRedBus5.body;
//     }
//     // return _res.statusCode == 200
//     //     ? _res.body
//     //     : 'error , no response is available';
//   }

//   getDataBLocTicket6({
//     required tripId,
//     required bPIdee,
//     required destIdee,
//     required source,
//     required mobPassenger,
//     required emailPassenger,
//     required seatName1,
//     required fare1,
//     required ladiesSeat1,
//     required age1,
//     required gender1,
//     required name1,
//     //passe 2
//     required seatName2,
//     required fare2,
//     required ladiesSeat2,
//     required age2,
//     required gender2,
//     required name2,
//     // passe3
//     required seatName3,
//     required fare3,
//     required ladiesSeat3,
//     required age3,
//     required gender3,
//     required name3,
//     // passenger 4
//     required seatName4,
//     required fare4,
//     required ladiesSeat4,
//     required age4,
//     required gender4,
//     required name4,
//     // passenger 5

//     required seatName5,
//     required fare5,
//     required ladiesSeat5,
//     required age5,
//     required gender5,
//     required name5,
//     // passeger 6

//     required seatName6,
//     required fare6,
//     required ladiesSeat6,
//     required age6,
//     required gender6,
//     required name6,

//     // extra for backend
//     required boardingPointName,
//     required droppingPointName,
//     required destinationName,
//     required sourceName,
//   }) async {
//     var _urlPhp = '${baseUrlRedBus}CallAPI';
//     var inveTory6 = [
//       {
//         "fare": "${fare1}",
//         "ladiesSeat": "${ladiesSeat1}",
//         "passenger": {
//           "address": "some address",
//           "age": "${age1}",
//           "email": "${emailPassenger}",
//           "gender": "${gender1}",
//           "idNumber": "ID123",
//           "idType": "PAN_CARD",
//           "mobile": "${mobPassenger}",
//           "name": "${name1}",
//           "primary": "true",
//           "title": "Mr"
//         },
//         "seatName": "$seatName1"
//       },
//       {
//         "fare": "${fare2}",
//         "ladiesSeat": "false",
//         "passenger": {
//           "age": "${age2}",
//           "email": "test1@redbus.in",
//           "gender": "${gender2}",
//           "mobile": "9999999999",
//           "name": "${name2}",
//           "primary": "false",
//           "title": "Mr"
//         },
//         "seatName": "${seatName2}"
//       },
//       {
//         "fare": "${fare3}",
//         "ladiesSeat": "false",
//         "passenger": {
//           "age": "${age3}",
//           "email": "test1@redbus.in",
//           "gender": "${gender3}",
//           "mobile": "9999999999",
//           "name": "${name3}",
//           "primary": "false",
//           "title": "Mr"
//         },
//         "seatName": "${seatName3}"
//       },
//       {
//         "fare": "${fare4}",
//         "ladiesSeat": "false",
//         "passenger": {
//           "age": "${age4}",
//           "email": "test1@redbus.in",
//           "gender": "${gender4}",
//           "mobile": "9999999999",
//           "name": "${name4}",
//           "primary": "false",
//           "title": "Mr"
//         },
//         "seatName": "${seatName4}"
//       },
//       {
//         "fare": "${fare5}",
//         "ladiesSeat": "false",
//         "passenger": {
//           "age": "${age5}",
//           "email": "test1@redbus.in",
//           "gender": "${gender5}",
//           "mobile": "9999999999",
//           "name": "${name5}",
//           "primary": "false",
//           "title": "Mr"
//         },
//         "seatName": "${seatName5}"
//       },
//       {
//         "fare": "${fare6}",
//         "ladiesSeat": "false",
//         "passenger": {
//           "age": "${age6}",
//           "email": "test1@redbus.in",
//           "gender": "${gender6}",
//           "mobile": "9999999999",
//           "name": "${name6}",
//           "primary": "false",
//           "title": "Mr"
//         },
//         "seatName": "${seatName6}"
//       },
//     ];

//     var _bodyParams = {
//       "availableTripId": "${tripId}",
//       "boardingPointId": "${bPIdee}",
//       "destination": "${destIdee}",
//       "inventoryItems": inveTory6,
//       "source": "${source}"
//     };
//     print(_bodyParams);
//     print('json encode');
//     print(jsonEncode(_bodyParams));
//     var bodyBackend = {
//       "url": "http://api.seatseller.travel/blockTicket",
//       "method": "POST",
//       "data": jsonEncode(_bodyParams),
//     };
//     Response _resRedBus6 = await post(Uri.parse(_urlPhp), body: bodyBackend);

//     if (_resRedBus6.body.toString().characters.length.toInt() <= 12) {
//       //Backend saving
//       String _urlFromBackend =
//           'https://tictechnologies.in/stage/redbus/BlockReq';

//       print('backend url');
//       print(_urlFromBackend);
//       SharedPreferences sharedPreferences =
//           await SharedPreferences.getInstance();
//       final franid = sharedPreferences.getString('fran_id');
//       final userid = sharedPreferences.getString('userdbid');

//       var _bodyFromBackend = {
//         "availableTripID": "${tripId}",
//         "boardingPointId": "${boardingPointName}",
//         "droppingPointId": droppingPointName,
//         "destination": destinationName,
//         "source": sourceName,
//         "inventory": jsonEncode(inveTory6),
//         "user_id": userid,
//         "franch_id": franid,
//       };
//       print('**************/*******************');
//       print(_bodyFromBackend);
//       print(jsonEncode(inveTory6));

//       Response _resToBackend =
//           await post(Uri.parse(_urlFromBackend), body: _bodyFromBackend);
//       print('insert response');
//       print(_resToBackend.body);
//       var _message = jsonDecode(_resToBackend.body)['message'];
//       globalPostRedBus =
//           globalPostRedBus.copyWith(message: _message.toString());

//       return _resRedBus6.body;
//     } else {
//       return _resRedBus6.body;
//     }

//     // return _res.statusCode == 200
//     //     ? _res.body
//     //     : 'error , no response is available';
//   }
// }

// // {
// //     "availableTripId": "100000005694000822",
// //     "boardingPointId": "67122",
// //     "destination": "3834",
// //     "inventoryItems": [
// //         {
// //             "fare": "700.0",
// //             "ladiesSeat": "false",
// //             "passenger": {
// //                 "address": "some address",
// //                 "age": "21",
// //                 "email": "test@redbus.in",
// //                 "gender": "MALE",
// //                 "idNumber": "ID123",
// //                 "idType": "PAN_CARD",
// //                 "mobile": "9898989898",
// //                 "name": "test",
// //                 "primary": "true",
// //                 "title": "Mr"
// //             },
// //             "seatName": "U2"
// //         },
// //         {
// //             "fare": "700.0",
// //             "ladiesSeat": "false",
// //             "passenger": {
// //                 "age": "21",
// //                 "email": "test1@redbus.in",
// //                 "gender": "MALE",
// //                 "mobile": "9999999999",
// //                 "name": "test1",
// //                 "primary": "false",
// //                 "title": "Mr"
// //             },
// //             "seatName": "U11"
// //         }
// //     ],
// //     "source": "972"
// // }
