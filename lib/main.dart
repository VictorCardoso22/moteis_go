import 'package:flutter/material.dart';
import 'package:moteis_go/ir_agora/ir_agora.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IrAgora(),
    );
  }
}
