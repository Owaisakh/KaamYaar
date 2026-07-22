import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/kaamyaar_button.dart';

class WorkerSkillSelectionScreen extends StatefulWidget {
  const WorkerSkillSelectionScreen({super.key});

  @override
  State<WorkerSkillSelectionScreen> createState() => _WorkerSkillSelectionScreenState();
}

class _WorkerSkillSelectionScreenState extends State<WorkerSkillSelectionScreen> {
  final List<String> _selectedSkills = ['Plumbing'];

  final List<Map<String, dynamic>> _allSkills = [
    {'name': 'Plumbing', 'icon': Icons.plumbing_rounded},
    {'name': 'Electrical', 'icon': Icons.electrical_services_rounded},
    {'name': 'AC Repair', 'icon': Icons.ac_unit_rounded},
    {'name': 'Cleaning', 'icon': Icons.cleaning_services_rounded},
    {'name': 'Carpentry', 'icon': Icons.handyman_rounded},
    {'name': 'Painting', 'icon': Icons.format_paint_rounded},
    {'name': 'Mechanic', 'icon': Icons.build_rounded},
    {'name': 'Appliance Repair', 'icon': Icons.kitchen_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Select Skills'),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Select Your Expertise', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.workerSecondary)),
              const SizedBox(height: 8),
              const Text('Choose the services you are qualified to perform for customers.', style: TextStyle(color: AppColors.textSecondaryLight)),
              const SizedBox(height: 24),

              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.3,
                  ),
                  itemCount: _allSkills.length,
                  itemBuilder: (context, index) {
                    final skill = _allSkills[index];
                    final name = skill['name'] as String;
                    final isSelected = _selectedSkills.contains(name);

                    return InkWell(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            _selectedSkills.remove(name);
                          } else {
                            _selectedSkills.add(name);
                          }
                        });
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.workerPrimary.withValues(alpha: 0.12) : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected ? AppColors.workerPrimary : AppColors.borderLight,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(skill['icon'] as IconData, color: isSelected ? AppColors.workerPrimary : AppColors.textSecondaryLight, size: 32),
                            const SizedBox(height: 10),
                            Text(name, style: TextStyle(fontWeight: FontWeight.bold, color: isSelected ? AppColors.workerPrimary : AppColors.textPrimaryLight)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              KaamYaarButton(
                label: 'Save & Submit Verification',
                type: KaamYaarButtonType.secondary,
                onPressed: () => Navigator.of(context).pushNamed('/worker/verification'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
