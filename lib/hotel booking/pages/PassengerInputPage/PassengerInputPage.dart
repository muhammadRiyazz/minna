import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/hotel%20booking/domain/authentication/authendication.dart';
import 'package:minna/hotel%20booking/domain/hotel%20details%20/hotel_details.dart';
import 'package:minna/hotel%20booking/domain/rooms/rooms.dart';
import 'package:minna/hotel%20booking/functions/auth.dart';
import 'package:minna/hotel%20booking/pages/booking%20confirm%20page/booking_confirm.dart';

class PassengerInputPage extends StatefulWidget {
  final Room room;
  final HotelSearchRequest hotelSearchRequest;
  final HotelDetail hotel;
  final PreBookResponse preBookResponse;

  const PassengerInputPage({
    super.key,
    required this.room,
    required this.hotelSearchRequest,
    required this.hotel,
    required this.preBookResponse,
  });

  @override
  _PassengerInputPageState createState() => _PassengerInputPageState();
}

class _PassengerInputPageState extends State<PassengerInputPage> {
  final _formKey = GlobalKey<FormState>();
  final AuthApiService _apiService = AuthApiService();
  
  // Structure: List of rooms, each room contains list of passengers
  List<List<Map<String, dynamic>>> roomPassengers = [];
  bool _isLoading = false;
  String? _errorMessage;
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

  // Track form validation state: roomIndex -> passengerIndex -> isValid
  final Map<int, Map<int, bool>> _roomValidations = {};

  @override
  void initState() {
    super.initState();
    _initializePassengers();
  }

  void _initializePassengers() {
    // Initialize passengers based on room configuration
    // Each room starts with one passenger
    final numberOfRooms = widget.room.name.length;
    roomPassengers = List.generate(numberOfRooms, (roomIndex) {
      _roomValidations[roomIndex] = {0: false}; // Initialize validation for first passenger
      return [
        {
          "Title": 'Mr.',
          "FirstName": '',
          "LastName": '',
          "Email": '',
          "Phone": '',
          "PaxType": 1,
          "LeadPassenger": true, // First passenger in each room is lead by default
          "Age": 0,
          "PAN": '',
          "Passport": '',
        }
      ];
    });
  }

  ValidationInfo get _validationInfo => widget.preBookResponse.validationInfo ?? ValidationInfo(
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
    return room.isNotEmpty; // Room must have at least one passenger
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
          // App Bar
          SliverAppBar(
            backgroundColor: _primaryColor,
            expandedHeight: 120,
            floating: false,
            pinned: true,
            elevation: 4,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_rounded, color: Colors.white),
              onPressed: _isLoading ? null : () => Navigator.pop(context),
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
              background: Container(color:_primaryColor ,
                // decoration: BoxDecoration(
                //   gradient: LinearGradient(
                //     begin: Alignment.topLeft,
                //     end: Alignment.bottomRight,
                //     colors: [_primaryColor, Color(0xFF2D2D2D)],
                //   ),
                // ),
              ),
            ),
          ),

          // Error Message
          if (_errorMessage != null)
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _errorColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _errorColor.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error_outline_rounded, color: _errorColor),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _errorMessage!,
                        style: TextStyle(color: _errorColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Validation Requirements
          SliverToBoxAdapter(
            child: _buildValidationRequirements(),
          ),

          // Room-wise Passenger Forms
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, roomIndex) {
                return _buildRoomSection(roomIndex);
              },
              childCount: roomPassengers.length,
            ),
          ),

          // Submit Button
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
    final roomName = roomIndex < widget.room.name.length 
        ? widget.room.name[roomIndex] 
        : 'Room ${roomIndex + 1}';
    final isRoomValid = _isRoomValid(roomIndex);
    final totalPassengers = roomPassengers[roomIndex].length;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(16),
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
            // Room Header
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
                      ),                          SizedBox(height: 5),

                      Text(
                        roomName,
                        style: TextStyle(
                          color: _textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Passengers for this room
            ...roomPassengers[roomIndex].asMap().entries.map((entry) {
              final passengerIndex = entry.key;
              return _buildPassengerForm(roomIndex, passengerIndex);
            }).toList(),

            // Add Passenger Button for this room
            Container(
              margin: EdgeInsets.only(top: 16),
              child: OutlinedButton(
                onPressed: () => _addPassengerToRoom(roomIndex),
                style: OutlinedButton.styleFrom(
                  foregroundColor: _secondaryColor,
                  side: BorderSide(color: _secondaryColor),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person_add_rounded, size: 18),
                    SizedBox(width: 8),
                    Text(
                      'Add Passenger to Room ${roomIndex + 1}',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                  ],
                ),
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

  Widget _buildPassengerForm(int roomIndex, int passengerIndex) {
    final passenger = roomPassengers[roomIndex][passengerIndex];
    final isLeadPassenger = passenger['LeadPassenger'];
    final isFirstPassenger = passengerIndex == 0;

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(10), 
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(12),
        // border: Border.all(
        //   color: isLeadPassenger ? _secondaryColor.withOpacity(0.3) : Colors.transparent,
        //   width: isLeadPassenger ? 2 : 1,
        // ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Passenger Header
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: _secondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.person_rounded,
                  color: _secondaryColor,
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
                          'Passenger ${passengerIndex + 1}',
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
                      ],
                    ),
                  ],
                ),
              ),
              if (!isFirstPassenger)
                IconButton(
                  onPressed: () => _removePassengerFromRoom(roomIndex, passengerIndex),
                  icon: Icon(Icons.delete_outline_rounded, color: _errorColor, size: 18),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  tooltip: 'Remove passenger',
                ),
            ],
          ),
          SizedBox(height: 16),

          // Form Fields
          Form(
            key: Key('passenger_form_${roomIndex}_$passengerIndex'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: () {
              _validatePassengerForm(roomIndex, passengerIndex);
            },
            child: Column(
              children: [
                // Title Dropdown
                _buildTitleDropdown(roomIndex, passengerIndex),
                SizedBox(height: 12),

                // Name Fields
                _buildNameFields(roomIndex, passengerIndex),
                SizedBox(height: 12),

                // Contact Information
                _buildContactSection(roomIndex, passengerIndex),
                SizedBox(height: 12),

                // Age and Pax Type
                _buildAgeAndTypeSection(roomIndex, passengerIndex),
                SizedBox(height: 12),

                // Additional Documents
                if (_validationInfo.panMandatory || _validationInfo.passportMandatory)
                  _buildDocumentsSection(roomIndex, passengerIndex),
              ],
            ),
          ),

          // Lead Passenger Toggle (only show for non-first passengers)
          if (!isFirstPassenger)
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
    
    bool isValid = true;
    
    // Check basic required fields
    if (passenger['FirstName']?.isEmpty ?? true) isValid = false;
    if (passenger['LastName']?.isEmpty ?? true) isValid = false;
    if (passenger['Email']?.isEmpty ?? true) isValid = false;
    if (passenger['Phone']?.isEmpty ?? true) isValid = false;
    if ((passenger['Age'] ?? 0) <= 0) isValid = false;
    
    // Check document requirements
    if (_validationInfo.panMandatory && (passenger['PAN']?.isEmpty ?? true)) isValid = false;
    if (_validationInfo.passportMandatory && (passenger['Passport']?.isEmpty ?? true)) isValid = false;
    
    // Validate email format
    if (passenger['Email']?.isNotEmpty == true) {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(passenger['Email'])) isValid = false;
    }
    
    // Validate phone length
    if (passenger['Phone']?.isNotEmpty == true) {
      if (passenger['Phone'].length < 8) isValid = false;
    }
    
    _updatePassengerValidation(roomIndex, passengerIndex, isValid);
  }

  // ... (Keep all the existing _buildTitleDropdown, _buildNameFields, _buildContactSection, 
  // _buildAgeAndTypeSection, _buildDocumentsSection, _buildLeadPassengerToggle methods 
  // but update them to accept roomIndex and passengerIndex parameters)

  // Updated methods with roomIndex and passengerIndex parameters
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
        return DropdownMenuItem<String>(value: value, child: Text(value,style: TextStyle(fontSize: 12),));
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          roomPassengers[roomIndex][passengerIndex]['Title'] = newValue!;
        });
        _validatePassengerForm(roomIndex, passengerIndex);
      },
    );
  }

  Widget _buildNameFields(int roomIndex, int passengerIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Full Name', style: TextStyle(color: _textSecondary, fontWeight: FontWeight.w500, fontSize: 14)),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: TextFormField(
              decoration: InputDecoration(            labelStyle: TextStyle(fontSize: 13),

                labelText: 'First Name', filled: true, fillColor: _backgroundColor,
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
                setState(() { roomPassengers[roomIndex][passengerIndex]['FirstName'] = value; });
                _validatePassengerForm(roomIndex, passengerIndex);
              },
            )),
            SizedBox(width: 12),
            Expanded(child: TextFormField(
              decoration: InputDecoration(            labelStyle: TextStyle(fontSize: 13),

                labelText: 'Last Name', filled: true, fillColor: _backgroundColor,
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
                setState(() { roomPassengers[roomIndex][passengerIndex]['LastName'] = value; });
                _validatePassengerForm(roomIndex, passengerIndex);
              },
            )),
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
          decoration: InputDecoration(
            labelStyle: TextStyle(fontSize: 13),
            labelText: 'Email Address', filled: true, fillColor: _backgroundColor,
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
            setState(() { roomPassengers[roomIndex][passengerIndex]['Email'] = value; });
            _validatePassengerForm(roomIndex, passengerIndex);
          },
        ),
        SizedBox(height: 12),
        TextFormField(
          decoration: InputDecoration(
                        labelStyle: TextStyle(fontSize: 13),

            labelText: 'Phone Number', filled: true, fillColor: _backgroundColor,
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
            setState(() { roomPassengers[roomIndex][passengerIndex]['Phone'] = value; });
            _validatePassengerForm(roomIndex, passengerIndex);
          },
        ),
      ],
    );
  }

  Widget _buildAgeAndTypeSection(int roomIndex, int passengerIndex) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
                        labelStyle: TextStyle(fontSize: 13),

            labelText: 'Age', filled: true, fillColor: _backgroundColor,
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
            prefixIcon: Icon(Icons.cake_outlined, color: _textLight), suffixText: 'years',
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (value) {
            if (value == null || value.isEmpty) return 'Please enter age';
            final age = int.tryParse(value);
            if (age == null || age < 0 || age > 120) return 'Please enter valid age';
            return null;
          },
          onChanged: (value) {
            setState(() { roomPassengers[roomIndex][passengerIndex]['Age'] = int.tryParse(value) ?? 0; });
            _validatePassengerForm(roomIndex, passengerIndex);
          },
        ),
        SizedBox(height: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Passenger Type', style: TextStyle(color: _textSecondary, fontWeight: FontWeight.w500, fontSize: 14)),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(4), decoration: BoxDecoration(color: _backgroundColor, borderRadius: BorderRadius.circular(12)),
              child: Row(children: _paxTypes.asMap().entries.map((entry) {
                final typeIndex = entry.key + 1;
                final typeName = entry.value;
                final isSelected = roomPassengers[roomIndex][passengerIndex]['PaxType'] == typeIndex;
                return Expanded(child: GestureDetector(
                  onTap: () {
                    setState(() { roomPassengers[roomIndex][passengerIndex]['PaxType'] = typeIndex; });
                    _validatePassengerForm(roomIndex, passengerIndex);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                    decoration: BoxDecoration(
                      color: isSelected ? _secondaryColor : Colors.transparent, borderRadius: BorderRadius.circular(8)),
                    child: Text(typeName, textAlign: TextAlign.center, style: TextStyle(
                      color: isSelected ? Colors.white : _textPrimary, fontWeight: FontWeight.w500, fontSize: 12)),
                  ),
                ));
              }).toList()),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDocumentsSection(int roomIndex, int passengerIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Additional Documents', style: TextStyle(color: _textSecondary, fontWeight: FontWeight.w500, fontSize: 14)),
        SizedBox(height: 8),
        if (_validationInfo.panMandatory) TextFormField(
          decoration: InputDecoration(
                        labelStyle: TextStyle(fontSize: 13),

            labelText: 'PAN Number', filled: true, fillColor: _backgroundColor,
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
            setState(() { roomPassengers[roomIndex][passengerIndex]['PAN'] = value; });
            _validatePassengerForm(roomIndex, passengerIndex);
          },
        ),
        if (_validationInfo.panMandatory) SizedBox(height: 12),
        if (_validationInfo.passportMandatory) TextFormField(
          decoration: InputDecoration(
            labelText: 'Passport Number', filled: true, fillColor: _backgroundColor,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            prefixIcon: Icon(Icons.airplane_ticket_rounded, color: _textLight),
          ),
          validator: (value) {
            if (_validationInfo.passportMandatory && (value == null || value.isEmpty)) return 'Passport number is mandatory';
            return null;
          },
          onChanged: (value) {
            setState(() { roomPassengers[roomIndex][passengerIndex]['Passport'] = value; });
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
                Text('This passenger will receive all booking communications', 
                    style: TextStyle(color: _textSecondary, fontSize: 11)),
              ],
            ),
          ),
          Switch(
            value: roomPassengers[roomIndex][passengerIndex]['LeadPassenger'],
            onChanged: (value) {
              setState(() {
                // If setting this passenger as lead, remove lead from other passengers in same room
                if (value) {
                  for (int i = 0; i < roomPassengers[roomIndex].length; i++) {
                    roomPassengers[roomIndex][i]['LeadPassenger'] = (i == passengerIndex);
                  }
                } else {
                  roomPassengers[roomIndex][passengerIndex]['LeadPassenger'] = false;
                  // Ensure at least one lead passenger in the room
                  if (!roomPassengers[roomIndex].any((p) => p['LeadPassenger'])) {
                    roomPassengers[roomIndex][0]['LeadPassenger'] = true;
                  }
                }
              });
            },
            activeColor: _secondaryColor,
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
          // Validation Summary
          // Container(
          //   padding: EdgeInsets.all(16),
          //   decoration: BoxDecoration(
          //     color: isFormValid ? _successColor.withOpacity(0.1) : _warningColor.withOpacity(0.1),
          //     borderRadius: BorderRadius.circular(12),
          //     border: Border.all(color: isFormValid ? _successColor.withOpacity(0.3) : _warningColor.withOpacity(0.3)),
          //   ),
          //   child: Row(
          //     children: [
          //       Icon(
          //         isFormValid ? Icons.check_circle_rounded : Icons.info_outline_rounded,
          //         color: isFormValid ? _successColor : _warningColor,
          //         size: 20,
          //       ),
          //       SizedBox(width: 12),
          //       Expanded(
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Text(
          //               isFormValid ? 'All rooms are complete!' : 'Validation Summary',
          //               style: TextStyle(
          //                 fontWeight: FontWeight.w600,
          //                 color: isFormValid ? _successColor : _warningColor,
          //                 fontSize: 14,
          //               ),
          //             ),
          //             SizedBox(height: 4),
          //             Text(
          //               '$totalPassengers passenger${totalPassengers > 1 ? 's' : ''} across $totalRooms room${totalRooms > 1 ? 's' : ''}',
          //               style: TextStyle(
          //                 color: _textSecondary,
          //                 fontSize: 12,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // SizedBox(height: 16),

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

  void _addPassengerToRoom(int roomIndex) {
    setState(() {
      final newPassengerIndex = roomPassengers[roomIndex].length;
      roomPassengers[roomIndex].add({
        "Title": 'Mr.',
        "FirstName": '',
        "LastName": '',
        "Email": '',
        "Phone": '',
        "PaxType": 1,
        "LeadPassenger": false, // New passengers are not lead by default
        "Age": 0,
        "PAN": '',
        "Passport": '',
      });
      _roomValidations[roomIndex] ??= {};
      _roomValidations[roomIndex]![newPassengerIndex] = false;
    });
  }

  void _removePassengerFromRoom(int roomIndex, int passengerIndex) {
    if (roomPassengers[roomIndex].length > 1) {
      setState(() {
        final wasLead = roomPassengers[roomIndex][passengerIndex]['LeadPassenger'];
        roomPassengers[roomIndex].removeAt(passengerIndex);
        
        // Reindex validations
        final newValidations = <int, bool>{};
        for (int i = 0; i < roomPassengers[roomIndex].length; i++) {
          newValidations[i] = _roomValidations[roomIndex]![i >= passengerIndex ? i + 1 : i] ?? false;
        }
        _roomValidations[roomIndex]!.clear();
        _roomValidations[roomIndex]!.addAll(newValidations);
        
        // If we removed the lead passenger, make the first passenger the lead
        if (wasLead && roomPassengers[roomIndex].isNotEmpty) {
          roomPassengers[roomIndex][0]['LeadPassenger'] = true;
        }
      });
    }
  }

  void _submitForm() {
    if (!_allPassengersValid) {
      _showValidationError('Please complete all passenger details in all rooms before proceeding');
      return;
    }

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

    // Validate passenger uniqueness if required
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
          _errorMessage = 'Passenger names must be unique across all rooms';
        });
        _showValidationError('Passenger names must be unique across all rooms');
        return;
      }
    }

    // Validate PAN requirements
    if (_validationInfo.panCountRequired > 0) {
      final panCount = roomPassengers.fold(0, (count, room) => 
        count + room.where((p) => (p['PAN'] as String).isNotEmpty).length);
      if (panCount < _validationInfo.panCountRequired) {
        setState(() {
          _isSubmitting = false;
          _errorMessage = 'PAN details required for ${_validationInfo.panCountRequired} passenger(s)';
        });
        _showValidationError('PAN details required for ${_validationInfo.panCountRequired} passenger(s)');
        return;
      }
    }

    // Flatten the room-wise structure for the booking preview
    final allPassengers = roomPassengers.expand((room) => room).toList();

    // All validations passed, navigate to preview
    Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => HotelBookingConfirmationPage(
        room: widget.room,
        hotelSearchRequest: widget.hotelSearchRequest,
        hotel: widget.hotel,
        passengers: allPassengers,
        roomPassengers: roomPassengers,
        tableId: 'hotel_${DateTime.now().millisecondsSinceEpoch}',
        bookingId: widget.room.bookingCode,
        preBookResponse: widget.preBookResponse, // Pass PreBook response
      ),
    ),
  ).then((_) {
      setState(() {
        _isSubmitting = false;
      });
    });
  }
}