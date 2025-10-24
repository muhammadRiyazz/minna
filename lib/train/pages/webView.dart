import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class IrctcInAppWebView extends StatefulWidget {
  const IrctcInAppWebView({super.key});

  @override
  State<IrctcInAppWebView> createState() => _IrctcInAppWebViewState();
}

class _IrctcInAppWebViewState extends State<IrctcInAppWebView> {
  late InAppWebViewController _controller;
  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("IRCTC Booking")),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest:
                URLRequest(url: WebUri("https://www.irctc.co.in/nget/train-search")),
            initialSettings: InAppWebViewSettings(
              javaScriptEnabled: true,
              clearCache: true,
            ),
            onWebViewCreated: (controller) => _controller = controller,
            onLoadStart: (controller, url) {
              setState(() => _loading = true);
            },
            onLoadStop: (controller, url) {
              setState(() => _loading = false);
            },
          ),
          if (_loading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
