// import 'dart:developer';

// import 'package:bloc/bloc.dart';
// import 'package:minna/bus/red_bus/domain/data_post_redBus.dart';
// import 'package:minna/bus/red_bus/domain/search_location/search_location.dart';
// import 'package:minna/bus/red_bus/infrastructure/bus_seating.dart';
// import 'package:minna/bus/red_bus/infrastructure/search_location.dart';
// import 'package:minna/bus/red_bus/infrastructure/searching_for_bus.dart';
// import 'package:minna/bus/red_bus/screen/new/domain/trips%20list%20modal/trip_list_modal.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:meta/meta.dart';

// import '../../../../domain/boarding_droping/bPdp.dart';
// import '../../../../domain/boarding_droping/board_droping.dart';
// import '../../../../domain/list_of_city/list_sample_model.dart';
// import '../../../../domain/model_bus_seats/mod_test.dart';

// import '../../../../domain/model_bus_seats/test_model.dart';
// import '../../../../domain/pdf_model/model_pdf.dart';
// import '../../../../domain/pdf_model/model_pdf2.dart';

// import '../../../../infrastructure/all_cities.dart';

// import '../../../../infrastructure/boarding_droping.dart';
// import '../../../../infrastructure/show_ticket.dart';
// import '../../../../infrastructure/ticket_idn.dart';

// part 'wallet_bloc_event.dart';
// part 'wallet_bloc_state.dart';

// class FirstBlocRedBus extends Bloc<WalletBlocEvent, WalletBlocState> {
//   FirstBlocRedBus() : super(WalletBlocInitial()) {
//     on<WalletBlocEvent>((event, emit) {
//       // TODO: implement event handler
//     });
//     on<LocationSearchListEvent>((event, emit) async {
//       print('within bloc 1');

//       emit(GettingDataSearchLocationState());

//       // .read<FirstBlocRedBus>().add(LocationSearchListEvent());

//       print('within bloc 2');
//       var _responsSearchList =
//           await SearchLocationClass.getSearchLocationData();
//       print('within bloc 3');
//       print(_responsSearchList);

//       _responsSearchList.fold(
//         (l) => emit(NetworkErrorState(error: l)),
//         (r) => emit(GotDataSearchLocationListState(modelList: r)),
//       );
//     });

//     //Available bus
//     on<AvailableBudEvent>(((event, emit) async {
//       emit(GettingAvailableBusState());
//       var _resAvaiBus =
//           await SearchForBusAvailabilityClass().getDataAvailabilityBus(
//               source: globalPostRedBus.idFromLocation,
//               // '3',
//               desti: globalPostRedBus.idToLocation,
//               // '102',
//               dateOfjurny: globalPostRedBus.dateOfJurny
//               // source:

//               // globalPostRedBus.idFromLocation,
//               // desti: globalPostRedBus.idToLocation,
//               // dateOfjurny: globalPostRedBus.dateOfJurny

//               );

//       _resAvaiBus.fold(
//         (l) => emit(NetworkErrorAvailableState(error: 'error')),
//         (r) => emit(GotDataAvailableListState(modelList: r)),
//       );
//     }));
//     //Available bus seats
//     on<SeatsAvailableEvent>(((event, emit) async {
//       print('gettimg');
//       emit(GettingBusSeats());
//       var _resAvaiBusSeats =
//           await SeatingBusApi().getDataBusSeats(tripIds: event.tripIde);
//       print('fun${_resAvaiBusSeats}');
//       // _resAvaiBusSeats.fold(
//       //   (l) => emit(NetworkErrorBusSeatState(error: 'error')),
//       //   (r) => emit(GotDataBusSeatState(modelListofSeats: r)),
//       // );
//     }));

//     ///Bp and Dp//
//     // on<BpDpEvent>(
//     //   ((event, emit) async {
//     //     print('gettimg');
//     //     emit(BpDpState());
//     //     var _resBpRp = await DpBpApi().getDataBoarding();
//     //     print('fun${_resBpRp}');
//     //     _resBpRp.fold(
//     //       (l) => emit(BpDpNetworkErrorState(error: 'error')),
//     //       (r) => emit(GotDataBpDpState(bpAndDpPoint: r)),
//     //     );
//     //   }),
//     // );
//     //All Cities//
//     on<AllCitiesEvent>((event, emit) async {
//       print('gettimg');
//       emit(AllCitiesState());
//       var _resCity = await ApiAllCities().getDataAllDities();
//       print('fun${_resCity}');
//       _resCity.fold(
//         (l) => emit(AllCitiesNetworkErrorState(error: 'error')),
//         (r) => emit(AllCitiesGotDataState(allCities: r)),
//       );
//     });

//     //PersonDetails
//     on<DpBpEvent>(
//       (event, emit) async {
//         log('gettimg');
//         emit(DpBpState());
//         var _resCity =
//             await DpBpApiNew().getDataBoardingnew(tripIdee: event.tripIdBpDp);

//         // _resCity.fold(
//         //   (l) => emit(DpBPkErrorState(error: 'error')),
//         //   (r) => emit(DpBpGotDataState(dpBp: )),
//         // );
//       },
//     );

//     // Book ticket event

//     // on<BookTicket>((event, emit) async {
//     //   var _resTin = await TinClassBookTicket()
//     //       .getDataBLocTicket(blockKey: event.blockKey);
//     // });

//     ///Ticket details
//     on<TicketDetailsEvent>(
//       (event, emit) async {
//         print('gettimg');
//         emit(TicketState());
//         var _resCity =
//             await TicketShowClass().getDataTicketShowMany(tIn: event.tin);
//         print('fun${_resCity}');
//         _resCity.fold(
//           (l) => emit(TicketErrorState(error: l)),
//           (r) => emit(TicketGotDataState(ticketModel: r)),
//         );
//       },
//     );

//     on<TinEventsssssssssss>(
//       (event, emit) async {
//         emit(TinStateeeeeeeeeeeeeeeeeeeeee());
//         var _resTin = await TinClass().getDataTinssss(blockKey: event.blockKey);

//         _resTin.fold(
//           (l) => emit(TinErrorStateeeeeeeeeeeeeeee(error: l)),
//           (r) => emit(TinGotDataStateeeeeeeeeee(tin: r)),
//         );
//       },
//     );

//     // on<PassengerDetailsOnlyOnePeronEvent>(
//     //   (event, emit) async {
//     //     print('staterrrr');
//     //     emit(PassengerDetailsOnlyOnePeronState());
//     //     print('state');
//     //     var _resPonse =
//     //         await TicketShowClass().getDataTicketShowOne(tIn: event.tIn);
//     //     print('enit');
//     //     print(_resPonse);
//     //     _resPonse.fold(
//     //       (l) => emit(PassengerDetailsOnlyOneErrorState(error: l)),
//     //       (r) => emit(PassengerDetailsOnlyOneGotState(ticketModel: r)),
//     //     );
//     //   },
//     // );

//     on<PassengerDetailsOnlyOnePeronEvent>((event, emit) async {
//       emit(PassengerDetailsOnlyOnePeronState());

//       var _respOne = await TicketDetailsClass()
//           .getDataTicketDetailsPersonOne(tIn: event.tIn);

//       _respOne.fold(
//         (l) => emit(PassengerDetailsOnlyOneErrorState(error: l)),
//         (r) => emit(PassengerDetailsOnlyOneGotState(ticketModel: r)),
//       );
//     });
//   }
// }

// // class TinClassBookTicket {
// //   getDataBLocTicket({
// //     required blockKey,
// //   }) async {
// //     var _urlPhp = 'https://api.maaxusdigitalhub.com/CallAPI';
// //     print(_urlPhp);

// //     var _bodyParams = {
// //       "blockKey": "wfcqTSjM6i",
// //     };
// //     print(blockKey);
// //     print(_bodyParams);
// //     var bodyBackend = {
// //       "url": "http://api.seatseller.travel/bookticket?blockKey=wfcqTSjM6i",
// //       "method": "POST",
// //       "data": jsonEncode(_bodyParams),
// //     };

// //     print(bodyBackend);
// //     Response _res = await post(Uri.parse(_urlPhp), body: bodyBackend);

// //     print('Tin issssssssssss${_res.body}');
// //   }
// // }
