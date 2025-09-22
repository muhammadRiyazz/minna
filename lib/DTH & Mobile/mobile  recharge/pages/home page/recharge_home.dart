import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/DTH%20&%20Mobile/mobile%20%20recharge/application/oparator/operators_bloc.dart';
import 'package:minna/DTH%20&%20Mobile/mobile%20%20recharge/pages/add%20amount/add_amount.dart';
import 'package:shimmer/shimmer.dart';

class MobileRechargeInputPage extends StatefulWidget {
  const MobileRechargeInputPage({super.key});

  @override
  State<MobileRechargeInputPage> createState() =>
      _MobileRechargeInputPageState();
}

class _MobileRechargeInputPageState extends State<MobileRechargeInputPage> {
  final TextEditingController phoneController = TextEditingController();
  String? selectedOperator;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: maincolor1,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white, size: 16),
        title: const Text(
          'Mobile Recharge',
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Enter Your Mobile Number',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter mobile number';
                          } else if (value.length != 10) {
                            return 'Mobile number must be 10 digits';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixText: '+91 ',
                          counterText: '',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Select Operator',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      BlocBuilder<OperatorsBloc, OperatorsState>(
                        builder: (context, state) {
                          if (state.isLoading) {
                            return buildShimmerLoading();
                          } else if (state.opList == []) {
                            return const Center(
                              child: Text("No operators available"),
                            );
                          } else {
                            return Column(
                              children: state.opList!.map((opName) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4.0,
                                  ),
                                  child: InkWell(
                                    onTap: () => setState(
                                      () => selectedOperator = opName,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: selectedOperator == opName
                                            ? Colors.blue.shade50
                                            : Colors.white,
                                        border: Border.all(
                                          color: selectedOperator == opName
                                              ? Colors.blue.shade100
                                              : Colors.grey.shade300,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: const EdgeInsets.all(12),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              opName == 'Vodafone'
                                                  ? 'VI'
                                                  : opName,
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          Radio<String>(
                                            value: opName,
                                            groupValue: selectedOperator,
                                            onChanged: (val) => setState(
                                              () => selectedOperator = val,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (selectedOperator == null) {
                      _showSelectOperatorSnackbar(context);
                    } else {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (_) => MobileRechargePlansPage(
                      //       mobileNumber: phoneController.text,
                      //       operator: selectedOperator!,
                      //     ),
                      //   ),
                      // );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AmountEntryPage(
                            operator: selectedOperator.toString(),
                            phoneNo: phoneController.text,
                          ),
                        ),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: maincolor1,
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSelectOperatorSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Please select an operator',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red[400],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}

Widget buildShimmerLoading() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Column(
      children: List.generate(
        4,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: Row(
            children: [
              // Operator icon placeholder

              // Text content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main title
                    Container(
                      width: double.infinity,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Subtitle
                    Container(
                      width: 120,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),

              const SizedBox(width: 15),

              // Radio button placeholder
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade300),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
