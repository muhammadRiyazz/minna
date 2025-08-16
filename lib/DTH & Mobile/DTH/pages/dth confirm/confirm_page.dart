import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minna/DTH%20&%20Mobile/DTH/application/dth%20proceed/dth_confirm_bloc.dart';
import 'package:minna/comman/const/const.dart';
import 'package:minna/comman/pages/log%20in/login_page.dart';
import 'package:minna/comman/application/login/login_bloc.dart';

class DTHAmountEntryPage extends StatefulWidget {
  final String phoneNo;
  final String operator;
  final String subcriberNo;

  const DTHAmountEntryPage({
    super.key,
    required this.phoneNo,
    required this.operator,
    required this.subcriberNo,
  });

  @override
  State<DTHAmountEntryPage> createState() => _DTHAmountEntryPageState();
}

class _DTHAmountEntryPageState extends State<DTHAmountEntryPage> {
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Check login status when the page loads
    context.read<LoginBloc>().add(const LoginEvent.loginInfo());
  }

  Future<void> _onProceed() async {
    // First check if amount is valid
    String amount = _amountController.text.trim();
    if (amount.isEmpty ||
        double.tryParse(amount) == null ||
        double.parse(amount) <= 0) {
      _showCustomSnackbar("Please enter a valid amount", isError: true);
      return;
    }

    // Check login status
    final isLoggedIn = context.read<LoginBloc>().state.isLoggedIn ?? false;

    if (!isLoggedIn) {
      // Show login bottom sheet if not logged in
      await _showLoginBottomSheet();

      // After login attempt, check status again
      final newLoginState = context.read<LoginBloc>().state;
      if (newLoginState.isLoggedIn != true) {
        return; // User didn't login, don't proceed
      }
    }
    _onPayNowTap();
    // If logged in, proceed with DTH recharge
    // context.read<DthConfirmBloc>().add(
    //   DthConfirmEvent.proceed(
    //     phoneNo: widget.phoneNo,
    //     operator: widget.operator,
    //     amount: amount,
    //     subcriberNo: widget.subcriberNo,
    //   ),
    // );
  }

  void _onPayNowTap() {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      builder: (ctx) {
        String status = "loading"; // loading, success, failed
        String message = "Waiting for payment status...";

        return StatefulBuilder(
          builder: (context, setStateBottomSheet) {
            // Future.delayed(const Duration(milliseconds: 500), () {
            //   _startRazorpayWithCallbacks(
            //     amount,
            //     name,
            //     phone,
            //     email,
            //     onSuccess: (paymentId) {
            //       setStateBottomSheet(() {
            //         status = "success";
            //         message = "Payment Successful\nID: $paymentId";
            //       });
            //       Future.delayed(const Duration(seconds: 2), () {
            //         Navigator.pop(context);
            //         // _submitBillPayment(paymentId);
            //       });
            //     },
            //     onFailure: () {
            //       setStateBottomSheet(() {
            //         status = "failed";
            //         message = "Payment Failed. Please try again.";
            //       });
            //       Future.delayed(const Duration(seconds: 2), () {
            //         Navigator.pop(context);
            //       });
            //     },
            //   );
            // });

            IconData icon;
            Color iconColor;

            if (status == "success") {
              icon = Icons.check_circle_outline;
              iconColor = maincolor1!;
            } else if (status == "failed") {
              icon = Icons.cancel_outlined;
              iconColor = Colors.red;
            } else {
              icon = Icons.hourglass_empty;
              iconColor = maincolor1!;
            }

            return Container(
              padding: const EdgeInsets.all(24),
              height: 240,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 60, color: iconColor),
                  const SizedBox(height: 20),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: status == 'failed' ? Colors.red : Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 15),
                  status == 'loading'
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: LinearProgressIndicator(
                            color: maincolor1,
                            minHeight: 2,
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _showLoginBottomSheet() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const LoginBottomSheet(login: 1),
    );
  }

  void _showCustomSnackbar(String message, {bool isError = false}) {
    final color = isError ? Colors.redAccent : Colors.green;
    final icon = isError ? Icons.error_outline : Icons.check_circle_outline;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        duration: const Duration(seconds: 3),
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(message, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DthConfirmBloc, DthConfirmState>(
          listener: (context, state) {
            if (!state.isLoading && state.dthrechargeStatus != null) {
              if (state.dthrechargeStatus == "SUCCESS") {
                _showCustomSnackbar("Recharge Successful ✅");
              } else {
                _showCustomSnackbar("Recharge Failed ❌", isError: true);
              }
            }
          },
        ),
        BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            // You can add login state changes handling here if needed
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: maincolor1,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Enter Amount',
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              const Spacer(),
              Column(
                children: [
                  const Text(
                    "Recharge Amount",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Text(
                    "Please enter recharge amount",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          '₹',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 150,
                          child: TextField(
                            controller: _amountController,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            decoration: const InputDecoration(
                              hintText: '0.00',
                              hintStyle: TextStyle(
                                fontSize: 40,
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: context.watch<DthConfirmBloc>().state.isLoading
                        ? null
                        : _onProceed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: context.watch<DthConfirmBloc>().state.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Proceed',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
