import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_application/src/pages/SettingsScreen_tab.dart';
import 'package:flutter_application/src/pages/bluetooth_tab.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import 'package:flutter_application/src/pages/sensor_tab.dart';
import 'package:flutter_application/src/pages/profile_tab.dart';

class BaseScreen extends StatefulWidget {
  final int initialIndex;
  final BluetoothDevice? device;
  final BluetoothConnection? connection;
  final Stream<Uint8List>? dataStream;

  const BaseScreen({
    super.key,
    this.initialIndex = 0,
    this.device,
    this.connection,
    this.dataStream,
  });

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  late int currentIndex;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: <Widget>[
          //const BluetoothSimuladoPage(),

          // CHAMADA CORRETA: SensorTab com S maiúsculo
          SensorTab(
            device: widget.device,
            connection: widget.connection,
            dataStream: widget.dataStream,
          ),

          const SettingsScreen(),
          const ProfileTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInQuint,
            );
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blueAccent,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withAlpha(100),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.bluetooth),
            label: 'Bluetooth',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.sensors), label: 'Sensor'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configurações',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
