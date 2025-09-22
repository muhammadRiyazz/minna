import 'dart:async';
import 'dart:developer';

import 'package:minna/DTH%20&%20Mobile/DTH/application/dth%20proceed/dth_confirm_bloc.dart';
import 'package:minna/Electyicity%20&%20Water/application/fetch%20bill/fetch_bill_bloc.dart';
import 'package:minna/Electyicity%20&%20Water/application/providers/providers_bloc.dart';
import 'package:minna/bus/application/busListfetch/bus_list_fetch_bloc.dart';
import 'package:minna/bus/application/change%20location/location_bloc.dart';
import 'package:minna/bus/application/location%20fetch/bus_location_fetch_bloc.dart';
import 'package:minna/cab/application/booked%20info%20list/booked_info_bloc.dart';
import 'package:minna/cab/application/confirm%20booking/confirm_booking_bloc.dart';
import 'package:minna/cab/application/fetch%20cab/fetch_cabs_bloc.dart';
import 'package:minna/cab/application/hold%20cab/hold_cab_bloc.dart';
import 'package:minna/comman/application/login/login_bloc.dart';
import 'package:minna/comman/pages/screen%20splash/splash_page.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minna/flight/application/booking/booking_bloc.dart';
import 'package:minna/flight/application/fare%20request/fare_request_bloc.dart';
import 'package:minna/flight/application/nationality/nationality_bloc.dart';
import 'package:minna/flight/application/search%20data/search_data_bloc.dart';
import 'package:minna/flight/application/trip%20request/trip_request_bloc.dart';
import 'package:minna/DTH%20&%20Mobile/mobile%20%20recharge/application/oparator/operators_bloc.dart';
import 'package:minna/DTH%20&%20Mobile/mobile%20%20recharge/application/proceed_recharge/recharge_proceed_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    try {
      var result = await _connectivity.checkConnectivity();
      if (!mounted) return;
      _updateConnectionStatus(result);
    } on PlatformException catch (e) {
      log('Couldn\'t check connectivity status', error: e);
    }
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    setState(() {
      _connectionStatus = result;
    });

    if (_connectionStatus.contains(ConnectivityResult.none)) {
      log("No internet connection");
      showSnackbar("Check your network connection");
    } else {
      hideSnackbar();
    }
  }

  void showSnackbar(String message) {
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        duration: const Duration(days: 1),
        dismissDirection: DismissDirection.horizontal,
        showCloseIcon: true,
        backgroundColor: Colors.red,
        content: Row(
          children: [
            const Icon(Icons.network_check, color: Colors.white),
            const SizedBox(width: 10),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'No Internet',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                Text(
                  message,
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void hideSnackbar() {
    _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NationalityBloc()),
        BlocProvider(create: (context) => SearchDataBloc()),
        BlocProvider(create: (context) => TripRequestBloc()),
        BlocProvider(create: (context) => FareRequestBloc()),
        BlocProvider(create: (context) => BusLocationFetchBloc()),
        BlocProvider(create: (context) => LocationBloc()),
        BlocProvider(create: (context) => BusListFetchBloc()),
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => OperatorsBloc()),
        BlocProvider(create: (context) => BookingBloc()), // Add this line
        BlocProvider(create: (context) => RechargeProceedBloc()),
        BlocProvider(create: (context) => DthConfirmBloc()),
        BlocProvider(create: (context) => ProvidersBloc()),
        BlocProvider(create: (context) => FetchBillBloc()),

        BlocProvider(create: (context) => FetchCabsBloc()),

        BlocProvider(create: (context) => HoldCabBloc()),
        BlocProvider(create: (context) => ConfirmBookingBloc()),
        BlocProvider(create: (context) => BookedInfoBloc()),

        

        
      ],

      child: MaterialApp(
        scaffoldMessengerKey: _scaffoldMessengerKey,
        debugShowCheckedModeBanner: false,
        title: 'MINNA',
        theme: ThemeData(
          fontFamily: 'Montserrat', // Apply Montserrat font globally
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: GradientSplashScreen(),
      ),
    );
  }
}
