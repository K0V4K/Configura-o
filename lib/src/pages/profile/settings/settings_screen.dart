import 'package:flutter/material.dart';
import 'delete_account_page.dart';
import 'edit_profile_page.dart';
import 'history_log.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(221, 255, 255, 255),
      appBar: AppBar(
        title: const Text('CONFIG'),
        backgroundColor: const Color.fromARGB(221, 255, 255, 255),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF0056A0),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            padding: const EdgeInsets.all(24),
            child: Row(
              children: const [
                Icon(Icons.shield, size: 48, color: Colors.white),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'PRESENCE +',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Icon(Icons.add, color: Colors.white, size: 28),
              ],
            ),
          ),
          const SizedBox(height: 24),
          ListTile(
            leading: const Icon(Icons.history, color: Colors.black),
            title: const Text('Histórico', style: TextStyle(color: Colors.black)),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LogHistoryPage()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.delete, color: Colors.black),
            title: const Text('Excluir', style: TextStyle(color: Colors.black)),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DeleteAccountPage()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit, color: Colors.black),
            title: const Text('Editar', style: TextStyle(color: Colors.black)),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditProfilePage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
