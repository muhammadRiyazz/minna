import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minna/bus/application/change%20location/location_bloc.dart';
import 'package:minna/bus/domain/BlockTicket/block_ticket_request_modal.dart';
import 'package:minna/bus/domain/seatlayout/seatlayoutmodal.dart';
import 'package:minna/bus/infrastructure/get%20block%20key/block_ticket.dart';
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
    Key? key,
    required this.alldata,
    required this.selctseat,
    required this.boardingpoint,
    required this.droppingPoint,
    required this.travelsname,
    required this.trpinfo,
  }) : super(key: key);

  @override
  State<ScreenPassengerInput> createState() => _ScreenPassengerInputState();
}

class _ScreenPassengerInputState extends State<ScreenPassengerInput> {
  final TextEditingController passengerNumber = TextEditingController();
  final TextEditingController passengerEmail = TextEditingController();
  final List<TextEditingController> passengerNameControllers = [];
  final List<TextEditingController> passengerAgeControllers = [];
  final List<String> passengerGenderSelections = [];

  final formKey2 = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _showRetryButton = false;
  int retryCount = 0;

  @override
  void initState() {
    context.read<LoginBloc>().add(const LoginEvent.loginInfo());
    for (int i = 0; i < widget.selctseat.length; i++) {
      passengerNameControllers.add(TextEditingController());
      passengerAgeControllers.add(TextEditingController());
      passengerGenderSelections.add(
        widget.selctseat[i].ladiesSeat == 'true' ? 'Female' : 'Male',
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    passengerNumber.dispose();
    passengerEmail.dispose();
    for (final controller in passengerNameControllers) {
      controller.dispose();
    }
    for (final controller in passengerAgeControllers) {
      controller.dispose();
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
                  children: [
                    _buildContactCard(),
                    ...List.generate(
                      widget.selctseat.length,
                      buildPassengerCard,
                    ),
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
                  onPressed: () {
                    if (formKey2.currentState!.validate()) {
                      callApi();
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
                final email = value?.trim() ?? '';
                final emailRegEx = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                if (email.isEmpty) {
                  return 'Please enter an Email ID.';
                }
                if (!emailRegEx.hasMatch(email)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },

              decoration: const InputDecoration(hintText: 'Email ID'),
            ),
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
                      if (value == null || value.isEmpty) {
                        return 'Please enter phone number';
                      }
                      if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
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
            TextFormField(
              controller: passengerNameControllers[index],
              validator: (value) =>
                  (value == null || value.isEmpty) ? 'Please enter name' : null,
              decoration: const InputDecoration(hintText: 'Name'),
            ),
            TextFormField(
              controller: passengerAgeControllers[index],
              keyboardType: TextInputType.number,
              validator: (value) {
                final age = int.tryParse(value ?? '');
                if (age == null || age < 1 || age > 100) {
                  return 'Enter valid age';
                }
                return null;
              },
              decoration: const InputDecoration(hintText: 'Age'),
            ),
            const SizedBox(height: 10),
            Row(
              children: ['Male', 'Female'].map((gender) {
                bool isSelectable =
                    seat.ladiesSeat != 'true' && seat.malesSeat != 'true';
                return Expanded(
                  child: Row(
                    children: [
                      Radio<String>(
                        value: gender,
                        groupValue: passengerGenderSelections[index],
                        onChanged: isSelectable
                            ? (value) {
                                setState(() {
                                  passengerGenderSelections[index] = value!;
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

    if (retryCount >= 3) return;
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
          name: passengerNameControllers[i].text,
          age: passengerAgeControllers[i].text,
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

      widget.alldata.source = locationState.from?.id.toString() ?? '';
      widget.alldata.destination = locationState.to?.id.toString() ?? '';
      widget.alldata.boardingPointID = widget.boardingpoint;
      widget.alldata.droppingPointID = widget.droppingPoint;
      widget.alldata.inventoryItems = inventoryItems;

      final _bodyParams = blockTicketRequestToJson(widget.alldata);
      log(_bodyParams);
      final response = await getblockticket(data: _bodyParams);
      log(response.body.toString());

      if (response.statusCode == 200 &&
          !response.body.contains("Authorization failed") &&
          !response.body.contains("Error")) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ScreenConfirmTicket(
              blockKey: response.body,
              selectedSeats: widget.selctseat,
              alldata: widget.alldata,
            ),
          ),
        );
      } else {
        // _showCustomSnackbar(response.body, isError: true);
        setState(() => _showRetryButton = true);
      }
    } catch (e) {
      log('API error: ${e.toString()}');
      // _showCustomSnackbar('Something went wrong.', isError: true);
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
