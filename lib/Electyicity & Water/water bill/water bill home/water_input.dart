import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minna/Electyicity%20&%20Water/application/fetch%20bill/fetch_bill_bloc.dart';
import 'package:minna/Electyicity%20&%20Water/application/providers/providers_bloc.dart';
import 'package:minna/Electyicity%20&%20Water/water%20bill/water%20bill%20info%20/bill%20confirm%20page.dart';

class WaterBillInputPage extends StatefulWidget {
  const WaterBillInputPage({super.key});

  @override
  State<WaterBillInputPage> createState() => _WaterBillInputPageState();
}

class _WaterBillInputPageState extends State<WaterBillInputPage> {
  final TextEditingController customerIdController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  BillerModel? selectedProvider;

  // New color scheme
  final Color _primaryColor = Colors.black;
  final Color _secondaryColor = Color(0xFFD4AF37); // Gold
  final Color _accentColor = Color(0xFFC19B3C); // Darker Gold
  final Color _backgroundColor = Color(0xFFF8F9FA);
  final Color _cardColor = Colors.white;
  final Color _textPrimary = Colors.black;
  final Color _textSecondary = Color(0xFF666666);
  final Color _textLight = Color(0xFF999999);
  final Color _errorColor = Color(0xFFE53935);

  @override
  void initState() {
    super.initState();
    context.read<ProvidersBloc>().add(getWaterProviders());
  }

  OutlineInputBorder customBorder(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: color, width: 1.5),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _primaryColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'Water Bill Payment',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<ProvidersBloc, ProvidersState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                
                   Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: _primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [  Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: _secondaryColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                            border: Border.all(color: _secondaryColor.withOpacity(0.3)),
                          ),
                          child: Icon(
                            Icons.water_drop_outlined,
                            color: _secondaryColor,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: 12,),
                      Text(
                        'Water Bill Payment',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '           Pay your water bill instantly',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
                  const SizedBox(height: 15),
                  
                  // Input Card
                  Container(margin: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: _cardColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        // Provider Selection
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: _secondaryColor.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.business_outlined,
                                color: _secondaryColor,
                                size: 15,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Water Provider',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _primaryColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        
                        DropdownSearch<BillerModel>(
                          items: state.waterList ?? [],
                          selectedItem: selectedProvider,
                          onChanged: (value) {
                            setState(() => selectedProvider = value);
                          },
                          itemAsString: (BillerModel? item) => item?.name ?? '',
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              labelText: "Select Water Provider",
                              labelStyle: TextStyle(
                                fontSize: 13,
                                color: _textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                              hintText: "Choose your water provider",
                              hintStyle: TextStyle(color: _textLight),
                              prefixIcon: Icon(
                                Icons.search,
                                color: _textLight,
                              ),
                              filled: true,
                              fillColor: _backgroundColor,
                              border: customBorder(Colors.grey.shade300),
                              enabledBorder: customBorder(Colors.grey.shade300),
                              focusedBorder: customBorder(_secondaryColor),
                           
                            ),
                          ),
                          popupProps: PopupProps.menu(
                            showSearchBox: true,
                            searchFieldProps: TextFieldProps(
                              decoration: InputDecoration(
                                hintText: 'Search water provider...',
                                hintStyle: TextStyle(fontSize: 14, color: _textLight),
                                prefixIcon: Icon(Icons.search, color: _textLight),
                                // contentPadding: const EdgeInsets.symmetric(
                                //   horizontal: 16,
                                //   vertical: 12,
                                // ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.grey.shade300),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: _secondaryColor),
                                ),
                              ),
                            ),
                            // constraints: const BoxConstraints(maxHeight: 300),
                            emptyBuilder: (context, _) => Container(
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                "No water providers found",
                                style: TextStyle(
                                  color: _textSecondary,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            itemBuilder: (context, item, isSelected) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected ? _secondaryColor.withOpacity(0.1) : Colors.transparent,
                                border: Border(
                                  bottom: BorderSide(color: Colors.grey.shade200),
                                ),
                              ),
                              child: Text(
                                item.name,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: _textPrimary,
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                          validator: (value) => value == null
                              ? 'Please select a water provider'
                              : null,
                        ),

                        const SizedBox(height: 24),

                        // Customer ID
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: _secondaryColor.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.badge_outlined,
                                color: _secondaryColor,
                                size: 12,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Customer ID',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _primaryColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        
                        TextFormField(
                          controller: customerIdController,
                          style: TextStyle(
                            fontSize: 16,
                            color: _textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            hintText: "Enter your customer ID",
                            hintStyle: TextStyle(color: _textLight,fontSize: 12),
                            filled: true,
                            fillColor: _backgroundColor,
                            border: customBorder(Colors.grey.shade300),
                            enabledBorder: customBorder(Colors.grey.shade300),
                            focusedBorder: customBorder(_secondaryColor),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            prefixIcon: Icon(
                              Icons.credit_card_outlined,
                              color: _textLight,
                            ),
                          ),
                          validator: (value) => value == null || value.isEmpty
                              ? 'Please enter Customer ID'
                              : null,
                        ),

                        const SizedBox(height: 24),

                        // Mobile Number
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: _secondaryColor.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.phone_iphone_outlined,
                                color: _secondaryColor,
                                size: 12,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Mobile Number',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _primaryColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        
                        TextFormField(
                          controller: mobileNumberController,
                          keyboardType: TextInputType.phone,
                          style: TextStyle(
                            fontSize: 16,
                            color: _textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            hintText: "Enter 10-digit mobile number",
                            hintStyle: TextStyle(color: _textLight,fontSize: 12),
                            filled: true,
                            fillColor: _backgroundColor,
                            border: customBorder(Colors.grey.shade300),
                            enabledBorder: customBorder(Colors.grey.shade300),
                            focusedBorder: customBorder(_secondaryColor),
                            // contentPadding: const EdgeInsets.symmetric(
                            //   horizontal: 16,
                            //   vertical: 16,
                            // ),
                            prefixIcon: Icon(
                              Icons.phone_outlined,
                              color: _textLight,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter mobile number';
                            }
                            if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                              return 'Enter valid 10-digit number';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Fetch Bill Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                          shadowColor: _primaryColor.withOpacity(0.3),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final providerId = selectedProvider?.id ?? '';
                            final phone = mobileNumberController.text.trim();
                            final consumer = customerIdController.text.trim();
                            final providerName = selectedProvider?.name ?? '';
                    
                            // Dispatch event to fetch bill
                            context.read<FetchBillBloc>().add(
                              FetchBillEvent.fetchWaterBill(
                                providerName: providerName,
                                providerID: providerId,
                                phoneNo: phone,
                                consumerId: consumer,
                              ),
                            );
                    
                            // Navigate to Bill Details Page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => WaterBillDetailsPage(
                                  phoneNo: phone,
                                  providerID: providerId,
                                  consumerId: consumer,
                                  provider: providerName,
                                ),
                              ),
                            );
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Fetch Bill Details",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward_rounded,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}