import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' show join;
import 'package:flutter/material.dart';

class AddCustomerStep1Screen extends StatelessWidget {
  const AddCustomerStep1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    InputDecoration inputDecoration(String label) {
      return InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: Colors.white,
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[800],
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.white), // Back icon color
        title: const Text(
          'Add New Customer',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // Notifications screen
            },
          ),
        ],
      ),

      body: Column(
        children: [
          const StepIndicator(currentStep: 1),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  const Text(
                    'Personal information',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TextField(decoration: inputDecoration('Customer Name')),
                  const SizedBox(height: 12),
                  TextField(decoration: inputDecoration('Business Name')),
                  const SizedBox(height: 12),
                  TextField(decoration: inputDecoration('Location')),
                  const SizedBox(height: 12),
                  TextField(decoration: inputDecoration('Email')),
                  const SizedBox(height: 12),
                  TextField(decoration: inputDecoration('Phone Number')),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AddCustomerStep2Screen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[800],
                          ),
                          child: const Text(
                            'Save',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddCustomerStep2Screen extends StatefulWidget {
  const AddCustomerStep2Screen({super.key});

  @override
  State<AddCustomerStep2Screen> createState() => _AddCustomerStep2ScreenState();
}

class _AddCustomerStep2ScreenState extends State<AddCustomerStep2Screen> {
  String? selectedSize;
  final List<String> sizes = ['0-5', '5-15', '15-20', '20-25', '25+'];

  @override
  Widget build(BuildContext context) {
    InputDecoration inputDecoration(String label) {
      return InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: Colors.white,
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[800],
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.white), // Back icon color
        title: const Text(
          'Add New Customer',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // Notifications screen
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const StepIndicator(currentStep: 2),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  const Text(
                    'Business size',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: selectedSize,
                    decoration: inputDecoration('Select size'),
                    items: sizes
                        .map(
                          (size) =>
                              DropdownMenuItem(value: size, child: Text(size)),
                        )
                        .toList(),
                    onChanged: (value) => setState(() => selectedSize = value),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Contact Details',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  TextField(decoration: inputDecoration('Phone Number')),
                  const SizedBox(height: 12),
                  TextField(decoration: inputDecoration('Email')),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const VerificationInfoScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[800],
                          ),
                          child: const Text(
                            'Save',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VerificationInfoScreen extends StatefulWidget {
  const VerificationInfoScreen({super.key});

  @override
  State<VerificationInfoScreen> createState() => _VerificationInfoScreenState();
}

class _VerificationInfoScreenState extends State<VerificationInfoScreen> {
  final TextEditingController bvnController = TextEditingController();
  DateTime? selectedDate;

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime(1990),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    InputDecoration inputDecoration(String label) => InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[800],
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.white), // Back icon color
        title: const Text(
          'Add New Customer',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // Notifications screen
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const StepIndicator(currentStep: 3),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  const Text(
                    'Verification',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: bvnController,
                    decoration: inputDecoration('Bank Verification Number'),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: _pickDate,
                    child: AbsorbPointer(
                      child: TextField(
                        decoration: inputDecoration('Birth date').copyWith(
                          suffixIcon: const Icon(Icons.calendar_today),
                          hintText: selectedDate == null
                              ? 'Select birth date'
                              : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[800],
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const IdentityVerificationIntroScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IdentityVerificationIntroScreen extends StatelessWidget {
  const IdentityVerificationIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[800],
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.white), // Back icon color
        title: const Text(
          'Add New Customer',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // Notifications screen
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const StepIndicator(currentStep: 3),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.lock_outline, size: 48, color: Colors.black54),
                  SizedBox(height: 24),
                  Text(
                    'Verify your identity',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 12),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Please provide a valid government-issued ID for verification',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[800],
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SelectDocumentTypeScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Continue',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SelectDocumentTypeScreen extends StatelessWidget {
  const SelectDocumentTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
Widget buildOption(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: OutlinedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const DocumentCaptureScreen()),
        );
      },
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        side: const BorderSide(color: Colors.black12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    ),
  );
}


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[800],
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.white), // Back icon color
        title: const Text(
          'Add New Customer',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // Notifications screen
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const StepIndicator(currentStep: 3),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Verify your verification document',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Column(
                      children: [
                        buildOption('Passport'),
                        buildOption('ID card'),
                        buildOption('Driving license'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[800],
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const DocumentCaptureScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Continue',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DocumentCaptureScreen extends StatefulWidget {
  const DocumentCaptureScreen({super.key});

  @override
  State<DocumentCaptureScreen> createState() => _DocumentCaptureScreenState();
}

class _DocumentCaptureScreenState extends State<DocumentCaptureScreen> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isCameraReady = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    if (_cameras!.isNotEmpty) {
      _controller = CameraController(_cameras![0], ResolutionPreset.medium);
      await _controller!.initialize();
      if (mounted) {
        setState(() => _isCameraReady = true);
      }
    }
  }

  Future<void> _captureImage() async {
    if (!_controller!.value.isInitialized) return;

    final dir = await getTemporaryDirectory();
    final path = join(dir.path, '${DateTime.now().millisecondsSinceEpoch}.jpg');
    await _controller!.takePicture().then((file) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ImagePreviewScreen(imagePath: file.path),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isCameraReady
          ? Stack(
              children: [
                CameraPreview(_controller!),
                const Center(
                  child: AspectRatio(
                    aspectRatio: 4 / 3,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.fromBorderSide(
                          BorderSide(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 32,
                  left: 16,
                  right: 16,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[800],
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: _captureImage,
                    child: const Text(
                      'Capture',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

class ImagePreviewScreen extends StatelessWidget {
  final String imagePath;
  const ImagePreviewScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[800],
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.white), // Back icon color
        title: const Text(
          'Add New Customer',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // Notifications screen
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: Image.file(File(imagePath))),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red[800]),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const TakeSelfieIntroPage(),
                  ),
                );
              },
              child: const Text(
                'Continue',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TakeSelfieIntroPage extends StatelessWidget {
  const TakeSelfieIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red[800],
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.white), // Back icon color
        title: const Text(
          'Add New Customer',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // Notifications screen
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const LinearProgressIndicator(
            value: 0.66,
            color: Colors.green,
            backgroundColor: Colors.grey,
          ),
          const SizedBox(height: 40),
          const Icon(Icons.face_retouching_natural, size: 60),
          const SizedBox(height: 20),
          const Text(
            'Take a Selfie',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'We need a clear photo of your face for verification',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB11116),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TakeSelfieCameraPage(),
                    ),
                  );
                },
                child: const Text('Continue', style: TextStyle(fontSize: 18)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TakeSelfieCameraPage extends StatefulWidget {
  const TakeSelfieCameraPage({super.key});

  @override
  State<TakeSelfieCameraPage> createState() => _TakeSelfieCameraPageState();
}

class _TakeSelfieCameraPageState extends State<TakeSelfieCameraPage> {
  CameraController? _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final status = await Permission.camera.request();
    if (!status.isGranted) return;

    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
      (c) => c.lensDirection == CameraLensDirection.front,
    );
    _controller = CameraController(frontCamera, ResolutionPreset.high);

    _initializeControllerFuture = _controller!.initialize();
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _captureSelfie() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller!.takePicture();

      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CheckingPhotosPage(imagePath: image.path),
        ),
      );
    } catch (e) {
      debugPrint('Camera error: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to capture photo. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.red[800],
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.white), // Back icon color
        title: const Text(
          'Add New Customer',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // Notifications screen
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          FutureBuilder(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  _controller != null) {
                return CameraPreview(_controller!);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          Center(
            child: Container(
              width: 250,
              height: 330,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
          const Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Position your face within the oval guide',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          Positioned(
            bottom: 24,
            left: 16,
            right: 16,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB11116),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: _captureSelfie,
              child: const Text('Continue', style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}

class CheckingPhotosPage extends StatefulWidget {
  final String imagePath;
  const CheckingPhotosPage({super.key, required this.imagePath});

  @override
  State<CheckingPhotosPage> createState() => _CheckingPhotosPageState();
}

class _CheckingPhotosPageState extends State<CheckingPhotosPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const VerificationSuccessPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          const LinearProgressIndicator(
            value: 0.85,
            color: Colors.green,
            backgroundColor: Colors.grey,
          ),
          const Spacer(),
          ClipOval(
            child: Image.file(
              File(widget.imagePath),
              width: 160,
              height: 160,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          const CircularProgressIndicator(color: Colors.green, strokeWidth: 5),
          const SizedBox(height: 20),
          const Text(
            "Checking your photos",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            "This may take a few seconds",
            style: TextStyle(fontSize: 16),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: const Color(0xFFB11116),
      title: const Text('Add New Customer'),
      leading: const BackButton(color: Colors.white),
      actions: const [
        Padding(
          padding: EdgeInsets.all(12),
          child: Icon(Icons.notifications_none, color: Colors.white),
        ),
      ],
    );
  }
}

class VerificationSuccessPage extends StatelessWidget {
  const VerificationSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          const LinearProgressIndicator(
            value: 1.0,
            color: Colors.green,
            backgroundColor: Colors.grey,
          ),
          const Spacer(),
          const Icon(Icons.check_circle, color: Colors.green, size: 100),
          const SizedBox(height: 20),
          const Text(
            "Verification successful",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            "Your identity has been successfully verified.\nThank you for completing this step.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB11116),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text("Done", style: TextStyle(fontSize: 18)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: const Color(0xFFB11116),
      title: const Text('Add New Customer'),
      leading: const BackButton(color: Colors.white),
      actions: const [
        Padding(
          padding: EdgeInsets.all(12),
          child: Icon(Icons.notifications_none, color: Colors.white),
        ),
      ],
    );
  }
}

class StepIndicator extends StatelessWidget {
  final int currentStep;
  const StepIndicator({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    Color circleColor(int step) {
      return step <= currentStep ? Colors.green : Colors.grey;
    }

    return Container(
      color: Colors.red[800],
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (i) {
          final step = i + 1;
          return Row(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: circleColor(step),
                child: Text(
                  '$step',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
              if (i < 2)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: Colors.white,
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}
