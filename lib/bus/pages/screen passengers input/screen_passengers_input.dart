import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import 'package:minna/bus/application/change%20location/location_bloc.dart';
import 'package:minna/bus/domain/BlockTicket/block_respo.dart';
import 'package:minna/bus/domain/BlockTicket/block_ticket_request_modal.dart';
import 'package:minna/bus/domain/seatlayout/seatlayoutmodal.dart';
import 'package:minna/bus/infrastructure/get%20block%20key/block_ticket.dart';
import 'package:minna/bus/pages/screen%20conform%20ticket/screen_conform_ticket.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/comman/application/login/login_bloc.dart';
import 'package:minna/comman/pages/log%20in/login_page.dart';
import 'package:minna/comman/widgets/status_bottom_sheet.dart';

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

  // Theme standardizing: Use global constants directly from const.dart

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
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: maincolor1,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Passenger Details',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '${widget.travelsname} • ${widget.selctseat.length} Seats',
              style: TextStyle(
                fontSize: 11,
                color: Colors.white.withOpacity(0.7),
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
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
                    ...List.generate(
                      widget.selctseat.length,
                      (i) => buildPassengerCard(i),
                    ),
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: secondaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Iconsax.bus4, color: secondaryColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.travelsname,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: textPrimary,
                    letterSpacing: -0.2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  widget.trpinfo,
                  style: TextStyle(
                    fontSize: 12,
                    color: textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Iconsax.sms, color: secondaryColor, size: 18),
              const SizedBox(width: 10),
              Text(
                'CONTACT DETAILS',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  color: textSecondary.withOpacity(0.7),
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
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
            style: TextStyle(
              color: textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            decoration: _buildInputDecoration(
              hint: 'Email Address',
              icon: Iconsax.sms,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 70,
                height: 54,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: textLight.withOpacity(0.2)),
                ),
                child: Text(
                  '+91',
                  style: TextStyle(
                    color: textPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 12),
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
                  style: TextStyle(
                    color: textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  decoration: _buildInputDecoration(
                    hint: 'Phone Number',
                    icon: Iconsax.call,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: textSecondary,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      prefixIcon: Icon(icon, color: maincolor1, size: 18),
      filled: true,
      fillColor: backgroundColor.withOpacity(0.5),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: textLight.withOpacity(0.4)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: textLight.withOpacity(0.4)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: maincolor1, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: errorColor.withOpacity(0.5)),
      ),
    );
  }

  Widget buildPassengerCard(int index) {
    final seat = widget.selctseat[index];
    final isRestricted =
        (seat.ladiesSeat == 'true') || (seat.malesSeat == 'true');
    final restrictedGender = seat.ladiesSeat == 'true' ? 'Female' : 'Male';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: maincolor1.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'P${index + 1}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            color: maincolor1,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Passenger info',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: textSecondary.withOpacity(0.5),
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Seat ${seat.name}',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (isRestricted)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: restrictedGender == 'Female'
                          ? Colors.pink.withOpacity(0.08)
                          : Colors.blue.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: restrictedGender == 'Female'
                            ? Colors.pink.withOpacity(0.2)
                            : Colors.blue.withOpacity(0.2),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Iconsax.info_circle,
                          size: 14,
                          color: restrictedGender == 'Female'
                              ? Colors.pink
                              : Colors.blue,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          restrictedGender == 'Female'
                              ? 'LADIES ONLY'
                              : 'GENTS ONLY',
                          style: TextStyle(
                            fontSize: 9,
                            color: restrictedGender == 'Female'
                                ? Colors.pink
                                : Colors.blue,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: passengerNameControllers[index],
              validator: (value) => (value == null || value.trim().isEmpty)
                  ? 'Please enter name'
                  : null,
              style: TextStyle(
                color: textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              decoration: _buildInputDecoration(
                hint: 'Full Name',
                icon: Iconsax.user,
              ),
            ),
            const SizedBox(height: 12),
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
              style: TextStyle(
                color: textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              decoration: _buildInputDecoration(
                hint: 'Passenger Age',
                icon: Iconsax.cake,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'GENDER SELECTION',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                color: textSecondary.withOpacity(0.5),
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: ['Male', 'Female'].map((gender) {
                final canChange = !isRestricted;
                final isSelected = passengerGenderSelections[index] == gender;
                final isForced = isRestricted && gender == restrictedGender;

                return Expanded(
                  child: GestureDetector(
                    onTap: canChange
                        ? () {
                            setState(() {
                              passengerGenderSelections[index] = gender;
                            });
                          }
                        : null,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: EdgeInsets.only(
                        left: gender == 'Female' ? 6 : 0,
                        right: gender == 'Male' ? 6 : 0,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? maincolor1
                            : backgroundColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? maincolor1
                              : textLight.withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            gender == 'Male' ? Iconsax.man : Iconsax.woman,
                            color: isSelected ? Colors.white : textSecondary,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            gender,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: isSelected
                                  ? FontWeight.w800
                                  : FontWeight.w600,
                              color: isSelected ? Colors.white : textSecondary,
                            ),
                          ),
                          if (isForced) ...[
                            const SizedBox(width: 6),
                            Icon(
                              Icons.lock,
                              size: 12,
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSection() {
    double totalFare = 0;
    for (var seat in widget.selctseat) {
      totalFare += double.tryParse(seat.baseFare) ?? 0;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_isLoading)
              const LinearProgressIndicator(
                backgroundColor: maincolor1,
                color: secondaryColor,
                minHeight: 3,
              )
            else
              Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TOTAL FARE',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            color: textSecondary.withOpacity(0.6),
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '₹${totalFare.toStringAsFixed(0)}',
                          style: const TextStyle(
                            color: secondaryColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: maincolor1,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
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
                          Text(
                            _showRetryButton ? 'RETRY' : 'CONTINUE',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1,
                            ),
                          ),
                          // const SizedBox(width: 8),
                          // Icon(
                          //   _showRetryButton
                          //       ? Icons.refresh_rounded
                          //       : Iconsax.arrow_right_3,
                          //   size: 16,
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
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
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => const LoginBottomSheet(login: 1),
      );
      final newLoginState = context.read<LoginBloc>().state;
      if (newLoginState.isLoggedIn != true) {
        _showStatusBottomSheet(
          title: 'Login Required',
          message:
              'Please login to your account to continue with the booking process.',
        );
        return;
      }
    }

    // limit retries to 3 attempts
    if (retryCount >= 3) {
      _showStatusBottomSheet(
        title: 'Limit Reached',
        message:
            'Maximum retry attempts reached. Please check your connection or contact support.',
        showContactSupport: true,
      );
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
          _showStatusBottomSheet(
            title: 'Server Error',
            message:
                'We encountered an error while processing your request. Please try again.',
          );
          setState(() => _showRetryButton = true);
          return;
        }
        final BlockResponse respoData = BlockResponse.fromJson(
          jsonDecode(body),
        );
        final blockKey = respoData.blockKey;

        // reset retryCount on success
        retryCount = 0;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ScreenConfirmTicket(
              blockResponse: respoData,
              blockKey: blockKey,
              selectedSeats: widget.selctseat,
              alldata: widget.alldata,
            ),
          ),
        );
      } else {
        // Non-200 status
        _showStatusBottomSheet(
          title: 'Connection Issue',
          message:
              'Unable to connect to the server (Error ${response.statusCode}). Please check your connection or try again.',
        );
        setState(() => _showRetryButton = true);
      }
    } catch (e, st) {
      log('API error: ${e.toString()}');
      log(st.toString());
      _showStatusBottomSheet(
        title: 'Sorry, some issue',
        message:
            'The server is currently busy or under maintenance. Please try again later or connect with our support.',
        showContactSupport: true,
      );
      setState(() => _showRetryButton = true);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showStatusBottomSheet({
    required String title,
    required String message,
    StatusType type = StatusType.error,
    bool showContactSupport = false,
  }) {
    StatusBottomSheet.show(
      context: context,
      type: type,
      title: title,
      message: message,
      showContactSupport: showContactSupport,
    );
  }
}
