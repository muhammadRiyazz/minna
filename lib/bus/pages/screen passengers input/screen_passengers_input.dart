import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:minna/bus/application/change%20location/location_bloc.dart';
import 'package:minna/bus/domain/BlockTicket/block_respo.dart';
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

  // Color Theme - Black & Gold Premium
  final Color _primaryColor = Colors.black;
  final Color _secondaryColor = Color(0xFFD4AF37); // Gold
  final Color _accentColor = Color(0xFFC19B3C); // Darker Gold
  final Color _backgroundColor = Color(0xFFF8F9FA);
  final Color _cardColor = Colors.white;
  final Color _textPrimary = Colors.black;
  final Color _textSecondary = Color(0xFF666666);
  final Color _textLight = Color(0xFF999999);
  final Color _errorColor = Color(0xFFE53935);
  final Color _successColor = Color(0xFF388E3C);
  final Color _warningColor = Color(0xFFF57C00);

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
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
       
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Trip Summary Card
            
            Expanded(
              child: Form(
                key: formKey2,
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  children: [
                                _buildTripSummaryCard(),
                    SizedBox(height: 16),

                    _buildContactCard(),
                    SizedBox(height: 16),
                    ...List.generate(widget.selctseat.length, (i) => buildPassengerCard(i)),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            
            // Bottom Button Section
            _buildBottomSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildTripSummaryCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            spreadRadius: 1,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _secondaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.directions_bus_rounded,
              color: _secondaryColor,
              size: 24,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.travelsname,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: _textPrimary,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  widget.trpinfo,
                  style: TextStyle(
                    fontSize: 12,
                    color: _textSecondary,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '${widget.selctseat.length} ${widget.selctseat.length == 1 ? 'Seat' : 'Seats'} Selected',
                  style: TextStyle(
                    fontSize: 12,
                    color: _secondaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
         
        ],
      ),
    );
  }


  Widget _buildContactCard() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            spreadRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _secondaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.contact_mail_rounded,
                  color: _secondaryColor,
                  size: 20,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contact Details',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: _textPrimary,
                      ),
                    ),
                    Text(
                      'Ticket details will be sent to this contact',
                      style: TextStyle(
                        fontSize: 12,
                        color: _textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: passengerEmail,
            validator: (value) {
              final email = (value ?? '').trim();
              if (email.isEmpty) return 'Please enter an Email ID.';
              final emailRegEx = RegExp(r"^[^\s@]+@[^\s@]+\.[^\s@]+$");
              if (!emailRegEx.hasMatch(email)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Email Address',
              prefixIcon: Icon(Icons.email_rounded, color: _textLight),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: _textLight.withOpacity(0.3)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: _secondaryColor),
              ),
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 80,
                child: TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    hintText: '+91',

                    hintStyle: TextStyle(color: _textLight),
                    // prefixIcon: Icon(Icons.flag_rounded, color: _textLight),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: _textLight.withOpacity(0.3)),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
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
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    prefixIcon: Icon(Icons.phone_rounded, color: _textLight),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: _textLight.withOpacity(0.3)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: _secondaryColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildPassengerCard(int index) {
    final seat = widget.selctseat[index];
    final isRestricted = (seat.ladiesSeat == 'true') || (seat.malesSeat == 'true');
    final restrictedGender = seat.ladiesSeat == 'true' ? 'Female' : 'Male';

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            spreadRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _secondaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      seat.ladiesSeat == 'true' ? Icons.woman_rounded : Icons.person_rounded,
                      color: _secondaryColor,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Passenger ${index + 1}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: _textPrimary,
                          ),
                        ),
                        Text(
                          'Seat ${seat.name} • ₹${seat.baseFare}',
                          style: TextStyle(
                            fontSize: 12,
                            color: _textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isRestricted)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: restrictedGender == 'Female' 
                            ? Colors.pink.withOpacity(0.1)
                            : Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: restrictedGender == 'Female'
                              ? Colors.pink.withOpacity(0.3)
                              : Colors.blue.withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        restrictedGender == 'Female' ? 'Ladies Only' : 'Gents Only',
                        style: TextStyle(
                          fontSize: 10,
                          color: restrictedGender == 'Female' ? Colors.pink : Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: passengerNameControllers[index],
                validator: (value) =>
                    (value == null || value.trim().isEmpty) ? 'Please enter name' : null,
                decoration: InputDecoration(
                  hintText: 'Full Name',
                  prefixIcon: Icon(Icons.person_outline_rounded, color: _textLight),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: _textLight.withOpacity(0.3)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: _secondaryColor),
                  ),
                ),
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: passengerAgeControllers[index],
                keyboardType: TextInputType.number,
                validator: (value) {
                  final text = (value ?? '').trim();
                  final age = int.tryParse(text);
                  if (age == null || age < 1 || age > 120) {
                    return 'Enter valid age (1-120)';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Age',
                  prefixIcon: Icon(Icons.cake_rounded, color: _textLight),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: _textLight.withOpacity(0.3)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: _secondaryColor),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Gender',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: _textPrimary,
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: ['Male', 'Female'].map((gender) {
                  final canChange = !isRestricted;
                  final isSelected = passengerGenderSelections[index] == gender;
                  final isForced = isRestricted && gender == restrictedGender;
                  
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: canChange
                              ? () {
                                  setState(() {
                                    passengerGenderSelections[index] = gender;
                                  });
                                }
                              : null,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? _secondaryColor.withOpacity(0.15)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected
                                    ? _secondaryColor
                                    : _textLight.withOpacity(0.3),
                                width:  1,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  gender == 'Male' 
                                      ? Icons.male_rounded 
                                      : Icons.female_rounded,
                                  color: isSelected ? _secondaryColor : _textLight,
                                  size: 16,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  gender,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                    color: isSelected ? _secondaryColor : _textLight,
                                  ),
                                ),
                                if (isForced) ...[
                                  SizedBox(width: 4),
                                  Icon(Icons.lock_rounded, size: 12, color: _secondaryColor),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 16,
            offset: Offset(0, -4),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_isLoading)
              LinearProgressIndicator(
                backgroundColor: _backgroundColor,
                color: _secondaryColor,
                minHeight: 3,
              )
            else
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 18),
                  ),
                  onPressed: _isLoading
                      ? null
                      : () async {
                          if (formKey2.currentState!.validate()) {
                            await callApi();
                          }
                        },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _showRetryButton ? Icons.refresh_rounded : Icons.arrow_forward_rounded,
                        size: 20,                          color: Colors.white,

                      ),
                      SizedBox(width: 8),
                      Text(
                        _showRetryButton ? 'Retry Booking' : 'Proceed to Payment',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
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
    final color = isError ? _errorColor : _successColor;
    final icon = isError ? Icons.error_outline_rounded : Icons.check_circle_rounded;

    final snackBar = SnackBar(
      margin: EdgeInsets.all(16),
      behavior: SnackBarBehavior.floating,
      backgroundColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: color.withOpacity(0.2), width: 1),
      ),
      duration: Duration(seconds: 4),
      content: Row(
        children: [
          Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isError ? 'Error' : 'Success',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  message,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      action: SnackBarAction(
        label: 'OK',
        textColor: Colors.white,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}