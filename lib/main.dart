// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _interestController = TextEditingController();
  final TextEditingController _tenureController = TextEditingController();

  double _emi = 0;

  void _calculateEmi() {
    double principal = double.tryParse(_amountController.text) ?? 0;
    double annualInterestRate = double.tryParse(_interestController.text) ?? 0;
    int tenureMonths = int.tryParse(_tenureController.text) ?? 0;

    // Check for valid inputs
    if (principal <= 0 || annualInterestRate <= 0 || tenureMonths <= 0) {
      setState(() {
        _emi = 0;
      });
      return;
    }

    double monthlyInterestRate = (annualInterestRate / 100) / 12;
    double emi = (principal * monthlyInterestRate * pow(1 + monthlyInterestRate, tenureMonths)) /
        (pow(1 + monthlyInterestRate, tenureMonths) - 1);
    setState(() {
      _emi = emi;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EMI Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Loan Amount'),
            ),
            TextField(
              controller: _interestController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Annual Interest Rate (%)'),
            ),
            TextField(
              controller: _tenureController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Loan Tenure (Months)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateEmi,
              child: const Text('Calculate EMI'),
            ),
            const SizedBox(height: 20),
            Text(
              'Your EMI: ${_emi > 0 ? _emi.toStringAsFixed(2) : 'Enter values to calculate EMI'}',
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
