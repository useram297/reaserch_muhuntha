import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:math';
import 'dart:io' show Platform;

class SoundRecorderPage extends StatefulWidget {
  @override
  _SoundRecorderPageState createState() => _SoundRecorderPageState();
}

class _SoundRecorderPageState extends State<SoundRecorderPage>
    with SingleTickerProviderStateMixin {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool _isRecording = false;
  double _currentVolume = 0.0;

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _initializeRecorder();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat();
  }

  Future<void> _initializeRecorder() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'Microphone permission not granted';
    }

    await _recorder.openRecorder();
    _recorder.setSubscriptionDuration(const Duration(milliseconds: 50));
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _startRecording() async {
    setState(() => _isRecording = true);

    try {
      Codec codec = Platform.isAndroid ? Codec.aacMP4 : Codec.aacADTS;

      await _recorder.startRecorder(
        toFile: 'audio.aac', // Use a supported format
        codec: codec,
      );

      _recorder.onProgress!.listen((event) {
        setState(() {
          _currentVolume = event.decibels?.clamp(0.0, 50.0) ?? 0.0;
          print(_currentVolume);
        });
      });
    } catch (e) {
      print('Recording failed: $e');
      setState(() => _isRecording = false);
    }
  }

  Future<void> _stopRecording() async {
    await _recorder.stopRecorder();
    setState(() {
      _isRecording = false;
      _currentVolume = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sound Recorder with Animation'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomPaint(
              painter: SoundWavePainter(_animationController, _currentVolume),
              child: const SizedBox(
                height: 200,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isRecording ? _stopRecording : _startRecording,
              child: Text(_isRecording ? 'Stop Recording' : 'Start Recording'),
            ),
          ],
        ),
      ),
    );
  }
}

class SoundWavePainter extends CustomPainter {
  final AnimationController animation;
  final double volume;

  SoundWavePainter(this.animation, this.volume) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blueAccent
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final centerY = size.height / 2;
    final waveHeight = volume;

    final path = Path();
    for (double x = 0; x <= size.width; x++) {
      double y = centerY +
          sin((x / size.width * 2 * pi) + animation.value * 2 * pi) *
              waveHeight;
      if (x == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
