import 'package:iconsax/iconsax.dart';
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

  // Use standardized theme colors from const.dart


  @override
  void initState() {
    super.initState();
    context.read<ProvidersBloc>().add(GeElectryCirtProviders());
  }

  OutlineInputBorder customBorder(Color color, {double width = 1.0}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: color, width: width),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          // 1. Immersive Header Background
          Container(
            height: 250,
            width: double.infinity,
            color: maincolor1,
            child: Stack(
              children: [
                Positioned(
                  top: -60,
                  right: -60,
                  child: Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.02),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -10,
                  left: -20,
                  child: Icon(
                    Iconsax.flash_1,
                    size: 140,
                    color: Colors.white.withOpacity(0.04),
                  ),
                ),

                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 60), // Space for fixed back button
                        Text(
                          'Pay Your\nPower Bills',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            height: 1.1,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 2. Main Form Content
          SingleChildScrollView(
            child: BlocBuilder<ProvidersBloc, ProvidersState>(
              builder: (context, state) {
                return Column(
                  children: [
                    const SizedBox(height: 215),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 32, 24, 40),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Iconsax.flash_circle,
                                    color: maincolor1,
                                    size: 22,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    'Bill Details',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                      color: maincolor1,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),

                              // Provider Selection
                              Text(
                                'SERVICE PROVIDER',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  color: textSecondary,
                                  letterSpacing: 1,
                                ),
                              ),
                              const SizedBox(height: 10),
                              DropdownSearch<BillerModel>(
                                items: state.electricityList ?? [],
                                selectedItem: selectedProvider,
                                onChanged: (value) =>
                                    setState(() => selectedProvider = value),
                                itemAsString: (BillerModel? item) =>
                                    item?.name ?? '',
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    hintText: "Select Electricity Provider",
                                    hintStyle: TextStyle(
                                      color: textLight,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    prefixIcon: Icon(
                                      Iconsax.building_3,
                                      color: maincolor1.withOpacity(0.5),
                                      size: 20,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.all(20),
                                    border: customBorder(borderSoft),
                                    enabledBorder: customBorder(borderSoft),
                                    focusedBorder: customBorder(
                                      secondaryColor,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                popupProps: PopupProps.menu(
                                  showSearchBox: true,
                                  searchFieldProps: TextFieldProps(
                                    decoration: InputDecoration(
                                      hintText: 'Search provider...',
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: textLight,
                                      ),
                                      prefixIcon: const Icon(
                                        Iconsax.search_normal,
                                        size: 18,
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 12,
                                          ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: borderSoft,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: secondaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  constraints: const BoxConstraints(
                                    maxHeight: 400,
                                  ),
                                  emptyBuilder: (context, _) => Center(
                                    child: Text(
                                      "No providers found",
                                      style: TextStyle(color: textSecondary),
                                    ),
                                  ),
                                  itemBuilder: (context, item, isSelected) =>
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 14,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? secondaryColor.withOpacity(0.1)
                                              : Colors.transparent,
                                          border: Border(
                                            bottom: BorderSide(
                                              color: borderSoft.withOpacity(
                                                0.5,
                                              ),
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          item.name,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: isSelected
                                                ? maincolor1
                                                : textSecondary,
                                            fontWeight: isSelected
                                                ? FontWeight.w900
                                                : FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                ),
                                validator: (value) => value == null
                                    ? 'Please select a provider'
                                    : null,
                              ),

                              const SizedBox(height: 24),

                              // Customer ID Input
                              Text(
                                'CONSUMER ID / NUMBER',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  color: textSecondary,
                                  letterSpacing: 1,
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: customerIdController,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: textPrimary,
                                ),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Iconsax.user_tag,
                                    color: maincolor1.withOpacity(0.5),
                                    size: 20,
                                  ),
                                  hintText: "Enter consumer ID",
                                  hintStyle: TextStyle(
                                    color: textLight,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: customBorder(borderSoft),
                                  enabledBorder: customBorder(borderSoft),
                                  focusedBorder: customBorder(
                                    secondaryColor,
                                    width: 2,
                                  ),
                                  contentPadding: const EdgeInsets.all(20),
                                ),
                                validator: (value) =>
                                    value == null || value.isEmpty
                                    ? 'Required'
                                    : null,
                              ),

                              const SizedBox(height: 24),

                              // Mobile Number Input
                              Text(
                                'REGISTERED MOBILE',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  color: textSecondary,
                                  letterSpacing: 1,
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: mobileNumberController,
                                keyboardType: TextInputType.phone,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: textPrimary,
                                ),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Iconsax.mobile,
                                    color: maincolor1.withOpacity(0.5),
                                    size: 20,
                                  ),
                                  hintText: "0000 000 000",
                                  hintStyle: TextStyle(
                                    color: textLight,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: customBorder(borderSoft),
                                  enabledBorder: customBorder(borderSoft),
                                  focusedBorder: customBorder(
                                    secondaryColor,
                                    width: 2,
                                  ),
                                  contentPadding: const EdgeInsets.all(20),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty)
                                    return 'Required';
                                  if (!RegExp(r'^\d{10}$').hasMatch(value))
                                    return 'Invalid mobile';
                                  return null;
                                },
                              ),

                              const SizedBox(height: 48),

                              // Fetch Bill Button
                              SizedBox(
                                width: double.infinity,
                                height: 60,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: maincolor1,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    elevation: 0,
                                    shadowColor: Colors.transparent,
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      final providerId =
                                          selectedProvider?.id ?? '';
                                      final phone = mobileNumberController.text
                                          .trim();
                                      final consumer = customerIdController.text
                                          .trim();
                                      final providerName =
                                          selectedProvider?.name ?? '';

                                      context.read<FetchBillBloc>().add(
                                        FetchBillEvent.fetchElectricityBill(
                                          providerName: providerName,
                                          providerID: providerId,
                                          phoneNo: phone,
                                          consumerId: consumer,
                                        ),
                                      );

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => BillDetailsPage(
                                            phoneNo: phone,
                                            providerID: providerId,
                                            consumerId: consumer,
                                            provider: providerName,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "FETCH BILL",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                      Icon(Iconsax.arrow_right_3, size: 20),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          // 3. Fixed Header Controls
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                      child: const Icon(
                        Iconsax.arrow_left_2,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  Text(
                    'ELECTRICITY BILL',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
