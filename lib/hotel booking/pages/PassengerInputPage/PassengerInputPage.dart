import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minna/comman/const/const.dart';

class PassengerInputPage extends StatefulWidget {
  const PassengerInputPage({super.key});

  @override
  _PassengerInputPageState createState() => _PassengerInputPageState();
}

class _PassengerInputPageState extends State<PassengerInputPage> {
  final _formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> passengers = [
    {
      "Title": 'Mr.',
      "FirstName": '',
      "MiddleName": '',
      "LastName": '',
      "Email": '',
      "Phone": '',
      "PaxType": 1,
      "LeadPassenger": true,
      "Age": 0,
    },
  ];

  final List<String> _titles = ['Mr.', 'Mrs.', 'Ms.', 'Dr.', 'Prof.'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Passenger Details',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(color: maincolor1),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeaderCard(),
              SizedBox(height: 20),
              ..._buildPassengerForms(),
              _buildAddPassengerButton(),
              SizedBox(height: 30),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildPassengerForms() {
    return List.generate(passengers.length, (index) {
      return Column(
        children: [
          if (index > 0) _buildPassengerHeader(index + 1),
          _buildTitleDropdown(index),
          SizedBox(height: 12),
          _buildNameFields(index),
          SizedBox(height: 12),
          _buildEmailField(index),
          SizedBox(height: 12),
          _buildPhoneField(index),
          SizedBox(height: 12),
          _buildAgeField(index),
          SizedBox(height: 12),
          _buildPaxTypeToggle(index),
          SizedBox(height: 12),
          if (index == 0) _buildLeadPassengerSwitch(index),
          if (index > 0) _buildRemovePassengerButton(index),
          Divider(height: 40, color: Colors.grey[300]),
        ],
      );
    });
  }

  Widget _buildPassengerHeader(int passengerNumber) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Text(
            'Passenger $passengerNumber',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: maincolor1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(Icons.group, size: 40, color: maincolor1),
            SizedBox(height: 10),
            Text(
              'Passenger Information',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: maincolor1,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Please provide details for all travelers',
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleDropdown(int index) {
    return DropdownButtonFormField<String>(
      initialValue: passengers[index]['Title'],
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
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          passengers[index]['Title'] = newValue!;
        });
      },
    );
  }

  Widget _buildNameFields(int index) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'First Name',
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
              prefixIcon: Icon(Icons.person_outline, color: Colors.grey[600]),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter first name';
              }
              return null;
            },
            onChanged: (value) => passengers[index]['FirstName'] = value,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 2,
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Middle',
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
            ),
            onChanged: (value) => passengers[index]['MiddleName'] = value,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 3,
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Last Name',
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
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter last name';
              }
              return null;
            },
            onChanged: (value) => passengers[index]['LastName'] = value,
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField(int index) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Email',
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
        prefixIcon: Icon(Icons.email_outlined, color: Colors.grey[600]),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
      onChanged: (value) => passengers[index]['Email'] = value,
    );
  }

  Widget _buildPhoneField(int index) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Phone Number',
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
        prefixIcon: Icon(Icons.phone_outlined, color: Colors.grey[600]),
      ),
      keyboardType: TextInputType.phone,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter phone number';
        }
        if (value.length < 8) {
          return 'Enter valid phone number';
        }
        return null;
      },
      onChanged: (value) => passengers[index]['Phone'] = value,
    );
  }

  Widget _buildAgeField(int index) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Age',
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
        prefixIcon: Icon(Icons.cake_outlined, color: Colors.grey[600]),
        suffixText: 'years',
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter age';
        }
        if (int.tryParse(value) == null) {
          return 'Please enter a valid number';
        }
        return null;
      },
      onChanged: (value) => passengers[index]['Age'] = int.tryParse(value) ?? 0,
    );
  }

  Widget _buildPaxTypeToggle(int index) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey[300]!),
      ),
      color: Colors.grey[50],
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Passenger Type',
              style: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: passengers[index]['PaxType'] == 1
                            ? maincolor1
                            : Colors.grey[50],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                          side: BorderSide(color: Colors.grey[300]!),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {
                        setState(() {
                          passengers[index]['PaxType'] = 1;
                        });
                      },
                      child: Text(
                        'Adult',
                        style: TextStyle(
                          color: passengers[index]['PaxType'] == 1
                              ? Colors.white
                              : Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: passengers[index]['PaxType'] == 2
                            ? maincolor1
                            : Colors.grey[50],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                          side: BorderSide(color: Colors.grey[300]!),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {
                        setState(() {
                          passengers[index]['PaxType'] = 2;
                        });
                      },
                      child: Text(
                        'Child',
                        style: TextStyle(
                          color: passengers[index]['PaxType'] == 2
                              ? Colors.white
                              : Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: passengers[index]['PaxType'] == 3
                            ? maincolor1
                            : Colors.grey[50],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                          side: BorderSide(color: Colors.grey[300]!),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {
                        setState(() {
                          passengers[index]['PaxType'] = 3;
                        });
                      },
                      child: Text(
                        'Infant',
                        style: TextStyle(
                          color: passengers[index]['PaxType'] == 3
                              ? Colors.white
                              : Colors.grey[600],
                        ),
                      ),
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

  Widget _buildLeadPassengerSwitch(int index) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey[300]!),
      ),
      color: Colors.grey[50],
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(Icons.star_outline, color: Colors.amber[700]),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Is this the lead passenger?',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Switch(
              value: passengers[index]['LeadPassenger'],
              onChanged: (value) {
                setState(() {
                  passengers[index]['LeadPassenger'] = value;
                });
              },
              activeThumbColor: maincolor1,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddPassengerButton() {
    return OutlinedButton.icon(
      onPressed: () {
        setState(() {
          passengers.add({
            "Title": 'Mr.',
            "FirstName": '',
            "MiddleName": '',
            "LastName": '',
            "Email": '',
            "Phone": '',
            "PaxType": 1,
            "LeadPassenger": false,
            "Age": 0,
          });
        });
      },
      icon: Icon(Icons.add, size: 20, color: maincolor1),
      label: Text('Add Another Passenger', style: TextStyle(color: maincolor1)),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: maincolor1!),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }

  Widget _buildRemovePassengerButton(int index) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton.icon(
        onPressed: () {
          setState(() {
            passengers.removeAt(index);
          });
        },
        icon: Icon(Icons.delete_outline, size: 18, color: Colors.red),
        label: Text('Remove', style: TextStyle(color: Colors.red)),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Passenger details saved successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          print(passengers);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: maincolor1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 2,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14),
        child: Text(
          'Confirm Booking',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
