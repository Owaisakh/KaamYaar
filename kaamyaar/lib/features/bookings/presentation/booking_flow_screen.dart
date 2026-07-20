import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:intl/intl.dart';
import '../domain/service_model.dart';
import '../data/booking_repository.dart';
import '../../../core/supabase/auth_provider.dart';

class BookingFlowScreen extends ConsumerStatefulWidget {
  final ServiceModel service;

  const BookingFlowScreen({super.key, required this.service});

  @override
  ConsumerState<BookingFlowScreen> createState() => _BookingFlowScreenState();
}

class _BookingFlowScreenState extends ConsumerState<BookingFlowScreen> {
  int _currentStep = 0;
  bool _isLoading = false;

  // Step 1: Issue
  final _issueController = TextEditingController();
  File? _selectedPhoto;

  // Step 2: Location
  final _addressController = TextEditingController();
  final _labelController = TextEditingController(text: 'Home');

  // Step 3: Schedule
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void dispose() {
    _issueController.dispose();
    _addressController.dispose();
    _labelController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedPhoto = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitBooking() async {
    setState(() => _isLoading = true);

    try {
      final user = ref.read(authNotifierProvider).value;
      if (user == null) throw Exception('User not authenticated');

      final repo = ref.read(bookingRepositoryProvider);

      // Save Address (Mocking coordinates for MVP)
      final address = await repo.saveAddress(
        userId: user.id,
        label: _labelController.text.isNotEmpty ? _labelController.text : 'Location',
        address: _addressController.text,
        latitude: 24.8607,
        longitude: 67.0011,
      );

      // Combine Date and Time
      final scheduleDateTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );

      // Create Booking
      await repo.createBooking(
        customerId: user.id,
        serviceId: widget.service.id,
        addressId: address.id,
        problemDescription: _issueController.text,
        scheduledTime: scheduleDateTime,
        photo: _selectedPhoto,
      );

      if (mounted) {
        setState(() => _isLoading = false);
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text('Booking Confirmed!'),
            content: const Text('Your booking has been received and is pending assignment.'),
            actions: [
              TextButton(
                onPressed: () {
                  context.pop(); // Close dialog
                  context.go('/'); // Go to home
                },
                child: const Text('Back to Home'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to book: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Book ${widget.service.name}'),
      ),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep == 0 && _issueController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please describe the issue')),
            );
            return;
          }
          if (_currentStep == 1 && _addressController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please provide an address')),
            );
            return;
          }
          if (_currentStep == 2 && (_selectedDate == null || _selectedTime == null)) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please select date and time')),
            );
            return;
          }

          if (_currentStep < 3) {
            setState(() => _currentStep++);
          } else {
            _submitBooking();
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() => _currentStep--);
          } else {
            context.pop();
          }
        },
        controlsBuilder: (context, details) {
          final isLastStep = _currentStep == 3;
          return Padding(
            padding: const EdgeInsets.only(top: 32.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : details.onStepContinue,
                    child: _isLoading 
                        ? const SizedBox(
                            height: 20, width: 20, 
                            child: CircularProgressIndicator(strokeWidth: 2)
                          )
                        : Text(isLastStep ? 'Confirm & Book' : 'Next'),
                  ),
                ),
                if (_currentStep > 0) ...[
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _isLoading ? null : details.onStepCancel,
                      child: const Text('Back'),
                    ),
                  ),
                ]
              ],
            ),
          );
        },
        steps: [
          Step(
            title: const Text('Issue'),
            isActive: _currentStep >= 0,
            state: _currentStep > 0 ? StepState.complete : StepState.indexed,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Describe the problem',
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _issueController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: 'E.g., The tap is leaking from the base...',
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Attach a photo (Optional)',
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: theme.colorScheme.outlineVariant,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: _selectedPhoto != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(_selectedPhoto!, fit: BoxFit.cover),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(LucideIcons.camera, color: theme.colorScheme.primary),
                              const SizedBox(height: 8),
                              Text('Tap to add photo', style: TextStyle(color: theme.colorScheme.primary)),
                            ],
                          ),
                  ),
                ),
              ],
            ),
          ),
          Step(
            title: const Text('Location'),
            isActive: _currentStep >= 1,
            state: _currentStep > 1 ? StepState.complete : StepState.indexed,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _labelController,
                  decoration: const InputDecoration(
                    labelText: 'Save as (e.g., Home, Office)',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _addressController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Full Address',
                    hintText: 'Enter your complete address',
                    alignLabelWithHint: true,
                  ),
                ),
              ],
            ),
          ),
          Step(
            title: const Text('Schedule'),
            isActive: _currentStep >= 2,
            state: _currentStep > 2 ? StepState.complete : StepState.indexed,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(LucideIcons.calendar, color: theme.colorScheme.primary),
                  title: Text(_selectedDate == null ? 'Select Date' : DateFormat('EEE, MMM d, yyyy').format(_selectedDate!)),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 30)),
                    );
                    if (date != null) setState(() => _selectedDate = date);
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(LucideIcons.clock, color: theme.colorScheme.primary),
                  title: Text(_selectedTime == null ? 'Select Time' : _selectedTime!.format(context)),
                  onTap: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (time != null) setState(() => _selectedTime = time);
                  },
                ),
              ],
            ),
          ),
          Step(
            title: const Text('Confirm'),
            isActive: _currentStep >= 3,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSummaryRow('Service', widget.service.name),
                _buildSummaryRow('Base Price', 'Rs. ${widget.service.basePrice.toStringAsFixed(0)}'),
                const Divider(height: 32),
                _buildSummaryRow('Issue', _issueController.text),
                const SizedBox(height: 8),
                _buildSummaryRow('Location', _addressController.text),
                const SizedBox(height: 8),
                if (_selectedDate != null && _selectedTime != null)
                  _buildSummaryRow(
                    'Schedule',
                    '${DateFormat('MMM d, yyyy').format(_selectedDate!)} at ${_selectedTime!.format(context)}',
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
