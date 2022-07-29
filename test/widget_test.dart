// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:risk_management_project/main.dart';
import 'package:risk_management_project/risk_management.dart';

void main() {
  //On page load
  testWidgets('title load', (tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(Main());
    expect(find.text('Quality Assessment'), findsNWidgets(1));
  });

  testWidgets('check text fields', (tester) async {
    await tester.pumpWidget(Main());
    expect(find.byType(TextField), findsNWidgets(9));
  });

  testWidgets('find add button', (tester) async {
    await tester.pumpWidget(Main());
    expect(find.byIcon(Icons.add_box_outlined), findsOneWidget);
  });

  testWidgets('find key', (tester) async {
    await tester.pumpWidget(Main());
    expect(find.byKey(Key('minDescription')), findsOneWidget);
  });

  //Test user flow

  testWidgets('test score calculation for one', (tester) async {
    await tester.pumpWidget(Main());
    expect(find.text("Status: YELLOW"), findsNWidgets(1));
    await tester.enterText(find.byKey(Key('minVote')), '3');
    await tester.pump();
    await tester.enterText(find.byKey(Key('lowVote')), '4');
    await tester.pump();
    await tester.enterText(find.byKey(Key('reasonableVote')), '8');
    await tester.pump();
    await tester.enterText(find.byKey(Key('highVote')), '9');
    await tester.pump();

    var lowScore = (4 / 3).toStringAsFixed(2);
    var medScore = (8 * 2 / 3).toStringAsFixed(2);
    var highScore = 9.toStringAsFixed(2);
    var totalVotes = 24;
    var Overallrisk = (((4 / 3) + (8 * 2 / 3) + (9)) / totalVotes);
    var totalRisk = Overallrisk.toStringAsFixed(3);
    expect(find.text('Low score: $lowScore'), findsOneWidget);
    expect(find.text('Med score: $medScore'), findsOneWidget);
    expect(find.text('High score: $highScore'), findsOneWidget);
    expect(find.text('Risk: $totalRisk'), findsOneWidget);
    expect(find.text('Status: YELLOW'), findsNWidgets(1));

    //expect(find.text('Overall status: YELLOW'), findsOneWidget);
    //expect(find.text('Overall risk: $Overallrisk'), findsOneWidget);
  });

  // testWidgets('use add button', (tester) async {
  //   await tester.pumpWidget(Main());
  //   expect(find.text("Status: UNKNOWN"), findsNWidgets(1));
  //   // await tester.enterText(find.byKey(Key('minVote')), '3');
  //   // await tester.pump();
  //   // await tester.enterText(find.byKey(Key('lowVote')), '4');
  //   // await tester.pump();
  //   // await tester.enterText(find.byKey(Key('reasonableVote')), '8');
  //   // await tester.pump();
  //   // await tester.enterText(find.byKey(Key('highVote')), '9');
  //   // await tester.pump();

  //   // var lowScore = (4 / 3).toStringAsFixed(2);
  //   // var medScore = (8 * 2 / 3).toStringAsFixed(2);
  //   // var highScore = 9.toStringAsFixed(2);
  //   // var totalVotes = 24;
  //   // var Overallrisk = (((4 / 3) + (8 * 2 / 3) + (9)) / totalVotes);
  //   // var totalRisk = Overallrisk.toStringAsFixed(3);
  //   /////////////////////////////////////////////
  //   ///Add button
  //   await tester.tap(find.byIcon(Icons.add_box_outlined));
  //   await tester.pump();
  //   await tester.enterText(find.byKey(Key('minVote')), '7');
  //   await tester.pump();
  //   await tester.enterText(find.byKey(Key('lowVote')), '8');
  //   await tester.pump();
  //   await tester.enterText(find.byKey(Key('reasonableVote')), '7');
  //   await tester.pump();
  //   await tester.enterText(find.byKey(Key('highVote')), '2');
  //   await tester.pump();

  //   var lowScore2 = (8 / 3).toStringAsFixed(2);
  //   var medScore2 = (7 * 2 / 3).toStringAsFixed(2);
  //   var highScore2 = 2.toStringAsFixed(2);
  //   var totalVotes2 = 24;
  //   var Overallrisk2 = (((8 / 3) + (7 * 2 / 3) + (2)) / totalVotes2);
  //   var totalRisk2 = Overallrisk2.toStringAsFixed(3);

  //   //var overallRiskAvg = ((Overallrisk + Overallrisk2) / 2);
  //   // expect(find.text('Overall risk: $Overallrisk2'), findsOneWidget);
  //   // expect(find.text('Overall risk: UNKNOWN'), findsOneWidget);
  //   expect(find.text("High score: 2.00"), findsOneWidget);
  //   //expect(find.text('High score: 9.00'), findsOneWidget);
  //   //should be one unkown and one yellow
  //   expect(find.byKey(Key('minDescription')), findsNWidgets(2));

  //});
}
