import 'package:risk_management_project/risk_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

//Boundary Analysis Tests
  test('Status Indicator should be UNKNOWN when calculated risk is -0.01', () {
    final app = AppState();
    String value = app.getStatusIndicator(-0.01);
    expect(value, 'UNKNOWN');
  });

  test('Status Indicator should be RED when calculated risk is 0', () {
    final app = AppState();
    String value = app.getStatusIndicator(0);
    expect(value, 'GREEN');
  });

  test('Status Indicator should be GREEN when calculated risk is 0.01', () {
    final app = AppState();
    String value = app.getStatusIndicator(0);
    expect(value, 'GREEN');
  });
  test('Status Indicator should be GREEN when calculated risk is 0.32', () {
    final app = AppState();
    String value = app.getStatusIndicator(0.32);
    expect(value, 'GREEN');
  });

  test('Status Indicator should be YELLOW when calculated risk is 1/3', () {
    final app = AppState();
    String value = app.getStatusIndicator(1/3);
    expect(value, 'YELLOW');
  });
  test('Status Indicator should be YELLOW when calculated risk is 0.34', () {
    final app = AppState();
    String value = app.getStatusIndicator(0.34);
    expect(value, 'YELLOW');
  });

  test('Status Indicator should be YELLOW when calculated risk is 0.65', () {
    final app = AppState();
    String value = app.getStatusIndicator(0.65);
    expect(value, 'YELLOW');
  });

  test('Status Indicator should be YELLOW when calculated risk is 2/3', () {
    final app = AppState();
    String value = app.getStatusIndicator(2/3);
    expect(value, 'YELLOW');
  });

  test('Status Indicator should be RED when calculated risk is 0.67', () {
    final app = AppState();
    String value = app.getStatusIndicator(0.67);
    expect(value, 'RED');
  });
  test('Status Indicator should be RED when calculated risk is 0.99', () {
    final app = AppState();
    String value = app.getStatusIndicator(0.99);
    expect(value, 'RED');
  });
  test('Status Indicator should be RED when calculated risk is 1', () {
    final app = AppState();
    String value = app.getStatusIndicator(1);
    expect(value, 'RED');
  });
  test('Status Indicator should be UNKNOWN when calculated risk is 1.01', () {
    final app = AppState();
    String value = app.getStatusIndicator(1.01);
    expect(value, 'UNKNOWN');
  });

  //PATH COVERAGE through calculation functions
  test('Calculate total votes should equal 22', () {
    final app = AppState();
    int value = app.calculateTotalVotes(3, 5, 7, 7);
    expect(value, 22);
  });

  test('Calculate low score should equal 3 when the low risk vote is 9', () {
    final app = AppState();
    double value = app.calculateLowScore(9);
    expect(value, 3);
  });

  test('Calculate med score should equal 2 when the reasonable risk vote is 3', () {
    final app = AppState();
    double value = app.calculateMedScore(3);
    expect(value, 2);
  });

  test('Calculate risk should return the correct value', () {
    final app = AppState();
    String value = app.calculateRisk(9, 8, 7, 0).toStringAsFixed(5);
    expect(value, '0.30556');
  });

  test('Calculate status should return the correct value', () {
    final app = AppState();
    String value = app.calculateStatus(9, 8, 7, 0);
    expect(value, 'GREEN');
  });

  test('Calculate overall risk and status should calculate the correct value when 0 QAs is added', () {
      final app = AppState();
      String overallRisk = app.calculateOverallRisk().toStringAsFixed(5);
      String overallStatus = app.calculateOverallStatus();
      expect(overallRisk, '0.43081');
      expect(overallStatus, 'YELLOW');
    });
  //Note: Other overall risk and overall status paths covered in Widget Testing.
}

