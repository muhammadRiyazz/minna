import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minna/DTH%20&%20Mobile/DTH/pages/dth%20packageslist/dth_rechargelist.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/DTH%20&%20Mobile/mobile%20%20recharge/application/oparator/operators_bloc.dart';
import 'package:shimmer/shimmer.dart';

class DTHInputPage extends StatefulWidget {
  const DTHInputPage({super.key});

  @override
  State<DTHInputPage> createState() => _DTHInputPageState();
}

class _DTHInputPageState extends State<DTHInputPage> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController consumerIdController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? selectedOperator;

  // Standardized theme colors
  // Standardized theme colors

  @override
  void initState() {
    super.initState();
    context.read<OperatorsBloc>().add(const OperatorsEvent.getDTHop());
  }

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
            decoration: BoxDecoration(color: maincolor1),
            child: Stack(
              children: [
                Positioned(
                  top: -40,
                  right: -40,
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.02),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -20,
                  left: -20,
                  child: Icon(
                    Iconsax.monitor_mobbile,
                    size: 160,
                    color: Colors.white.withOpacity(0.03),
                  ),
                ),

                // Moved background text here if it should stay in the background
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 60,
                        ), // Space for fixed back button
                        Text(
                          'Entertainment\nRefilled',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                            height: 1.1,
                            letterSpacing: -1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 2. Main Form Card
          SingleChildScrollView(
            child: Column(
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
                                Iconsax.personalcard,
                                color: maincolor1,
                                size: 22,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Account Details',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: maincolor1,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Subscriber ID Input
                          Text(
                            'SUBSCRIBER ID / VC NUMBER',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: textSecondary,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: consumerIdController,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: textPrimary,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return 'Required';
                              if (value.length < 8) return 'Enter valid ID';
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Iconsax.scan_barcode,
                                color: maincolor1.withOpacity(0.5),
                                size: 20,
                              ),
                              hintText: 'e.g. 0123456789',
                              hintStyle: TextStyle(
                                color: textLight,
                                fontWeight: FontWeight.w400,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.all(20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: borderSoft),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: borderSoft),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: secondaryColor,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Phone Number Input
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
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            maxLength: 10,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: textPrimary,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return 'Required';
                              if (value.length != 10)
                                return '10 digits required';
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Iconsax.mobile,
                                color: maincolor1.withOpacity(0.5),
                                size: 20,
                              ),
                              counterText: '',
                              hintText: '0000 000 000',
                              hintStyle: TextStyle(
                                color: textLight,
                                fontWeight: FontWeight.w400,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.all(20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: borderSoft),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: borderSoft),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: secondaryColor,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 32),

                          // Operator Selection
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'SELECT PROVIDER',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  color: textSecondary,
                                  letterSpacing: 1,
                                ),
                              ),
                              if (selectedOperator != null)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: secondaryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    selectedOperator!,
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w900,
                                      color: secondaryColor,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          BlocBuilder<OperatorsBloc, OperatorsState>(
                            builder: (context, state) {
                              if (state.isLoading) return buildShimmerLoading();
                              if (state.opDTHList == null ||
                                  state.opDTHList!.isEmpty) {
                                return Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(30),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: borderSoft),
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Iconsax.info_circle,
                                        color: textLight,
                                        size: 40,
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        "No DTH providers found",
                                        style: TextStyle(
                                          color: textSecondary,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 2.5,
                                      crossAxisSpacing: 12,
                                      mainAxisSpacing: 12,
                                    ),
                                itemCount: state.opDTHList!.length,
                                itemBuilder: (context, index) {
                                  final opName = state.opDTHList![index];
                                  final isSelected = selectedOperator == opName;
                                  return GestureDetector(
                                    onTap: () => setState(
                                      () => selectedOperator = opName,
                                    ),
                                    child: AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 200,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.white.withOpacity(0.7),
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: isSelected
                                              ? maincolor1
                                              : borderSoft,
                                          width: 1,
                                        ),
                                        // boxShadow: isSelected
                                        //     ? [
                                        //         BoxShadow(
                                        //           color: secondaryColor
                                        //               .withOpacity(0.15),
                                        //           blurRadius: 10,
                                        //           offset: const Offset(0, 4),
                                        //         ),
                                        //       ]
                                        //     : [],
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                      ),
                                      child: Row(
                                        children: [
                                          // Container(
                                          //   padding: const EdgeInsets.all(6),
                                          //   decoration: BoxDecoration(
                                          //     color: isSelected
                                          //         ? secondaryColor.withOpacity(
                                          //             0.1,
                                          //           )
                                          //         : backgroundColor,
                                          //     shape: BoxShape.circle,
                                          //   ),
                                          //   child: Icon(
                                          //     Iconsax.routing,
                                          //     color: isSelected
                                          //         ? secondaryColor
                                          //         : textLight,
                                          //     size: 20,
                                          //   ),
                                          // ),
                                          // const SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              opName,
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: isSelected
                                                    ? FontWeight.w900
                                                    : FontWeight.w700,
                                                color: isSelected
                                                    ? maincolor1
                                                    : textSecondary,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),

                          const SizedBox(height: 48),

                          // Action Button
                          SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if (selectedOperator == null) {
                                    _showSelectOperatorSnackbar(context);
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => DTHRechargePlansPage(
                                          phoneNo: phoneController.text,
                                          subcriberNo:
                                              consumerIdController.text,
                                          operator: selectedOperator!,
                                        ),
                                      ),
                                    );
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: secondaryColor,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 8,
                                shadowColor: secondaryColor.withOpacity(0.4),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'PROCEED',
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
            ),
          ),

          // 3. Fixed Header Controls
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
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
                    'DTH RECHARGE',
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
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

  void _showSelectOperatorSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Iconsax.danger, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Please select a DTH provider',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: errorColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.all(20),
      ),
    );
  }
}

Widget buildShimmerLoading() {
  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 2.2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
    ),
    itemCount: 4,
    itemBuilder: (context, index) => Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),
  );
}
