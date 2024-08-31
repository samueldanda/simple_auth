import 'package:flutter/material.dart';

class DeviceUnsafeApp extends StatelessWidget {
  const DeviceUnsafeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon to indicate unsafe device
                Icon(
                  Icons.error_outline,
                  size: 64.0,
                  color: Theme.of(context).colorScheme.error,
                ),
                const SizedBox(height: 20.0),
                // Message informing the user
                Text(
                  'Device Unsafe',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
                const SizedBox(height: 20.0),
                // Description of why the device is considered unsafe
                const Text(
                  'This app cannot run on rooted or emulated devices, or with developer options enabled.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 20.0),
                // Additional instructions or guidance
                const Text(
                  'Please use a physical device without root access and ensure developer options are disabled to use this app.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
