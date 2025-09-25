import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:minna/bus/application/change%20location/location_bloc.dart';
import 'package:minna/bus/domain/BlockTicket/block_respo.dart';
import 'package:minna/bus/domain/BlockTicket/block_ticket_request_modal.dart';
import 'package:minna/bus/domain/seatlayout/seatlayoutmodal.dart';
import 'package:minna/bus/domain/updated%20fare%20respo/update_fare.dart';
import 'package:minna/bus/infrastructure/get%20block%20key/block_ticket.dart';
import 'package:minna/bus/infrastructure/get%20update%20fare/update%20fare%20api.dart';
import 'package:minna/bus/pages/screen%20conform%20ticket/screen_conform_ticket.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/comman/application/login/login_bloc.dart';
import 'package:minna/comman/pages/log%20in/login_page.dart';

class ScreenPassengerInput extends StatefulWidget {
  final BlockTicketRequest alldata;
  final String boardingpoint;
  final String droppingPoint;
  final String trpinfo;
  final String travelsname;
  final List<Seat> selctseat;

  const ScreenPassengerInput({
    super.key,
    required this.alldata,
    required this.selctseat,
    required this.boardingpoint,
    required this.droppingPoint,
    required this.travelsname,
    required this.trpinfo,
  });

  @override
  State<ScreenPassengerInput> createState() => _ScreenPassengerInputState();
}

class _ScreenPassengerInputState extends State<ScreenPassengerInput> {
  final TextEditingController passengerNumber = TextEditingController();
  final TextEditingController passengerEmail = TextEditingController();

  final List<TextEditingController> passengerNameControllers = [];
  final List<TextEditingController> passengerAgeControllers = [];
  final List<String> passengerGenderSelections = [];

  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _showRetryButton = false;
  int retryCount = 0;

  @override
  void initState() {
    super.initState();
    // ensure login info is loaded
    context.read<LoginBloc>().add(const LoginEvent.loginInfo());

    // initialize controllers and gender selection for each seat
    for (int i = 0; i < widget.selctseat.length; i++) {
      passengerNameControllers.add(TextEditingController());
      passengerAgeControllers.add(TextEditingController());
      passengerGenderSelections.add(
        widget.selctseat[i].ladiesSeat == 'true' ? 'Female' : 'Male',
      );
    }
  }

  @override
  void dispose() {
    passengerNumber.dispose();
    passengerEmail.dispose();
    for (final c in passengerNameControllers) {
      c.dispose();
    }
    for (final c in passengerAgeControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: maincolor1!,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Form(
                key: formKey2,
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  children: [
                    _buildContactCard(),
                    const SizedBox(height: 8),
                    ...List.generate(widget.selctseat.length, (i) => buildPassengerCard(i)),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            if (_isLoading)
              LinearProgressIndicator(color: maincolor1!)
            else
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: maincolor1!,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 2,
                  ),
                  // disable button while loading
                  onPressed: _isLoading
                      ? null
                      : () async {
                          if (formKey2.currentState!.validate()) {
                            await callApi();
                          }
                        },
                  child: Text(
                    _showRetryButton ? 'Retry' : 'Continue',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('Contact Details'),
              subtitle: Text('Ticket and bus details will be sent to'),
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.quick_contacts_mail_outlined),
              ),
            ),
            TextFormField(
              controller: passengerEmail,
              validator: (value) {
                final email = (value ?? '').trim();
                if (email.isEmpty) return 'Please enter an Email ID.';
                // simpler but robust email check
                final emailRegEx = RegExp(r"^[^\s@]+@[^\s@]+\.[^\s@]+$");
                if (!emailRegEx.hasMatch(email)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(hintText: 'Email ID'),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const SizedBox(
                  width: 50,
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(hintText: '+91'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: passengerNumber,
                    validator: (value) {
                      final v = (value ?? '').trim();
                      if (v.isEmpty) return 'Please enter phone number';
                      if (!RegExp(r'^[0-9]{10}$').hasMatch(v)) {
                        return 'Enter valid 10-digit number';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(hintText: 'Phone Number'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPassengerCard(int index) {
    final seat = widget.selctseat[index];
    final isRestricted = (seat.ladiesSeat == 'true') || (seat.malesSeat == 'true');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                seat.ladiesSeat == 'true' ? Icons.woman : Icons.person,
                color: maincolor1!,
              ),
              title: Text('Passenger ${index + 1}'),
              subtitle: Text('Seat No: ${seat.name}'),
            ),
            const SizedBox(height: 6),
            TextFormField(
              controller: passengerNameControllers[index],
              validator: (value) =>
                  (value == null || value.trim().isEmpty) ? 'Please enter name' : null,
              decoration: const InputDecoration(hintText: 'Name'),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: passengerAgeControllers[index],
              keyboardType: TextInputType.number,
              validator: (value) {
                final text = (value ?? '').trim();
                final age = int.tryParse(text);
                if (age == null || age < 1 || age > 120) {
                  return 'Enter valid age';
                }
                return null;
              },
              decoration: const InputDecoration(hintText: 'Age'),
            ),
            const SizedBox(height: 10),
            Row(
              children: ['Male', 'Female'].map((gender) {
                final canChange = !isRestricted;
                return Expanded(
                  child: Row(
                    children: [
                      Radio<String>(
                        value: gender,
                        groupValue: passengerGenderSelections[index],
                        onChanged: canChange
                            ? (value) {
                                if (value == null) return;
                                setState(() {
                                  passengerGenderSelections[index] = value;
                                });
                              }
                            : null,
                      ),
                      Text(gender),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showLoginBottomSheet() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const LoginBottomSheet(login: 1),
    );
  }

  Future<void> callApi() async {
    final isLoggedIn = context.read<LoginBloc>().state.isLoggedIn ?? false;

    if (!isLoggedIn) {
      await _showLoginBottomSheet();
      final newLoginState = context.read<LoginBloc>().state;
      if (newLoginState.isLoggedIn != true) {
        _showCustomSnackbar('Please login to continue', isError: true);
        return;
      }
    }

    // limit retries to 3 attempts
    if (retryCount >= 3) {
      _showCustomSnackbar('Maximum retry attempts reached', isError: true);
      return;
    }
    retryCount++;

    setState(() {
      _isLoading = true;
      _showRetryButton = false;
    });

    try {
      final locationState = context.read<LocationBloc>().state;
      final List<InventoryItem> inventoryItems = [];

      for (int i = 0; i < widget.selctseat.length; i++) {
        final seat = widget.selctseat[i];

        final passenger = Passenger(
          name: passengerNameControllers[i].text.trim(),
          age: passengerAgeControllers[i].text.trim(),
          gender: passengerGenderSelections[i],
          email: passengerEmail.text.trim(),
          mobile: passengerNumber.text.trim(),
          address: 'null',
          idNumber: 'null',
          idType: 'null',
          primary: i == 0 ? 'true' : 'false',
          title: passengerGenderSelections[i] == 'Male' ? 'Mr' : 'Ms',
        );

        inventoryItems.add(
          InventoryItem(
            seatName: seat.name,
            fare: seat.fare,
            ladiesSeat: seat.ladiesSeat,
            passenger: passenger,
          ),
        );
      }

      // populate block request
      widget.alldata.source = locationState.from?.id.toString() ?? '';
      widget.alldata.destination = locationState.to?.id.toString() ?? '';
      widget.alldata.boardingPointID = widget.boardingpoint;
      widget.alldata.droppingPointID = widget.droppingPoint;
      widget.alldata.inventoryItems = inventoryItems;

      final bodyParams = blockTicketRequestToJson(widget.alldata);
      log('Block ticket request: $bodyParams');

      final response = await getblockticket(data: bodyParams);

      log('Block ticket response status: ${response.statusCode}');
      log('Block ticket response body: ${response.body}');

      if (response.statusCode == 200) {
        final body = response.body;
        if (body.contains("Authorization failed") || body.contains("Error")) {
          _showCustomSnackbar('Server returned error. Please try again.', isError: true);
          setState(() => _showRetryButton = true);
          return;
        }
       final BlockResponse respoData=           BlockResponse.fromJson(jsonDecode(body) );
        final blockKey = respoData.blockKey;

        // reset retryCount on success
        retryCount = 0;

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ScreenConfirmTicket(blockResponse: respoData,
                blockKey: blockKey,
                selectedSeats: widget.selctseat,
                alldata: widget.alldata,
              ),
            ),
          );
      
      } else {
        // Non-200 status
        _showCustomSnackbar('Server error: ${response.statusCode}', isError: true);
        setState(() => _showRetryButton = true);
      }
    } catch (e, st) {
      log('API error: ${e.toString()}');
      log(st.toString());
      _showCustomSnackbar('Something went wrong. Please try again.', isError: true);
      setState(() => _showRetryButton = true);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showCustomSnackbar(String message, {bool isError = false}) {
    final color = isError ? Colors.redAccent : Colors.green;
    final icon = isError ? Icons.error_outline : Icons.check_circle_outline;

    final snackBar = SnackBar(
      margin: const EdgeInsets.fromLTRB(16, 20, 16, 10),
      behavior: SnackBarBehavior.floating,
      backgroundColor: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      duration: const Duration(seconds: 3),
      content: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(
            child: Text(message, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
