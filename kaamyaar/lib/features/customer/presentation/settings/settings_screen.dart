import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/kaamyaar_card.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotifications = true;
  bool _biometricLogin = false;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('App Settings'),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          KaamYaarCard(
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Push Notifications', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: const Text('Receive booking updates & promo alerts'),
                  value: _pushNotifications,
                  activeColor: AppColors.customerAccent,
                  onChanged: (val) => setState(() => _pushNotifications = val),
                ),
                const Divider(),
                SwitchListTile(
                  title: const Text('Biometric Security', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: const Text('Enable FaceID / Fingerprint login'),
                  value: _biometricLogin,
                  activeColor: AppColors.customerAccent,
                  onChanged: (val) => setState(() => _biometricLogin = val),
                ),
                const Divider(),
                ListTile(
                  title: const Text('App Language', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(_selectedLanguage),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                  onTap: () {
                    setState(() {
                      _selectedLanguage = _selectedLanguage == 'English' ? 'Urdu (اردو)' : 'English';
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
