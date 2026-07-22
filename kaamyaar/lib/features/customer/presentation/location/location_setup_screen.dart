import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/kaamyaar_button.dart';
import '../../../../core/widgets/kaamyaar_card.dart';

class LocationSetupScreen extends StatefulWidget {
  const LocationSetupScreen({super.key});

  @override
  State<LocationSetupScreen> createState() => _LocationSetupScreenState();
}

class _LocationSetupScreenState extends State<LocationSetupScreen> {
  final _searchController = TextEditingController();
  String _selectedLabel = 'Home';

  final List<Map<String, String>> _savedAddresses = [
    {
      'label': 'Home',
      'address': 'House 123, Street 5, DHA Phase 2, Lahore',
    },
    {
      'label': 'Office',
      'address': 'Plaza 45, Commercial Zone, Gulberg III, Lahore',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Set Your Location'),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Search Input
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.borderLight),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search city, area, or street address...',
                    prefixIcon: Icon(Icons.search_rounded, color: AppColors.textSecondaryLight),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Use Current Location Button
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.my_location_rounded, color: AppColors.customerAccent),
                label: const Text('Use Current GPS Location', style: TextStyle(color: AppColors.customerPrimary, fontWeight: FontWeight.bold)),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  side: const BorderSide(color: AppColors.customerAccent),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ),
              const SizedBox(height: 24),

              const Text('Saved Addresses', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.customerPrimary)),
              const SizedBox(height: 12),

              Expanded(
                child: ListView.builder(
                  itemCount: _savedAddresses.length,
                  itemBuilder: (context, index) {
                    final item = _savedAddresses[index];
                    final isSelected = _selectedLabel == item['label'];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: KaamYaarCard(
                        onTap: () => setState(() => _selectedLabel = item['label']!),
                        borderColor: isSelected ? AppColors.customerAccent : AppColors.borderLight,
                        child: Row(
                          children: [
                            Icon(
                              item['label'] == 'Home' ? Icons.home_rounded : Icons.work_rounded,
                              color: isSelected ? AppColors.customerAccent : AppColors.textSecondaryLight,
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item['label']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                  const SizedBox(height: 2),
                                  Text(item['address']!, style: const TextStyle(color: AppColors.textSecondaryLight, fontSize: 13)),
                                ],
                              ),
                            ),
                            if (isSelected) const Icon(Icons.check_circle_rounded, color: AppColors.customerAccent),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              KaamYaarButton(
                label: 'Confirm Location',
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
