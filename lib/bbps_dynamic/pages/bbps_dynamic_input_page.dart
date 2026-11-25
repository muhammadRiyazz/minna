import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:minna/bbps_dynamic/application/bbps_dynamic_bloc.dart';
import 'package:minna/bbps_dynamic/domain/models/bbps_models.dart';
import 'package:minna/bbps_dynamic/pages/bbps_dynamic_bill_details_page.dart';
import 'package:minna/comman/const/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:minna/comman/application/login/login_bloc.dart';
import 'package:minna/comman/pages/log in/login_page.dart';

class BbpsDynamicInputPage extends StatefulWidget {
  final String category;
  final String title;

  const BbpsDynamicInputPage({
    super.key,
    required this.category,
    required this.title,
  });

  @override
  State<BbpsDynamicInputPage> createState() => _BbpsDynamicInputPageState();
}

class _BbpsDynamicInputPageState extends State<BbpsDynamicInputPage> {
  BbpsDynamicBiller? selectedBiller;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController customerMobileController =
      TextEditingController();

  // UI State Cache
  List<BbpsDynamicBiller> _billers = [];
  BbpsDynamicBillerInfo? _billerInfo;

  // To store controllers dynamically
  Map<String, TextEditingController> dynamicControllers = {};

  @override
  void initState() {
    super.initState();
    context.read<BbpsDynamicBloc>().add(
      GetBillersEvent(category: widget.category),
    );
  }

  @override
  void dispose() {
    customerMobileController.dispose();
    for (var controller in dynamicControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  OutlineInputBorder customBorder(Color color, {double width = 1.0}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: color, width: width),
      );

  void _showCustomSnackbar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.check_circle_outline,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: isError ? Colors.redAccent : Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: BlocConsumer<BbpsDynamicBloc, BbpsDynamicState>(
        listener: (context, state) {
          if (state is BbpsDynamicError) {
            _showCustomSnackbar(state.message, isError: true);
          } else if (state is BbpsDynamicBillFetched) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BbpsDynamicBillDetailsPage(
                  billResponse: state.billResponse,
                  category: widget.category,
                ),
              ),
            );
          } else if (state is BbpsDynamicBillerInfoLoaded) {
            _billerInfo = state.billerInfo;
            // Initialize controllers when new inputs are loaded
            dynamicControllers.clear();
            for (var param in state.billerInfo.billerInputParams) {
              dynamicControllers[param.paramName] = TextEditingController();
            }
          } else if (state is BbpsDynamicBillersLoaded) {
            _billers = state.billers;
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              // Header
              Container(
                height: 250,
                width: double.infinity,
                color: maincolor1,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          widget.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Content
              Container(
                margin: const EdgeInsets.only(top: 200),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    padding: const EdgeInsets.all(24),
                    children: [
                      const Text(
                        'SELECT PROVIDER',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: textSecondary,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 10),
                      DropdownSearch<BbpsDynamicBiller>(
                        items: _billers,
                        selectedItem: selectedBiller,
                        onChanged: (value) {
                          setState(() {
                            selectedBiller = value;
                            _billerInfo =
                                null; // Reset inputs when provider changes
                          });
                          if (value != null) {
                            context.read<BbpsDynamicBloc>().add(
                              GetBillerInfoEvent(
                                category: widget.category,
                                billerId: value.billerId,
                                billerName: value.billerName,
                              ),
                            );
                          }
                        },
                        itemAsString: (BbpsDynamicBiller? item) =>
                            item?.billerName ?? '',
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            hintText: "Search Provider...",
                            prefixIcon: Icon(
                              Iconsax.building_3,
                              color: maincolor1.withOpacity(0.5),
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
                        popupProps: const PopupProps.menu(showSearchBox: true),
                      ),
                      const SizedBox(height: 24),

                      // Dynamic Fields
                      if (_billerInfo != null) ...[
                        Builder(
                          builder: (context) {
                            bool hasDynamicMobile = _billerInfo!
                                .billerInputParams
                                .any(
                                  (p) =>
                                      p.paramName.toLowerCase().contains(
                                        'mobile',
                                      ) ||
                                      p.paramName.toLowerCase().contains(
                                        'phone',
                                      ),
                                );

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (!hasDynamicMobile)
                                  // Customer Mobile Number Field (Required for all BBPS APIs)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 24),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'CUSTOMER MOBILE NUMBER',
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w800,
                                            color: textSecondary,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        TextFormField(
                                          controller: customerMobileController,
                                          keyboardType: TextInputType.phone,
                                          maxLength: 10,
                                          decoration: InputDecoration(
                                            counterText: "",
                                            hintText:
                                                "Enter Customer Mobile Number",
                                            filled: true,
                                            fillColor: Colors.white,
                                            border: customBorder(borderSoft),
                                            enabledBorder: customBorder(
                                              borderSoft,
                                            ),
                                            focusedBorder: customBorder(
                                              secondaryColor,
                                              width: 2,
                                            ),
                                            contentPadding:
                                                const EdgeInsets.all(20),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Mobile Number is required';
                                            }
                                            if (value.length != 10) {
                                              return 'Enter a valid 10-digit mobile number';
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),

                                ..._billerInfo!.billerInputParams.map((param) {
                                  bool isDate = param.paramName.toLowerCase().contains('date') || param.paramName.toLowerCase() == 'dob';
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 24),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          param.paramName.toUpperCase(),
                                          style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w800,
                                            color: textSecondary,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        TextFormField(
                                          readOnly: isDate,
                                          onTap: isDate ? () async {
                                            DateTime? picked = await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1900),
                                              lastDate: DateTime.now(),
                                            );
                                            if (picked != null) {
                                              dynamicControllers[param.paramName]?.text = DateFormat('dd-MM-yyyy').format(picked);
                                            }
                                          } : null,
                                          controller:
                                              dynamicControllers[param
                                                  .paramName],
                                          keyboardType:
                                              param.dataType == 'NUMERIC'
                                              ? TextInputType.number
                                              : TextInputType.text,
                                          textCapitalization:
                                              TextCapitalization.characters,
                                          decoration: InputDecoration(
                                            hintText:
                                                "Enter ${param.paramName}",
                                            filled: true,
                                            fillColor: Colors.white,
                                            border: customBorder(borderSoft),
                                            enabledBorder: customBorder(
                                              borderSoft,
                                            ),
                                            focusedBorder: customBorder(
                                              secondaryColor,
                                              width: 2,
                                            ),
                                            contentPadding:
                                                const EdgeInsets.all(20),
                                          ),
                                          validator: (value) {
                                            if (!param.isOptional &&
                                                (value == null ||
                                                    value.isEmpty)) {
                                              return 'Required';
                                            }
                                            if (value != null &&
                                                value.isNotEmpty) {
                                              if (param.minLength > 0 && value.length < param.minLength) {
                                                return 'Min length is ${param.minLength}';
                                              }
                                              if (param.maxLength > 0 && value.length > param.maxLength) {
                                                return 'Max length is ${param.maxLength}';
                                              }
                                              if (param.regex != null &&
                                                  param.regex!.isNotEmpty) {
                                                if (!RegExp(
                                                  param.regex!,
                                                ).hasMatch(value)) {
                                                  return 'Invalid format';
                                                }
                                              }
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ],
                            );
                          },
                        ),
                      ],
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
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate() &&
                                selectedBiller != null) {
                              final isLoggedIn = context.read<LoginBloc>().state.isLoggedIn ?? false;
                              if (!isLoggedIn) {
                                _showCustomSnackbar('Please log in to continue', isError: true);
                                await showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) => const LoginBottomSheet(login: 1),
                                );
                                if (context.read<LoginBloc>().state.isLoggedIn != true) {
                                  return;
                                }
                              }

                              final prefs = await SharedPreferences.getInstance();
                              final userPhone = prefs.getString('phoneNo') ?? '';

                              // Extract dynamic params
                              Map<String, String> params = {};
                              dynamicControllers.forEach((key, controller) {
                                params[key] = controller.text.trim();
                              });

                              String finalNumber = userPhone;
                              if (finalNumber.isEmpty) {
                                finalNumber = customerMobileController.text.trim();
                              }

                              context.read<BbpsDynamicBloc>().add(
                                FetchBillEvent(
                                  category: widget.category,
                                  billerId: selectedBiller!.billerId,
                                  number: finalNumber,
                                  dynamicParams: params,
                                ),
                              );
                            }
                          },
                          child: state is BbpsDynamicLoading
                              ? const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : const Text(
                                  'FETCH BILL',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16,
                                  ),
                                ),
                        ),
                      ),

                      if (state is BbpsDynamicLoading && selectedBiller == null)
                        const Center(child: CircularProgressIndicator()),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
