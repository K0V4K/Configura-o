import 'package:flutter/material.dart';

class AdminTabScreen extends StatefulWidget {
  const AdminTabScreen({super.key});

  @override
  State<AdminTabScreen> createState() => _AdminTabScreenState();
}

class _AdminTabScreenState extends State<AdminTabScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Tab> myTabs = <Tab>[
    const Tab(text: 'Usuários'),
    const Tab(text: 'Logs'),
  ];

  List<Map<String, dynamic>> _usuarios = [
    {"nome": "Admin1", "status": "Ativo", "permissao": "Admin"},
    {"nome": "Admin2", "status": "Inativo", "permissao": "Admin"},
    {"nome": "Admin3", "status": "Ativo", "permissao": "Admin"},
  ];

  final TextEditingController _searchController = TextEditingController();
  List<String> _auditData = [
    'Admin1 inseriu registro - 2025-05-22 09:00',
    'Admin2 editou dados - 2025-05-22 09:15',
    'Admin1 excluiu item - 2025-05-22 09:30',
    'Admin3 inseriu relatório - 2025-05-22 10:00',
    'Admin2 editou configuração - 2025-05-22 10:15',
    'Admin1 excluiu arquivo - 2025-05-22 10:30',
  ];
  List<String> _filteredData = [];
  String? _selectedAction;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: myTabs.length, vsync: this);
    _filteredData = _auditData;
    _searchController.addListener(_filterAuditData);
  }

  void _filterAuditData() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredData = _auditData.where((item) {
        final itemLower = item.toLowerCase();
        final matchesQuery = query.isEmpty || itemLower.contains(query);
        final matchesAction = _selectedAction == null ||
            itemLower.contains(_selectedAction!.toLowerCase());
        return matchesQuery && matchesAction;
      }).toList();
    });
  }

  void _selectAction(String? action) {
    setState(() {
      _selectedAction = action;
      _filterAuditData();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildUsuariosTab() {
    final admins = _usuarios.where((user) => user['permissao'] == 'Admin').toList();

    return ListView.builder(
      itemCount: admins.length,
      itemBuilder: (context, index) {
        final user = admins[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: const Icon(Icons.person),
            title: Text(user['nome']),
            subtitle: Text('Status: ${user['status']}'),
          ),
        );
      },
    );
  }

  Widget _buildLogsTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              labelText: 'Pesquisar registros',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Wrap(
            spacing: 8.0,
            children: [
              FilterChip(
                label: const Text('Inseriu'),
                selected: _selectedAction == 'inseriu',
                onSelected: (selected) {
                  _selectAction(selected ? 'inseriu' : null);
                },
              ),
              FilterChip(
                label: const Text('Editou'),
                selected: _selectedAction == 'editou',
                onSelected: (selected) {
                  _selectAction(selected ? 'editou' : null);
                },
              ),
              FilterChip(
                label: const Text('Excluiu'),
                selected: _selectedAction == 'excluiu',
                onSelected: (selected) {
                  _selectAction(selected ? 'excluiu' : null);
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredData.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.history),
                title: Text(_filteredData[index]),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Selecionado: ${_filteredData[index]}'),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Área do Admin'),
        bottom: TabBar(
          controller: _tabController,
          tabs: myTabs,
          indicatorColor: Colors.white,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildUsuariosTab(),
          _buildLogsTab(),
        ],
      ),
    );
  }
}
