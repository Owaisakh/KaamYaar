import 'package:flutter/material.dart';

class WorkerProfileScreen extends StatelessWidget {
  const WorkerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Worker Verification')),
      body: const Center(
        child: Text('Worker Profile Form Here'),
      ),
    );
  }
}
