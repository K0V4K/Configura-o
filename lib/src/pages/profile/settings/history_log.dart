import 'package:flutter/material.dart';

class LogHistoryPage extends StatelessWidget {
  const LogHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulação de logs de detecção
    final List<Map<String, String>> logs = [
      {"data": "2025-05-01", "hora": "14:32", "evento": "Movimento detectado na sala"},
      {"data": "2025-05-01", "hora": "13:10", "evento": "Movimento detectado no corredor"},
      {"data": "2025-04-30", "hora": "22:45", "evento": "Movimento detectado na entrada"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Histórico de Detecções')),
      body: logs.isEmpty
          ? const Center(child: Text('Nenhum registro de movimento encontrado.'))
          : ListView.builder(
              itemCount: logs.length,
              itemBuilder: (context, index) {
                final log = logs[index];
                return ListTile(
                  leading: const Icon(Icons.motion_photos_on, color: Colors.blue),
                  title: Text(log['evento']!),
                  subtitle: Text('${log['data']} às ${log['hora']}'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                  
                  },
                );
              },
            ),
    );
  }
}
