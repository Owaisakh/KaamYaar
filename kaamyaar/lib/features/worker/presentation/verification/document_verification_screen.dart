import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/kaamyaar_card.dart';
import '../../../../core/widgets/kaamyaar_badge.dart';

class DocumentVerificationScreen extends StatelessWidget {
  const DocumentVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Document Verification'),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          KaamYaarCard(
            backgroundColor: const Color(0xFFECFDF5),
            borderColor: const Color(0xFFA7F3D0),
            child: Row(
              children: const [
                Icon(Icons.verified_user_rounded, color: AppColors.success, size: 36),
                SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Verification Under Review', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 2),
                      Text('Our team reviews documents within 2 hours.', style: TextStyle(color: AppColors.textSecondaryLight, fontSize: 13)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          _buildDocRow('CNIC Front Photo', 'Uploaded', KaamYaarBadgeType.success),
          _buildDocRow('CNIC Back Photo', 'Uploaded', KaamYaarBadgeType.success),
          _buildDocRow('Selfie with CNIC', 'Uploaded', KaamYaarBadgeType.success),
          _buildDocRow('Skill Certificate', 'Pending Review', KaamYaarBadgeType.warning),
        ],
      ),
    );
  }

  Widget _buildDocRow(String title, String status, KaamYaarBadgeType type) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: KaamYaarCard(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            KaamYaarBadge(label: status, type: type),
          ],
        ),
      ),
    );
  }
}
