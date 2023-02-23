import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  static route(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Test()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test'),
      ),
      body: const Center(
        child: Text('Test'),
      ),
    );
  }
}
