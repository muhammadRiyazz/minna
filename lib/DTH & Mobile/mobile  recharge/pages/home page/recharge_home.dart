import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/DTH & Mobile/mobile  recharge/application/oparator/operators_bloc.dart';
import 'package:minna/DTH & Mobile/mobile  recharge/pages/packageslist/rechargelist.dart';
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

  // Use standardized theme colors from const.dart
  // Use standardized theme colors from const.dart

  Color _getOperatorColor(String operatorName) {
    switch (operatorName.toUpperCase()) {
      case 'AIRTEL':
        return Colors.red;
      case 'JIO':
      case 'RELIANCE JIO':
        return Colors.blue.shade800;
      case 'VI':
      case 'VODAFONE':
      case 'IDEA':
        return Colors.redAccent;
      case 'BSNL':
        return Colors.blue.shade600;
      case 'MTNL':
        return Colors.orange;
      default:
        return secondaryColor;
    }
  }

  String _getOperatorAssetPath(String operatorName) {
    switch (operatorName.toUpperCase()) {
      case 'AIRTEL':
        return 'asset/operators/airtel.jpg';
      case 'JIO':
      case 'RELIANCE JIO':
        return 'asset/operators/jio.png';
      case 'VI':
      case 'VODAFONE':
      case 'IDEA':
        return 'asset/operators/vi.jpeg';
      case 'BSNL':
        return 'asset/operators/bsnl.png';
      case 'MTNL':
        return 'asset/operators/bsnl.png'; // Using BSNL as fallback for MTNL if same
      default:
        return '';
    }
  }

  Widget _buildTextFallback(String opName) {
    return Container(
      color: _getOperatorColor(opName).withOpacity(0.08),
      child: Center(
        child: Text(
          opName.isNotEmpty ? opName[0].toUpperCase() : '?',
          style: TextStyle(
            color: _getOperatorColor(opName),
            fontWeight: FontWeight.w900,
            fontSize: 16, // Refined size
          ),
        ),
      ),
    );
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
            decoration: BoxDecoration(
              color: maincolor1,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
              ),
            ),
            child: Stack(
              children: [
                // Decorative circles
                Positioned(
                  top: -50,
                  right: -50,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.03),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: -30,
                  child: Icon(
                    Iconsax.mobile_programming,
                    size: 150,
                    color: Colors.white.withOpacity(0.04),
                  ),
                ),

                // Header Content
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
                          'Instant\nRecharge',
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

          // 2. Main Content Card
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 210),
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
                          // Input Section Title
                          Row(
                            children: [
                              Icon(
                                Iconsax.device_message,
                                color: maincolor1,
                                size: 22,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Recharge Details',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                  color: maincolor1,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Mobile Number Input
                          Text(
                            'MOBILE NUMBER',
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
                              if (value == null || value.isEmpty) {
                                return 'Required';
                              } else if (value.length != 10) {
                                return 'Enter 10 digits';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Container(
                                padding: const EdgeInsets.only(
                                  left: 16,
                                  right: 12,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Iconsax.mobile_programming,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '+91',
                                      style: TextStyle(
                                        color: textPrimary,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      width: 1,
                                      height: 20,
                                      color: borderSoft,
                                    ),
                                  ],
                                ),
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

                          // Operator Selection Title
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'SELECT OPERATOR',
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
                              if (state.isLoading) {
                                return buildShimmerLoading();
                              } else if (state.opList == null ||
                                  state.opList!.isEmpty) {
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
                                        "Service temporarily unavailable",
                                        style: TextStyle(
                                          color: textSecondary,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 2.2,
                                        crossAxisSpacing: 12,
                                        mainAxisSpacing: 12,
                                      ),
                                  itemCount: state.opList!.length,
                                  itemBuilder: (context, index) {
                                    final opName = state.opList![index];
                                    final isSelected =
                                        selectedOperator == opName;
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
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          border: Border.all(
                                            color: isSelected
                                                ? secondaryColor
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
                                            Container(
                                              width: 36,
                                              height: 36,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: borderSoft.withOpacity(
                                                    0.5,
                                                  ),
                                                ),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child:
                                                    _getOperatorAssetPath(
                                                      opName,
                                                    ).isNotEmpty
                                                    ? Image.asset(
                                                        _getOperatorAssetPath(
                                                          opName,
                                                        ),
                                                        fit: BoxFit.contain,
                                                        errorBuilder: (c, e, s) =>
                                                            _buildTextFallback(
                                                              opName,
                                                            ),
                                                      )
                                                    : _buildTextFallback(
                                                        opName,
                                                      ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Text(
                                                opName == 'Vodafone'
                                                    ? 'VI'
                                                    : opName,
                                                style: TextStyle(
                                                  fontSize: 13,
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
                              }
                            },
                          ),

                          const SizedBox(height: 38),

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
                                        builder: (_) => MobileRechargePlansPage(
                                          operator: selectedOperator.toString(),
                                          mobileNumber: phoneController.text,
                                        ),
                                      ),
                                    );
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: maincolor1,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 0,
                                shadowColor: Colors.transparent,
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'VIEW PLANS',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Icon(Iconsax.arrow_right_3, size: 20),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
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
                    'MOBILE RECHARGE',
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

  void _showSelectOperatorSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Iconsax.danger, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Please select a network provider',
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
        duration: const Duration(seconds: 3),
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
    itemBuilder: (context, index) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );
    },
  );
}
