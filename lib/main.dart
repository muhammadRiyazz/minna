import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

// Common
import 'package:minna/comman/application/login/login_bloc.dart';
import 'package:minna/comman/pages/screen%20splash/splash_page.dart';

// Bus
import 'package:minna/bus/application/busListfetch/bus_list_fetch_bloc.dart';
import 'package:minna/bus/application/change%20location/location_bloc.dart';
import 'package:minna/bus/application/location%20fetch/bus_location_fetch_bloc.dart';

// Cab
import 'package:minna/cab/application/booked%20info%20list/booked_info_bloc.dart';
import 'package:minna/cab/application/confirm%20booking/confirm_booking_bloc.dart';
import 'package:minna/cab/application/fetch%20cab/fetch_cabs_bloc.dart';
import 'package:minna/cab/application/hold%20cab/hold_cab_bloc.dart';
import 'package:minna/cab/function/commission_data.dart';

// DTH & Mobile
import 'package:minna/DTH%20&%20Mobile/DTH/application/dth%20proceed/dth_confirm_bloc.dart';
import 'package:minna/DTH%20&%20Mobile/mobile%20%20recharge/application/oparator/operators_bloc.dart';
import 'package:minna/DTH%20&%20Mobile/mobile%20%20recharge/application/proceed_recharge/recharge_proceed_bloc.dart';

// Electricity & Water
import 'package:minna/Electyicity%20&%20Water/application/bill%20report/bill_report_bloc.dart';
import 'package:minna/Electyicity%20&%20Water/application/confirm%20bill/confirm_bill_bloc.dart';
import 'package:minna/Electyicity%20&%20Water/application/fetch%20bill/fetch_bill_bloc.dart';
import 'package:minna/Electyicity%20&%20Water/application/providers/providers_bloc.dart';
import 'package:minna/Electyicity%20&%20Water/function/report_api.dart';

// Flight
import 'package:minna/flight/application/booking/booking_bloc.dart';
import 'package:minna/flight/application/fare%20request/fare_request_bloc.dart';
import 'package:minna/flight/application/nationality/nationality_bloc.dart';
import 'package:minna/flight/application/search%20data/search_data_bloc.dart';
import 'package:minna/flight/application/trip%20request/trip_request_bloc.dart';

// Hotel
import 'package:minna/hotel%20booking/application/bloc/hotel_booking_confirm_bloc.dart';

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
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  bool _isShowingSnackbar = false;

  @override
  void initState() {
    super.initState();
    _initializeConnectivity();
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  /// Initializes connectivity checking and sets up a listener for connectivity changes
  Future<void> _initializeConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      if (!mounted) return;
      _updateConnectionStatus(result);
      
      _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
        _updateConnectionStatus,
        onError: (error) {
          log('Connectivity error: $error');
        },
      );
    } on PlatformException catch (e) {
      log('Couldn\'t check connectivity status', error: e, name: 'Connectivity');
      // Show error to user if connectivity check fails
      if (mounted) {
        _showSnackbar('Unable to check network connection');
      }
    } catch (e) {
      log('Unexpected error initializing connectivity: $e', name: 'Connectivity');
    }
  }

  /// Updates connection status and shows/hides network status snackbar
  void _updateConnectionStatus(List<ConnectivityResult> result) {
    if (!mounted) return;

    final hasConnection = !result.contains(ConnectivityResult.none);
    
    if (!hasConnection && !_isShowingSnackbar) {
      log('No internet connection detected');
      _showSnackbar('Check your network connection');
    } else if (hasConnection && _isShowingSnackbar) {
      _hideSnackbar();
    }
  }

  /// Shows a network error snackbar
  void _showSnackbar(String message) {
    if (!mounted) return;
    
    _isShowingSnackbar = true;
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        duration: const Duration(days: 1),
        dismissDirection: DismissDirection.horizontal,
        showCloseIcon: true,
        backgroundColor: Colors.red.shade700,
        content: Row(
          children: [
            const Icon(Icons.signal_wifi_off, color: Colors.white, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'No Internet Connection',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Hides the network status snackbar
  void _hideSnackbar() {
    if (!mounted) return;
    
    _isShowingSnackbar = false;
    _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifier Providers
        ChangeNotifierProvider(create: (_) => CommissionProvider()),
        
        // Common BlocProviders
        BlocProvider(create: (_) => LoginBloc()),
        
        // Flight BlocProviders
        BlocProvider(create: (_) => NationalityBloc()),
        BlocProvider(create: (_) => SearchDataBloc()),
        BlocProvider(create: (_) => TripRequestBloc()),
        BlocProvider(create: (_) => FareRequestBloc()),
        BlocProvider(create: (_) => BookingBloc()),
        
        // Bus BlocProviders
        BlocProvider(create: (_) => BusLocationFetchBloc()),
        BlocProvider(create: (_) => LocationBloc()),
        BlocProvider(create: (_) => BusListFetchBloc()),
        
        // Cab BlocProviders
        BlocProvider(create: (_) => FetchCabsBloc()),
        BlocProvider(create: (_) => HoldCabBloc()),
        BlocProvider(create: (_) => ConfirmBookingBloc()),
        BlocProvider(create: (_) => BookedInfoBloc()),
        
        // Mobile & DTH BlocProviders
        BlocProvider(create: (_) => OperatorsBloc()),
        BlocProvider(create: (_) => RechargeProceedBloc()),
        BlocProvider(create: (_) => DthConfirmBloc()),
        
        // Electricity & Water BlocProviders
        BlocProvider(create: (_) => ProvidersBloc()),
        BlocProvider(create: (_) => FetchBillBloc()),
        BlocProvider(create: (_) => ConfirmBillBloc()),
        BlocProvider(
          create: (_) => BillPaymentBloc(BillPaymentRepository()),
        ),
        
        // Hotel BlocProviders
        BlocProvider(create: (_) => HotelBookingConfirmBloc()),
      ],
      child: MaterialApp(
        scaffoldMessengerKey: _scaffoldMessengerKey,
        debugShowCheckedModeBanner: false,
        title: 'MT TRIP',
        theme: ThemeData(
          fontFamily: 'Montserrat',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const GradientSplashScreen(),
      ),
    );
  }
}