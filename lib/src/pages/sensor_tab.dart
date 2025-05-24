/*import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:intl/intl.dart';

class SensorTab extends StatefulWidget {
  final BluetoothDevice device;
  final BluetoothConnection connection;
  final Stream<Uint8List> dataStream;

  const SensorTab({
    Key? key,
    required this.device,
    required this.connection,
    required this.dataStream,
  }) : super(key: key);

  @override
  _SensorTabState createState() => _SensorTabState();
}

class _SensorTabState extends State<SensorTab> {
  late StreamSubscription<Uint8List> _sub;
  int _contador = 0;
  bool _ledAceso = false;
  final List<String> _registros = [];
  String _buffer = '';
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _sub = widget.dataStream.listen(_onData, onDone: _onDone);
  }

  void _onData(Uint8List data) {
    if (_isDisposed) return;
    _buffer += ascii.decode(data);
    final parts = _buffer.split('\n');
    _buffer = parts.removeLast();

    for (var msg in parts) {
      msg = msg.trim();
      if (msg.contains('Movimento detectado') && mounted) {
        setState(() {
          _contador++;
          _ledAceso = true;
          final agora = DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now());
          _registros.add('Entrada $_contador em $agora');
        });
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) setState(() => _ledAceso = false);
        });
      }
    }
  }

  void _onDone() {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Conexão encerrada pelo dispositivo')),
      );
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _sub.cancel();
    widget.connection.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sensor de Presença')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Dispositivo: ${widget.device.name}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            Text('Contador: $_contador', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            Icon(Icons.sensors, size: 60, color: _ledAceso ? Colors.blue : Colors.grey),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _registros.length,
                itemBuilder: (_, i) => ListTile(
                  leading: const Icon(Icons.access_time),
                  title: Text(_registros[i]),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _sub.cancel();
                widget.connection.dispose();
                Navigator.pop(context);
              },
              child: const Text('Desconectar'),
            ),
          ],
        ),
      ),
    );
  }
}*/

// lib/src/pages/sensor_tab.dart

// lib/src/pages/sensor_tab.dart

// lib/src/pages/sensor_tab.dart

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:intl/intl.dart';

class SensorTab extends StatefulWidget {
  final BluetoothDevice? device;
  final BluetoothConnection? connection;
  final Stream<Uint8List>? dataStream;

  const SensorTab({super.key, this.device, this.connection, this.dataStream});

  @override
  State<SensorTab> createState() => _SensorTabState();
}

class _SensorTabState extends State<SensorTab> {
  StreamSubscription<Uint8List>? _sub;
  bool _isConnected = false;

  int _contador = 0;
  bool _ledAceso = false;
  final List<String> _registros = [];
  String _buffer = '';
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    if (widget.device != null &&
        widget.connection != null &&
        widget.dataStream != null) {
      _isConnected = true;
      _sub = widget.dataStream!.listen(
        _onData,
        onDone: _onDone,
        onError: (_) => _onDone(),
      );
    }
  }

  void _onData(Uint8List data) {
    if (_isDisposed) return;
    _buffer += ascii.decode(data);
    final parts = _buffer.split('\n');
    _buffer = parts.removeLast();

    for (var msg in parts) {
      if (msg.trim().contains('Movimento detectado') && mounted) {
        setState(() {
          _contador++;
          _ledAceso = true;
          final agora = DateFormat(
            'dd/MM/yyyy HH:mm:ss',
          ).format(DateTime.now());
          _registros.add('Entrada $_contador em $agora');
        });
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) setState(() => _ledAceso = false);
        });
      }
    }
  }

  void _onDone() {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Conexão encerrada pelo dispositivo')),
      );
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _sub?.cancel();
    widget.connection?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // AppBar compartilhada com remoção da seta e título branco
    final appBar = AppBar(
      automaticallyImplyLeading: false, // remove seta de voltar
      backgroundColor: Colors.blueAccent,
      title: const Text(
        'Sensor de Presença',
        style: TextStyle(color: Colors.white, fontSize: 24),
      ),
    );

    if (!_isConnected) {
      return Scaffold(
        appBar: appBar,
        body: const Center(
          child: Text(
            'Nenhum dispositivo conectado',
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Dispositivo: ${widget.device!.name}'),
            const SizedBox(height: 20),
            Text('Contador: $_contador', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            Icon(
              Icons.sensors,
              size: 60,
              color: _ledAceso ? Colors.blue : Colors.grey,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _registros.length,
                itemBuilder:
                    (_, i) => ListTile(
                      leading: const Icon(Icons.access_time),
                      title: Text(_registros[i]),
                    ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _sub?.cancel();
                widget.connection?.dispose();
                Navigator.pop(context);
              },
              child: const Text('Desconectar'),
            ),
          ],
        ),
      ),
    );
  }
}
