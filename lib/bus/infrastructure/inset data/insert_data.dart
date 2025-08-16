import 'dart:convert';
import 'dart:developer';

import 'package:minna/bus/application/change%20location/location_bloc.dart';
import 'package:minna/bus/domain/BlockTicket/block_ticket_request_modal.dart';
import 'package:http/http.dart';
import 'package:minna/comman/core/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/insertdatamodal/insert_data_modal.dart';
import '../../domain/seatlayout/seatlayoutmodal.dart';

Future<Response> addTicketDetals({
  required BlockTicketRequest alldata,
  required String boardingpoint,
  required String droppingPoint,
  required LocationState locationState,
  required List<Seat> selectedseatslist,
}) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final userId = sharedPreferences.getString('userId') ?? '';
  List<InsertInventoryItem> inventoryItems = [];
  for (var i = 0; i < alldata.inventoryItems!.length; i++) {
    final passanger = InsertPassenger(
      address: 'null',
      idNumber: 'null',
      idType: 'null',
      age: alldata.inventoryItems![i].passenger.age,
      email: alldata.inventoryItems![i].passenger.email,
      gender: alldata.inventoryItems![i].passenger.gender,
      mobile: alldata.inventoryItems![i].passenger.mobile,
      name: alldata.inventoryItems![i].passenger.name,
      primary: 'true',
      title: alldata.inventoryItems![i].passenger.gender == 'Male'
          ? 'Mr'
          : alldata.inventoryItems![i].passenger.gender == 'female'
          ? 'Ms'
          : 'Ms Mr',
    );
    final data = InsertInventoryItem(
      passenger: passanger,
      fare: selectedseatslist[i].fare,
      ladiesSeat: selectedseatslist[i].ladiesSeat,
      seatName: selectedseatslist[i].name,
      baseFare: selectedseatslist[i].baseFare,
    );
    inventoryItems.add(data);
  }
  final data0 = alldata;

  String urlFromBackend = '${baseUrl}BlockReq';

  var bodyFromBackend = {
    "availableTripID": data0.availableTripID!,
    "boardingPointId": boardingpoint,
    "droppingPointId": droppingPoint,
    "destination": locationState.to!.name,
    "source": locationState.from!.name,
    "inventory": jsonEncode(
      List<dynamic>.from(inventoryItems.map((x) => x.toJson())),
    ),
    "user_id": userId,
    "franch_id": '',
  };

  Response resToBackend = await post(
    Uri.parse(urlFromBackend),
    body: bodyFromBackend,
  );
  log(resToBackend.statusCode.toString());
  log(resToBackend.body);
  return resToBackend;
}
