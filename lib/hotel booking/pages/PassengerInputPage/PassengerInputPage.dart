import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/hotel%20booking/domain/authentication/authendication.dart';
import 'package:minna/hotel%20booking/domain/hotel%20details%20/hotel_details.dart';
import 'package:minna/hotel%20booking/domain/hotel%20list/hotel_list.dart';
import 'package:minna/hotel%20booking/domain/rooms/rooms.dart';
import 'package:minna/hotel%20booking/functions/auth.dart';
import 'package:minna/hotel%20booking/pages/booking%20confirm%20page/booking_confirm.dart';

class PassengerInputPage extends StatefulWidget {
  final RoomDetail room;
  final HotelSearchItem hotel;
  final PreBookResponseWithAuth preBookResponse;
  final String prebookId;
  final List<Map<String, dynamic>> rooms;

  const PassengerInputPage({
    super.key,
    required this.room,
    required this.hotel,
    required this.preBookResponse,
    required this.prebookId,
    required this.rooms,
  });

  @override
  _PassengerInputPageState createState() => _PassengerInputPageState();
}

class _PassengerInputPageState extends State<PassengerInputPage> {
  final _formKey = GlobalKey<FormState>();
  final AuthApiService _apiService = AuthApiService();
  
  List<List<Map<String, dynamic>>> roomPassengers = [];
  bool _isSubmitting = false;

  // Theme colors
  final Color _primaryColor = Colors.black;
  final Color _secondaryColor = Color(0xFFD4AF37);
  final Color _backgroundColor = Color(0xFFF8F9FA);
  final Color _cardColor = Colors.white;
  final Color _textPrimary = Colors.black;
  final Color _textSecondary = Color(0xFF666666);
  final Color _textLight = Color(0xFF999999);
  final Color _errorColor = Color(0xFFE53935);
  final Color _successColor = Color(0xFF4CAF50);
  final Color _warningColor = Color(0xFFFF9800);

  final List<String> _titles = ['Mr.', 'Mrs.', 'Ms.', 'Dr.', 'Prof.'];
  final List<String> _paxTypes = ['Adult', 'Child', 'Infant'];

  final Map<int, Map<int, bool>> _roomValidations = {};

  @override
  void initState() {
    super.initState();
    _initializePassengers();
  }

  void _initializePassengers() {
    final numberOfRooms = widget.rooms.length;
    roomPassengers = List.generate(numberOfRooms, (roomIndex) {
      final roomConfig = widget.rooms[roomIndex];
      final adults = roomConfig['adults'] as int? ?? 0;
      final children = roomConfig['children'] as int? ?? 0;
      final totalPassengers = adults + children;
      final childrenAges = roomConfig['childrenAges'] as List<int>? ?? [];
      
      _roomValidations[roomIndex] = {};
      
      // Create passenger list for this room
      List<Map<String, dynamic>> passengers = [];
      
      // Add adults
      for (int i = 0; i < adults; i++) {
        passengers.add({
          "Title": 'Mr.',
          "FirstName": '',
          "LastName": '',
          "Email": '',
          "Phone": '',
          "PaxType": 1, // Adult
          "LeadPassenger": i == 0, // First adult is lead
          "Age": 0,
          "PAN": '',
          "Passport": '',
        });
        _roomValidations[roomIndex]![i] = false;
      }
      
      // Add children
      for (int i = 0; i < children; i++) {
        final childAge = i < childrenAges.length ? childrenAges[i] : 0;
        passengers.add({
          "Title": '',
          "FirstName": '',
          "LastName": '',
          "Email": '',
          "Phone": '',
          "PaxType": 2, // Child
          "LeadPassenger": false, // Children can't be lead
          "Age": childAge,
          "PAN": '',
          "Passport": '',
        });
        _roomValidations[roomIndex]![adults + i] = false;
      }
      
      return passengers;
    });
  }

  ValidationInfo get _validationInfo => widget.preBookResponse.preBookResponse.validationInfo ?? ValidationInfo(
    panMandatory: false,
    passportMandatory: false,
    corporateBookingAllowed: false,
    panCountRequired: 0,
    samePaxNameAllowed: true,
    spaceAllowed: true,
    specialCharAllowed: false,
    paxNameMinLength: 0,
    paxNameMaxLength: 50,
    charLimit: true,
    packageFare: false,
    packageDetailsMandatory: false,
    departureDetailsMandatory: false,
    gstAllowed: false,
  );

  void _updatePassengerValidation(int roomIndex, int passengerIndex, bool isValid) {
    setState(() {
      _roomValidations[roomIndex] ??= {};
      _roomValidations[roomIndex]![passengerIndex] = isValid;
    });
  }

  bool get _allPassengersValid {
    if (roomPassengers.isEmpty) return false;
    
    for (int roomIndex = 0; roomIndex < roomPassengers.length; roomIndex++) {
      final room = roomPassengers[roomIndex];
      for (int passengerIndex = 0; passengerIndex < room.length; passengerIndex++) {
        if (_roomValidations[roomIndex]?[passengerIndex] != true) {
          return false;
        }
      }
    }
    return true;
  }

  bool _isRoomValid(int roomIndex) {
    final room = roomPassengers[roomIndex];
    for (int passengerIndex = 0; passengerIndex < room.length; passengerIndex++) {
      if (_roomValidations[roomIndex]?[passengerIndex] != true) {
        return false;
      }
    }
    return room.isNotEmpty;
  }

  void _showValidationError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: _errorColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: _primaryColor,
            expandedHeight: 120,
            floating: false,
            pinned: true,
            elevation: 4,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_rounded, color: Colors.white),
              onPressed: _isSubmitting ? null : () => Navigator.pop(context),
            ),
            shadowColor: Colors.black.withOpacity(0.3),
            surfaceTintColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Passenger Details',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: true,
              background: Container(
                color: _primaryColor,
              ),
            ),
          ),

          // SliverToBoxAdapter(
          //   child: _buildValidationRequirements(),
          // ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, roomIndex) => _buildRoomSection(roomIndex),
              childCount: roomPassengers.length,
            ),
          ),

          SliverToBoxAdapter(
            child: _buildSubmitButton(),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 30)),
        ],
      ),
    );
  }

  Widget _buildValidationRequirements() {
    final requirements = <String>[];
    
    if (_validationInfo.panMandatory) {
      requirements.add('PAN card details are mandatory');
    }
    if (_validationInfo.passportMandatory) {
      requirements.add('Passport details are mandatory');
    }
    if (_validationInfo.paxNameMinLength > 0) {
      requirements.add('Name must be at least ${_validationInfo.paxNameMinLength} characters');
    }
    if (!_validationInfo.specialCharAllowed) {
      requirements.add('Special characters not allowed in names');
    }
    if (!_validationInfo.spaceAllowed) {
      requirements.add('Spaces not allowed in names');
    }

    if (requirements.isEmpty) return SizedBox();

    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _secondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _secondaryColor.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline_rounded, color: _secondaryColor, size: 18),
              SizedBox(width: 8),
              Text(
                'Important Requirements',
                style: TextStyle(
                  color: _textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: requirements.map((req) => Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: Text(
                '• $req',
                style: TextStyle(
                  color: _textSecondary,
                  fontSize: 12,
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomSection(int roomIndex) {
    final roomConfig = widget.rooms[roomIndex];
    final adults = roomConfig['adults'] as int? ?? 0;
    final children = roomConfig['children'] as int? ?? 0;
    final totalPassengers = adults + children;
    final isRoomValid = _isRoomValid(roomIndex);
    final roomName = roomIndex < widget.room.name.length 
        ? widget.room.name[roomIndex] 
        : 'Room ${roomIndex + 1}';

    return Container(padding: EdgeInsets.symmetric(horizontal: 5),
      // margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        
        color: _cardColor,
        // borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    color: _secondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.room_rounded,
                    color: _secondaryColor,
                    size: 20,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Room ${roomIndex + 1}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: _textPrimary,
                            ),
                          ),
                          SizedBox(width: 8),
                          _buildRoomValidationIndicator(roomIndex),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              roomName,
                              style: TextStyle(
                                color: _textSecondary,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: _backgroundColor,
                              borderRadius: BorderRadius.circular(4),
                              // border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Text(
                              '$adults Adult${adults > 1 ? 's' : ''}${children > 0 ? ', $children Child${children > 1 ? 'ren' : ''}' : ''}',
                              style: TextStyle(
                                fontSize: 11,
                                color: _textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
Divider(),
            ...roomPassengers[roomIndex].asMap().entries.map((entry) {
              final passengerIndex = entry.key;
              final passenger = entry.value;
              final isAdult = passenger['PaxType'] == 1;
              
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: _buildPassengerForm(roomIndex, passengerIndex, isAdult),
              );
            }),

            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _backgroundColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: _textLight,
                    size: 16,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Total $totalPassengers passenger${totalPassengers > 1 ? 's' : ''} (${adults} adult${adults > 1 ? 's' : ''}${children > 0 ? ', ${children} child${children > 1 ? 'ren' : ''}' : ''})',
                      style: TextStyle(
                        fontSize: 12,
                        color: _textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            if (roomIndex < roomPassengers.length - 1) 
              Divider(height: 30, color: Colors.grey.shade200),
          ],
        ),
      ),
    );
  }

  Widget _buildRoomValidationIndicator(int roomIndex) {
    final isValid = _isRoomValid(roomIndex);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: isValid ? _successColor.withOpacity(0.1) : _errorColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isValid ? _successColor.withOpacity(0.3) : _errorColor.withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isValid ? Icons.check_circle : Icons.error_outline,
            size: 12,
            color: isValid ? _successColor : _errorColor,
          ),
          SizedBox(width: 4),
          Text(
            isValid ? 'Complete' : 'Incomplete',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: isValid ? _successColor : _errorColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPassengerForm(int roomIndex, int passengerIndex, bool isAdult) {
    final passenger = roomPassengers[roomIndex][passengerIndex];
    final isLeadPassenger = passenger['LeadPassenger'];
    final isFirstPassenger = passengerIndex == 0;

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        // border: Border.all(
        //   color: isAdult ? _primaryColor.withOpacity(0.1) : _warningColor.withOpacity(0.1),
        // ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: isAdult ? _secondaryColor.withOpacity(0.1) : _warningColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  isAdult ? Icons.person_rounded : Icons.child_care_rounded,
                  color: isAdult ? _secondaryColor : _warningColor,
                  size: 16,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${isAdult ? 'Adult' : 'Child'} ${passengerIndex + 1}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: _textPrimary,
                          ),
                        ),
                        SizedBox(width: 8),
                        _buildPassengerValidationIndicator(roomIndex, passengerIndex),
                        if (isLeadPassenger) ...[
                          SizedBox(width: 8),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: _secondaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Lead',
                              style: TextStyle(
                                fontSize: 10,
                                color: _secondaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                        if (!isAdult) ...[
                          SizedBox(width: 8),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: _warningColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Child',
                              style: TextStyle(
                                fontSize: 10,
                                color: _warningColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          Form(
            key: Key('passenger_form_${roomIndex}_$passengerIndex'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: () {
              _validatePassengerForm(roomIndex, passengerIndex);
            },
            child: Column(
              children: [
                if (isAdult) _buildTitleDropdown(roomIndex, passengerIndex),
                if (isAdult) SizedBox(height: 12),
                _buildNameFields(roomIndex, passengerIndex, isAdult),
                SizedBox(height: 12),
                if (isAdult) _buildContactSection(roomIndex, passengerIndex),
                SizedBox(height: 12),
                _buildAgeField(roomIndex, passengerIndex, isAdult),
                if (isAdult) SizedBox(height: 12),
                if (isAdult && (_validationInfo.panMandatory || _validationInfo.passportMandatory))
                  _buildDocumentsSection(roomIndex, passengerIndex),
              ],
            ),
          ),

          if (isAdult && !isFirstPassenger)
            _buildLeadPassengerToggle(roomIndex, passengerIndex),
        ],
      ),
    );
  }

  Widget _buildPassengerValidationIndicator(int roomIndex, int passengerIndex) {
    final isValid = _roomValidations[roomIndex]?[passengerIndex] == true;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      decoration: BoxDecoration(
        color: isValid ? _successColor.withOpacity(0.1) : _errorColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isValid ? _successColor.withOpacity(0.3) : _errorColor.withOpacity(0.3),
        ),
      ),
      child: Text(
        isValid ? '✓' : '!',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: isValid ? _successColor : _errorColor,
        ),
      ),
    );
  }

  void _validatePassengerForm(int roomIndex, int passengerIndex) {
    final passenger = roomPassengers[roomIndex][passengerIndex];
    final isAdult = passenger['PaxType'] == 1;
    
    bool isValid = true;
    
    if (passenger['FirstName']?.isEmpty ?? true) isValid = false;
    if (passenger['LastName']?.isEmpty ?? true) isValid = false;
    if (isAdult) {
      if (passenger['Email']?.isEmpty ?? true) isValid = false;
      if (passenger['Phone']?.isEmpty ?? true) isValid = false;
    }
    if ((passenger['Age'] ?? 0) <= 0) isValid = false;
    
    if (isAdult) {
      if (_validationInfo.panMandatory && (passenger['PAN']?.isEmpty ?? true)) isValid = false;
      if (_validationInfo.passportMandatory && (passenger['Passport']?.isEmpty ?? true)) isValid = false;
      
      if (passenger['Email']?.isNotEmpty == true) {
        final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
        if (!emailRegex.hasMatch(passenger['Email'])) isValid = false;
      }
      
      if (passenger['Phone']?.isNotEmpty == true) {
        if (passenger['Phone'].length < 8) isValid = false;
      }
    }
    
    _updatePassengerValidation(roomIndex, passengerIndex, isValid);
  }

  Widget _buildTitleDropdown(int roomIndex, int passengerIndex) {
    return DropdownButtonFormField<String>(
      value: roomPassengers[roomIndex][passengerIndex]['Title'],
      decoration: InputDecoration(
        labelText: 'Title',
        labelStyle: TextStyle(color: Colors.grey[700]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        filled: true,
        fillColor: Colors.grey[50],
        prefixIcon: Icon(Icons.title, color: Colors.grey[600]),
      ),
      items: _titles.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(fontSize: 12)),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          roomPassengers[roomIndex][passengerIndex]['Title'] = newValue!;
        });
        _validatePassengerForm(roomIndex, passengerIndex);
      },
    );
  }

  Widget _buildNameFields(int roomIndex, int passengerIndex, bool isAdult) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Full Name', style: TextStyle(color: _textSecondary, fontWeight: FontWeight.w500, fontSize: 14)),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                initialValue: roomPassengers[roomIndex][passengerIndex]['FirstName'],
                decoration: InputDecoration(
                  labelText: 'First Name',
                  labelStyle: TextStyle(fontSize: 13),
                  filled: true,
                  fillColor: _backgroundColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  prefixIcon: Icon(Icons.person_outline_rounded, color: _textLight),
                ),
                validator: (value) => _validateName(value, 'First Name'),
                onChanged: (value) {
                  setState(() {
                    roomPassengers[roomIndex][passengerIndex]['FirstName'] = value;
                  });
                  _validatePassengerForm(roomIndex, passengerIndex);
                },
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                initialValue: roomPassengers[roomIndex][passengerIndex]['LastName'],
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  labelStyle: TextStyle(fontSize: 13),
                  filled: true,
                  fillColor: _backgroundColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                ),
                validator: (value) => _validateName(value, 'Last Name'),
                onChanged: (value) {
                  setState(() {
                    roomPassengers[roomIndex][passengerIndex]['LastName'] = value;
                  });
                  _validatePassengerForm(roomIndex, passengerIndex);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContactSection(int roomIndex, int passengerIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Contact Information', style: TextStyle(color: _textSecondary, fontWeight: FontWeight.w500, fontSize: 14)),
        SizedBox(height: 8),
        TextFormField(
          initialValue: roomPassengers[roomIndex][passengerIndex]['Email'],
          decoration: InputDecoration(
            labelText: 'Email Address',
            labelStyle: TextStyle(fontSize: 13),
            filled: true,
            fillColor: _backgroundColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            prefixIcon: Icon(Icons.email_outlined, color: _textLight),
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) return 'Please enter your email';
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) return 'Please enter a valid email';
            return null;
          },
          onChanged: (value) {
            setState(() {
              roomPassengers[roomIndex][passengerIndex]['Email'] = value;
            });
            _validatePassengerForm(roomIndex, passengerIndex);
          },
        ),
        SizedBox(height: 12),
        TextFormField(
          initialValue: roomPassengers[roomIndex][passengerIndex]['Phone'],
          decoration: InputDecoration(
            labelText: 'Phone Number',
            labelStyle: TextStyle(fontSize: 13),
            filled: true,
            fillColor: _backgroundColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            prefixIcon: Icon(Icons.phone_outlined, color: _textLight),
          ),
          keyboardType: TextInputType.phone,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (value) {
            if (value == null || value.isEmpty) return 'Please enter phone number';
            if (value.length < 8) return 'Enter valid phone number';
            return null;
          },
          onChanged: (value) {
            setState(() {
              roomPassengers[roomIndex][passengerIndex]['Phone'] = value;
            });
            _validatePassengerForm(roomIndex, passengerIndex);
          },
        ),
      ],
    );
  }

  Widget _buildAgeField(int roomIndex, int passengerIndex, bool isAdult) {
    return TextFormField(
      initialValue: roomPassengers[roomIndex][passengerIndex]['Age']?.toString(),
      decoration: InputDecoration(
        labelText: isAdult ? 'Age' : 'Child Age',
        labelStyle: TextStyle(fontSize: 13),
        filled: true,
        fillColor: _backgroundColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        prefixIcon: Icon(Icons.cake_outlined, color: _textLight),
        suffixText: 'years',
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please enter age';
        final age = int.tryParse(value);
        if (age == null || age < 0 || age > 120) return 'Please enter valid age';
        if (!isAdult && age >= 18) return 'Child age must be below 18';
        if (isAdult && age < 18) return 'Adult age must be 18 or above';
        return null;
      },
      onChanged: (value) {
        setState(() {
          roomPassengers[roomIndex][passengerIndex]['Age'] = int.tryParse(value) ?? 0;
        });
        _validatePassengerForm(roomIndex, passengerIndex);
      },
    );
  }

  Widget _buildDocumentsSection(int roomIndex, int passengerIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Additional Documents', style: TextStyle(color: _textSecondary, fontWeight: FontWeight.w500, fontSize: 14)),
        SizedBox(height: 8),
        if (_validationInfo.panMandatory)
          TextFormField(
            initialValue: roomPassengers[roomIndex][passengerIndex]['PAN'],
            decoration: InputDecoration(
              labelText: 'PAN Number',
              labelStyle: TextStyle(fontSize: 13),
              filled: true,
              fillColor: _backgroundColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              prefixIcon: Icon(Icons.credit_card_rounded, color: _textLight),
            ),
            validator: (value) {
              if (_validationInfo.panMandatory && (value == null || value.isEmpty)) return 'PAN number is mandatory';
              return null;
            },
            onChanged: (value) {
              setState(() {
                roomPassengers[roomIndex][passengerIndex]['PAN'] = value;
              });
              _validatePassengerForm(roomIndex, passengerIndex);
            },
          ),
        if (_validationInfo.panMandatory) SizedBox(height: 12),
        if (_validationInfo.passportMandatory)
          TextFormField(
            initialValue: roomPassengers[roomIndex][passengerIndex]['Passport'],
            decoration: InputDecoration(
              labelText: 'Passport Number',
              labelStyle: TextStyle(fontSize: 13),
              filled: true,
              fillColor: _backgroundColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              prefixIcon: Icon(Icons.airplane_ticket_rounded, color: _textLight),
            ),
            validator: (value) {
              if (_validationInfo.passportMandatory && (value == null || value.isEmpty)) return 'Passport number is mandatory';
              return null;
            },
            onChanged: (value) {
              setState(() {
                roomPassengers[roomIndex][passengerIndex]['Passport'] = value;
              });
              _validatePassengerForm(roomIndex, passengerIndex);
            },
          ),
      ],
    );
  }

  Widget _buildLeadPassengerToggle(int roomIndex, int passengerIndex) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _secondaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _secondaryColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.star_rounded, color: _secondaryColor, size: 18),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Lead Passenger', style: TextStyle(color: _textPrimary, fontWeight: FontWeight.w600, fontSize: 14)),
                SizedBox(height: 2),
                Text(
                  'This passenger will receive all booking communications',
                  style: TextStyle(color: _textSecondary, fontSize: 11),
                ),
              ],
            ),
          ),
          Switch(
            value: roomPassengers[roomIndex][passengerIndex]['LeadPassenger'],
            onChanged: (value) {
              setState(() {
                if (value) {
                  for (int i = 0; i < roomPassengers[roomIndex].length; i++) {
                    roomPassengers[roomIndex][i]['LeadPassenger'] = (i == passengerIndex);
                  }
                } else {
                  roomPassengers[roomIndex][passengerIndex]['LeadPassenger'] = false;
                  if (!roomPassengers[roomIndex].any((p) => p['LeadPassenger'])) {
                    roomPassengers[roomIndex][0]['LeadPassenger'] = true;
                  }
                }
              });
            },
            activeThumbColor: _secondaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    final isFormValid = _allPassengersValid;
    final totalRooms = roomPassengers.length;
    final totalPassengers = roomPassengers.fold(0, (sum, room) => sum + room.length);

    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        children: [
          if (!isFormValid)
            Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Text(
                'Please complete all passenger details in all rooms to continue',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _errorColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ElevatedButton(
            onPressed: isFormValid && !_isSubmitting ? _submitForm : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: isFormValid ? _primaryColor : Colors.grey[400],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              padding: EdgeInsets.symmetric(vertical: 18),
              elevation: 2,
              minimumSize: Size(double.infinity, 50),
            ),
            child: _isSubmitting
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_forward_rounded, size: 20),
                      SizedBox(width: 12),
                      Text(
                        'Continue to Preview',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  String? _validateName(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter $fieldName';
    }
    
    if (!_validationInfo.spaceAllowed && value.contains(' ')) {
      return 'Spaces are not allowed in $fieldName';
    }
    
    if (!_validationInfo.specialCharAllowed && _containsSpecialCharacters(value)) {
      return 'Special characters are not allowed in $fieldName';
    }
    
    if (_validationInfo.paxNameMinLength > 0 && value.length < _validationInfo.paxNameMinLength) {
      return '$fieldName must be at least ${_validationInfo.paxNameMinLength} characters';
    }
    
    if (_validationInfo.charLimit && value.length > _validationInfo.paxNameMaxLength) {
      return '$fieldName must be less than ${_validationInfo.paxNameMaxLength} characters';
    }
    
    return null;
  }

  bool _containsSpecialCharacters(String value) {
    final specialCharRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    return specialCharRegex.hasMatch(value);
  }

  void _submitForm() {
    if (!_allPassengersValid) {
      _showValidationError('Please complete all passenger details in all rooms before proceeding');
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    if (!_validationInfo.samePaxNameAllowed) {
      final allNames = <String>[];
      for (final room in roomPassengers) {
        for (final passenger in room) {
          final name = '${passenger['FirstName']} ${passenger['LastName']}'.toLowerCase().trim();
          if (name.isNotEmpty) {
            allNames.add(name);
          }
        }
      }
      final uniqueNames = allNames.toSet();
      if (allNames.length != uniqueNames.length) {
        setState(() {
          _isSubmitting = false;
        });
        _showValidationError('Passenger names must be unique across all rooms');
        return;
      }
    }

    if (_validationInfo.panCountRequired > 0) {
      final panCount = roomPassengers.fold(0, (count, room) => 
        count + room.where((p) => p['PaxType'] == 1 && (p['PAN'] as String).isNotEmpty).length);
      if (panCount < _validationInfo.panCountRequired) {
        setState(() {
          _isSubmitting = false;
        });
        _showValidationError('PAN details required for ${_validationInfo.panCountRequired} adult passenger(s)');
        return;
      }
    }

    final allPassengers = roomPassengers.expand((room) => room).toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HotelBookingConfirmationPage(
          prebookId: widget.prebookId,
          room: widget.room,
          hotel: widget.hotel,
          passengers: allPassengers,
          roomPassengers: roomPassengers,
          bookingId: widget.room.bookingCode,
          preBookResponse: widget.preBookResponse,
        ),
      ),
    ).then((_) {
      setState(() {
        _isSubmitting = false;
      });
    });
  }
}