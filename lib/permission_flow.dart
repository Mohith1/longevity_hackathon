// lib/permission_flow.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'survey_screen.dart';

/// Screen asking for wearable device permission
class PermissionScreen extends StatelessWidget {
  const PermissionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permissions'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: primary),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Enhanced smartwatch icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [primary, primary.withOpacity(0.7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: primary.withOpacity(0.4),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.watch, // smartwatch icon
                  size: 40,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Allow access to your wearable device?\nThis enables us to analyse your Biomarkers.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const WearableTransitionScreen(),
                    ),
                  );
                },
                child: const Text('Allow', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SurveyScreen(),
                    ),
                  );
                },
                child: const Text('Do not allow', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Transition screen after permission granted, showing data capture progress
class WearableTransitionScreen extends StatefulWidget {
  const WearableTransitionScreen({Key? key}) : super(key: key);

  @override
  State<WearableTransitionScreen> createState() => _WearableTransitionScreenState();
}

class _WearableTransitionScreenState extends State<WearableTransitionScreen> {
  @override
  void initState() {
    super.initState();
    // Show notification after 3 seconds and navigate to survey
    Timer(const Duration(seconds: 3), () {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successful saved')), // Notification
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SurveyScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Enhanced smartwatch icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [primary, primary.withOpacity(0.7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: primary.withOpacity(0.4),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.watch, // smartwatch icon
                  size: 40,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Wearable device data being captured...'
                ,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
