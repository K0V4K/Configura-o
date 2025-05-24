import 'package:flutter/material.dart';
import 'package:flutter_application/src/models/audit_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<AuditEntry> _allData = [];
  List<AuditEntry> _filteredData = [];

  String? _selectedAction;

  @override
  void initState() {
    super.initState();
    _allData = [
      AuditEntry(user: 'Admin1', action: 'inseriu registro', timestamp: DateTime.parse('2025-05-22 09:00')),
      AuditEntry(user: 'Admin2', action: 'editou dados', timestamp: DateTime.parse('2025-05-22 09:15')),
      AuditEntry(user: 'Admin3', action: 'excluiu item', timestamp: DateTime.parse('2025-05-22 09:30')),
    ];
    _filteredData = _allData;
    _searchController.addListener(_filterAuditData);
  }

  void _filterAuditData() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredData = _allData.where((entry) {
        final fullText = entry.formatted.toLowerCase();
        final matchesQuery = query.isEmpty || fullText.contains(query);
        final matchesAction = _selectedAction == null || entry.action.toLowerCase().contains(_selectedAction!);
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Auditoria')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Pesquisar registros',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Wrap(
            spacing: 8,
            children: [
              FilterChip(
                label: Text('Inseriu'),
                selected: _selectedAction == 'inseriu',
                onSelected: (v) => _selectAction(v ? 'inseriu' : null),
              ),
              FilterChip(
                label: Text('Editou'),
                selected: _selectedAction == 'editou',
                onSelected: (v) => _selectAction(v ? 'editou' : null),
              ),
              FilterChip(
                label: Text('Excluiu'),
                selected: _selectedAction == 'excluiu',
                onSelected: (v) => _selectAction(v ? 'excluiu' : null),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.list),
                  title: Text(_filteredData[index].formatted),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
