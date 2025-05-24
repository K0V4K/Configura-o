import 'package:flutter/material.dart';

class ConfigScreen extends StatelessWidget {
  final Color plusColor;

  const ConfigScreen({super.key, this.plusColor = Colors.red});

  @override
  Widget build(BuildContext context) {
    double halfHeight = MediaQuery.of(context).size.height / 2;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: halfHeight,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.only(top: 60),
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: 'Presence',
                    style: TextStyle(color: Colors.white),
                  ),
                  TextSpan(text: '+', style: TextStyle(color: plusColor)),
                ],
              ),
            ),
          ),

          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/bluetooth'),
                    child: Text('Bluetooth'),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/history'),
                    child: Text('Histórico'),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/pesquisa'),
                    child: Text('Auditoria'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
