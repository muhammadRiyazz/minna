import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:minna/Electyicity%20&%20Water/application/fetch%20bill/fetch_bill_bloc.dart';
import 'package:minna/Electyicity%20&%20Water/application/providers/providers_bloc.dart';
import 'package:minna/Electyicity%20&%20Water/kseb/bill%20info/bill_details.dart';
import 'package:minna/comman/const/const.dart';

class ElectricityBillInputPage extends StatefulWidget {
  const ElectricityBillInputPage({super.key});

  @override
  State<ElectricityBillInputPage> createState() =>
      _ElectricityBillInputPageState();
}

class _ElectricityBillInputPageState extends State<ElectricityBillInputPage> {
  final TextEditingController customerIdController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  BillerModel? selectedProvider;

  @override
  void initState() {
    super.initState();
    context.read<ProvidersBloc>().add(GeElectryCirtProviders());
  }

  OutlineInputBorder customBorder(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(6),
    borderSide: BorderSide(color: color, width: 1.2),
  );

  TextStyle fieldTextStyle = const TextStyle(fontSize: 14);
  TextStyle labelStyle = const TextStyle(fontSize: 13, color: Colors.black87);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: maincolor1,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Electricity Bill',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
      body: BlocBuilder<ProvidersBloc, ProvidersState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 12,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.blue.shade50,
                              child: Icon(
                                Icons.lightbulb_outline,
                                color: maincolor1,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              "Electricity",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        /// Provider Dropdown
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: DropdownSearch<BillerModel>(
                            items: state.electricityList ?? [],
                            selectedItem: selectedProvider,
                            onChanged: (value) {
                              setState(() => selectedProvider = value);
                            },
                            itemAsString: (BillerModel? item) =>
                                item?.name ?? '', // 👈 This shows provider name
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelText: "Select Electricity Provider",
                                labelStyle: labelStyle,
                                prefixIcon: Icon(
                                  Icons.electrical_services_outlined,
                                  color: maincolor1,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: customBorder(Colors.grey),
                                enabledBorder: customBorder(
                                  Colors.grey.shade400,
                                ),
                                focusedBorder: customBorder(maincolor1!),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 12,
                                ),
                                isDense: true,
                              ),
                            ),
                            popupProps: PopupProps.menu(
                              showSearchBox: true,
                              searchFieldProps: TextFieldProps(
                                decoration: InputDecoration(
                                  hintText: 'Search provider...',
                                  hintStyle: const TextStyle(fontSize: 14),
                                  prefixIcon: const Icon(Icons.search),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              constraints: const BoxConstraints(maxHeight: 300),
                              emptyBuilder: (context, _) => const Center(
                                child: Text("No providers found"),
                              ),
                            ),
                            validator: (value) => value == null
                                ? 'Please select a provider'
                                : null,
                          ),
                        ),

                        const SizedBox(height: 5),

                        /// Customer ID
                        TextFormField(
                          controller: customerIdController,
                          style: fieldTextStyle,
                          decoration: InputDecoration(
                            labelText: "Customer ID",
                            labelStyle: labelStyle,
                            border: customBorder(Colors.grey),
                            enabledBorder: customBorder(Colors.grey.shade400),
                            focusedBorder: customBorder(maincolor1!),
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                          ),
                          validator: (value) => value == null || value.isEmpty
                              ? 'Please enter Customer ID'
                              : null,
                        ),
                        const SizedBox(height: 14),

                        /// Mobile Number
                        TextFormField(
                          controller: mobileNumberController,
                          keyboardType: TextInputType.phone,
                          style: fieldTextStyle,
                          decoration: InputDecoration(
                            labelText: "Mobile Number",
                            labelStyle: labelStyle,
                            border: customBorder(Colors.grey),
                            enabledBorder: customBorder(Colors.grey.shade400),
                            focusedBorder: customBorder(maincolor1!),
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
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
                  const SizedBox(height: 20),

                  /// Submit Button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: maincolor1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final providerId = selectedProvider?.id ?? '';
                          final phone = mobileNumberController.text.trim();
                          final consumer = customerIdController.text.trim();

                          /// Dispatch event to fetch bill
                          context.read<FetchBillBloc>().add(
                            FetchBillEvent.fetchElectricityBill(

                              providerID: providerId,
                              phoneNo: phone,
                              consumerId: consumer,
                            ),
                          );

                          /// Navigate to Bill Details Page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>  BillDetailsPage(
                                phoneNo: phone,
                                providerID: providerId,
                                consumerId:consumer ,
                                provider: selectedProvider!.name,),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        "Fetch Bill",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
