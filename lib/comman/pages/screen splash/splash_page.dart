import 'dart:async';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:minna/comman/pages/main%20home/home.dart';
import 'package:video_player/video_player.dart';

class GradientSplashScreen extends StatefulWidget {
  const GradientSplashScreen({super.key});

  @override
  State<GradientSplashScreen> createState() => _GradientSplashScreenState();
}

class _GradientSplashScreenState extends State<GradientSplashScreen> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializePlayer();

    // Navigate after 5 seconds
    Timer(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      }
    });
  }

  Future<void> _initializePlayer() async {
    try {
      dev.log('Initializing video player for splash (out_last.mov)...');
      // Renamed file to avoid space issues in URIs
      _controller = VideoPlayerController.asset('asset/out_last.mov');
      
      await _controller.initialize();
      
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
        await _controller.play();
        await _controller.setLooping(true);
        await _controller.setVolume(0.0);
        dev.log('Video player initialized and playing.');
      }
    } catch (e) {
      dev.log('Error initializing video player: $e');
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: Center(
          child: _isInitialized
              ? FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    child: VideoPlayer(_controller),
                  ),
                )
              : _errorMessage != null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, color: Colors.amber, size: 48),
                        const SizedBox(height: 16),
                        const Text(
                          'Video Load Error',
                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            'ExoPlayer Source Error: .mov format is often unsupported on Android. Please convert asset/out_last.mov to .mp4 for better compatibility.',
                            style: TextStyle(color: Colors.white70, fontSize: 13),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
