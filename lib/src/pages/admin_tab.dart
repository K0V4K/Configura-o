import 'package:flutter/material.dart';

class AdminTabScreen extends StatefulWidget {
  const AdminTabScreen({super.key});

  @override
  State<AdminTabScreen> createState() => _AdminTabScreenState();
}

class _AdminTabScreenState extends State<AdminTabScreen> {
  int selectedTab = 0;
  String selectedAction = 'Todos';
  String searchQuery = '';

  List<Map<String, dynamic>> users = [
    {'id': 1, 'nome': 'Admin1', 'status': 'Ativo'},
    {'id': 2, 'nome': 'Admin2', 'status': 'Inativo'},
    {'id': 3, 'nome': 'Admin3', 'status': 'Ativo'},
  ];

  List<Map<String, dynamic>> logs = [];

  void addUser(String nome, String status) {
    final newUser = {
      'id': DateTime.now().millisecondsSinceEpoch,
      'nome': nome,
      'status': status,
    };

    setState(() {
      users.add(newUser);
      logs.add({
        'id': DateTime.now().millisecondsSinceEpoch,
        'usuario': nome,
        'acao': 'inseriu',
        'hora': DateTime.now().toString(),
      });
    });
  }

  void editUser(int userId, String novoNome, String novoStatus) {
    final index = users.indexWhere((u) => u['id'] == userId);
    if (index != -1) {
      final antigoNome = users[index]['nome'];
      final antigoStatus = users[index]['status'];

      setState(() {
        users[index]['nome'] = novoNome;
        users[index]['status'] = novoStatus;

        logs.add({
          'id': DateTime.now().millisecondsSinceEpoch,
          'usuario': antigoNome,
          'acao': 'editou',
          'hora': DateTime.now().toString(),
          'campo': 'nome/status',
          'valorAntigo': 'Nome: $antigoNome, Status: $antigoStatus',
          'valorNovo': 'Nome: $novoNome, Status: $novoStatus',
        });
      });
    }
  }

  void deleteUser(int userId) {
    final user = users.firstWhere((u) => u['id'] == userId);
    setState(() {
      users.removeWhere((u) => u['id'] == userId);
      logs.add({
        'id': DateTime.now().millisecondsSinceEpoch,
        'usuario': user['nome'],
        'acao': 'excluiu',
        'hora': DateTime.now().toString(),
        'campo': 'usuário',
        'valorAntigo': user['nome'],
        'valorNovo': 'Usuário removido',
      });
    });
  }

  List<Map<String, dynamic>> getFilteredLogs() {
    return logs.where((log) {
      final matchesAction = selectedAction == 'Todos' || log['acao'] == selectedAction;
      final matchesSearch = log['usuario'].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return matchesAction && matchesSearch;
    }).toList();
  }

  void showLogDetails(Map<String, dynamic> log) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Detalhes da Ação'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('ID: ${log['id']}'),
            Text('Admin: ${log['usuario']}'),
            Text('Ação: ${log['acao']}'),
            Text('Hora: ${log['hora']}'),
            if (log['acao'] == 'editou') ...[
              Text('Campo: ${log['campo']}'),
              Text('Valor antigo: ${log['valorAntigo']}'),
              Text('Valor novo: ${log['valorNovo']}'),
            ],
            if (log['acao'] == 'excluiu') Text('Item excluído: ${log['valorAntigo']}'),
            if (log['acao'] == 'inseriu') Text('Registro inserido'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Fechar')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(height: 4, color: Colors.blue),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'Área do Admin',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          TabBarHeader(
            selectedTab: selectedTab,
            onTabChange: (index) => setState(() => selectedTab = index),
          ),
          Expanded(child: selectedTab == 0 ? buildUsersTab() : buildLogsTab()),
          Container(height: 4, color: Colors.blue),
        ],
      ),
      floatingActionButton: selectedTab == 0
          ? FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) {
                    final nomeController = TextEditingController();
                    final statusController = TextEditingController();
                    return AlertDialog(
                      title: Text('Novo Usuário'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(controller: nomeController, decoration: InputDecoration(labelText: 'Nome')),
                          TextField(controller: statusController, decoration: InputDecoration(labelText: 'Status')),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            addUser(nomeController.text, statusController.text);
                          },
                          child: Text('Salvar'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Icon(Icons.add),
            )
          : null,
    );
  }

  Widget buildUsersTab() {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (_, index) {
        final user = users[index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: ListTile(
            leading: Icon(Icons.person),
            title: Text(user['nome']),
            subtitle: Text('Status: ${user['status']}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    final nomeController = TextEditingController(text: user['nome']);
                    final statusController = TextEditingController(text: user['status']);
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('Editar Usuário'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(controller: nomeController, decoration: InputDecoration(labelText: 'Nome')),
                            TextField(controller: statusController, decoration: InputDecoration(labelText: 'Status')),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              editUser(user['id'], nomeController.text, statusController.text);
                            },
                            child: Text('Salvar'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => deleteUser(user['id']),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildLogsTab() {
    final filteredLogs = getFilteredLogs();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Pesquisar registros',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => setState(() => searchQuery = value),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: ['Todos', 'inseriu', 'editou', 'excluiu'].map((action) {
              return ElevatedButton(
                onPressed: () => setState(() => selectedAction = action),
                child: Text(action),
              );
            }).toList(),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredLogs.length,
              itemBuilder: (_, index) {
                final log = filteredLogs[index];
                return ListTile(
                  leading: Icon(Icons.history),
                  title: Text(
                    '${log['usuario']} ${log['acao']} - ${log['hora'].toString().substring(0, 16)}',
                  ),
                  onTap: () => showLogDetails(log),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TabBarHeader extends StatelessWidget {
  final int selectedTab;
  final Function(int) onTabChange;

  const TabBarHeader({required this.selectedTab, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Row(children: [buildTab('Usuários', 0), buildTab('Logs', 1)]);
  }

  Widget buildTab(String label, int index) {
    final isSelected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTabChange(index),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? Colors.blue : Colors.grey,
                width: 2,
              ),
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
