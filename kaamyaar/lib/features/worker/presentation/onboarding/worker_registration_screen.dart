import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/kaamyaar_button.dart';

class WorkerRegistrationScreen extends StatefulWidget {
  const WorkerRegistrationScreen({super.key});

  @override
  State<WorkerRegistrationScreen> createState() => _WorkerRegistrationScreenState();
}

class _WorkerRegistrationScreenState extends State<WorkerRegistrationScreen> {
  final _nameController = TextEditingController();
  final _cnicController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Worker Registration'),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Become a KaamYaar Partner', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.workerSecondary)),
              const SizedBox(height: 8),
              const Text('Fill in your details to start offering services and earning daily.', style: TextStyle(color: AppColors.textSecondaryLight)),
              const SizedBox(height: 24),

              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Full Name', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _cnicController,
                decoration: const InputDecoration(labelText: 'CNIC Number (e.g. 35202-1234567-1)', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
              const Spacer(),

              KaamYaarButton(
                label: 'Continue to Skills',
                type: KaamYaarButtonType.secondary,
                onPressed: () => Navigator.of(context).pushNamed('/worker/skills'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
