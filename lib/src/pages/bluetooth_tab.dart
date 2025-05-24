import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter_application/src/base/base_screen.dart';

class BluetoothSimuladoPage extends StatefulWidget {
  const BluetoothSimuladoPage({super.key});

  @override
  _BluetoothSimuladoPageState createState() => _BluetoothSimuladoPageState();
}

class _BluetoothSimuladoPageState extends State<BluetoothSimuladoPage> {
  bool useSimulation = false;
  List<BluetoothDevice> _devices = [];
  BluetoothDevice? _selectedDevice;
  bool _isConnecting = false;

  @override
  void initState() {
    super.initState();
    _initBluetooth();
  }

  Future<void> _initBluetooth() async {
    if (useSimulation) {
      setState(() {
        _devices = [
          BluetoothDevice(
            name: "Dispositivo Simulado",
            address: "00:11:22:33:44:55",
          ),
        ];
        _selectedDevice = null;
      });
      return;
    }

    final permissions = [
      Permission.bluetooth,
      Permission.bluetoothConnect,
      Permission.bluetoothScan,
      Permission.location,
    ];
    final statuses = await permissions.request();
    if (statuses.values.any((s) => s != PermissionStatus.granted)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Permissões de Bluetooth não concedidas.'),
        ),
      );
      return;
    }

    if (await FlutterBluetoothSerial.instance.state ==
        BluetoothState.STATE_OFF) {
      await FlutterBluetoothSerial.instance.requestEnable();
    }

    final devices = await FlutterBluetoothSerial.instance.getBondedDevices();
    setState(() {
      _devices = devices;
      _selectedDevice = null;
    });
  }

  Future<void> _connect() async {
    if (_selectedDevice == null) return;
    setState(() => _isConnecting = true);

    try {
      final conn = await BluetoothConnection.toAddress(
        _selectedDevice!.address,
      );

      final controller = StreamController<Uint8List>.broadcast();
      conn.input!.listen(
        (data) => controller.add(data),
        onDone: () => controller.close(),
        onError: (e) => controller.addError(e),
      );

      setState(() => _isConnecting = false);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (_) => BaseScreen(
                initialIndex: 1,
                device: _selectedDevice!,
                connection: conn,
                dataStream: controller.stream,
              ),
        ),
      );
    } catch (e) {
      setState(() => _isConnecting = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Falha ao conectar: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conexao Bluetooth'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButton<BluetoothDevice>(
              isExpanded: true,
              hint: const Text("Selecione um dispositivo"),
              value: _selectedDevice,
              onChanged: (d) => setState(() => _selectedDevice = d),
              items:
                  _devices
                      .map(
                        (d) => DropdownMenuItem(
                          value: d,
                          child: Text(d.name ?? d.address),
                        ),
                      )
                      .toList(),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                onPressed: _isConnecting ? null : _connect,
                child: Text(
                  _isConnecting ? 'Conectando...' : 'Conectar e Continuar',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
