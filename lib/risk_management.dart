import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  AppState createState() => AppState();
}

class AppState extends State<MyApp> {
  var inputors = <Inputor>[
    Inputor(1, 
      initialMetric: 'The total number of defects', 
      initialMinRisk: 'The number of defects are well below where expected', 
      initialLowRisk: 'The number of defects are about where we expect',
      initialReasonableRisk: 'The number of defects are slightly above what is expected',
      initialHighRisk: 'The number of defects greatly exceed expectations',
      initialVoteMinRisk: '3',
      initialVoteLowRisk: '4',
      initialVoteReasonableRisk: '8',
      initialVoteHighRisk: '9'),
    Inputor(2, 
      initialMetric: 'Schedule feasibility', 
      initialMinRisk: 'The project can be easily completed in the scheduled time', 
      initialLowRisk: 'The project can be completed in the scheduled time with strict time management',
      initialReasonableRisk: 'The project may be completed in the scheduled time, but will require crunch',
      initialHighRisk: 'The project is unlikely to be completed in the scheduled time',
      initialVoteMinRisk: '7',
      initialVoteLowRisk: '8',
      initialVoteReasonableRisk: '7',
      initialVoteHighRisk: '2'),
    Inputor(3, 
      initialMetric: 'Design progress', 
      initialMinRisk: 'The design is complete', 
      initialLowRisk: 'The design is mostly complete and no major problems are noted',
      initialReasonableRisk: 'The design is incomplete and one major problem is noted with strategies to mitigate',
      initialHighRisk: 'The design is incomplete, has several major problems with no plans to mitigate',
      initialVoteMinRisk: '11',
      initialVoteLowRisk: '6',
      initialVoteReasonableRisk: '6',
      initialVoteHighRisk: '1'),
    Inputor(4, 
      initialMetric: 'Implementation progress', 
      initialMinRisk: 'The implementation is ahead of schedule', 
      initialLowRisk: 'The implementation is on schedule',
      initialReasonableRisk: 'The implementation is slightly behind schedule',
      initialHighRisk: 'The implementation is far behind schedule',
      initialVoteMinRisk: '5',
      initialVoteLowRisk: '6',
      initialVoteReasonableRisk: '5',
      initialVoteHighRisk: '6'),
    Inputor(5, 
      initialMetric: 'Integration progress', 
      initialMinRisk: 'No major integration problems have been detected', 
      initialLowRisk: 'Minor integration problems have been detected',
      initialReasonableRisk: 'At least one major integration problem has been detected, with plans to remedy',
      initialHighRisk: 'Multiple major integration problems have been detected, with no plans to rememdy',
      initialVoteMinRisk: '9',
      initialVoteLowRisk: '8',
      initialVoteReasonableRisk: '7',
      initialVoteHighRisk: '0'),
  ];

  void addNewInputor() {
    setState(() {
      var newId = inputors.last.id + 1;
      inputors.add(Inputor(newId));
    });
  }

  double calculateOverallRisk() {
    double riskSum = 0;
    int riskCount = 0;
    for (int i = 0; i < inputors.length; i++) {
      double singleRisk = this.calculateRisk(inputors[i].voteMinRisk, inputors[i].voteLowRisk, inputors[i].voteReasonableRisk, inputors[i].voteHighRisk);
      if (singleRisk != -1) {
        riskSum += singleRisk;
        riskCount++;
      }
    }
    if (riskSum == 0 && riskCount == 0) {
      return -1;
    }
    return riskSum / riskCount;
  }

  String calculateOverallStatus() {
    double risk = this.calculateOverallRisk();
    return this.getStatusIndicator(risk);
    
  }

  String getStatusIndicator(double calculatedRisk) {
    if (calculatedRisk >= 0 && calculatedRisk < (1/3)) {
      return 'GREEN';
    } else if (calculatedRisk >= (1/3) && calculatedRisk <= (2/3)) {
      return 'YELLOW';
    } else if (calculatedRisk > (2/3) && calculatedRisk <= 1) {
      return 'RED';
    } else return 'UNKNOWN';
  }

  String calculateStatus(int voteMinRisk, int voteLowRisk, int voteReasonableRisk, int voteHighRisk) {
    double calculatedRisk = this.calculateRisk(voteMinRisk, voteLowRisk, voteReasonableRisk, voteHighRisk);
    return this.getStatusIndicator(calculatedRisk);
  }

  int calculateTotalVotes(int voteMinRisk, int voteLowRisk, int voteReasonableRisk, int voteHighRisk) {
    return voteMinRisk + voteLowRisk + voteReasonableRisk + voteHighRisk;
  }

  double calculateLowScore(int voteLowRisk) {
    return voteLowRisk / 3;
  }
  double calculateMedScore(int voteReasonableRisk) {
    return voteReasonableRisk * 2 / 3;
  }

  double calculateRisk(int voteMinRisk, int voteLowRisk, int voteReasonableRisk, int voteHighRisk) {
        var risk = ((this.calculateLowScore(voteLowRisk) + this.calculateMedScore(voteReasonableRisk) + voteHighRisk) / this.calculateTotalVotes(voteMinRisk, voteLowRisk, voteReasonableRisk, voteHighRisk));
        risk = double.parse(risk.toString());
        if (risk.isNaN) {
          return -1;
        }
        return risk;
      
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: Text('Quality Assessment'),
        backgroundColor: Colors.green[600],
        elevation: 50.0,
        leading: IconButton(
                key: Key('addQA'),
                icon: const Icon(Icons.add_box_outlined),
                tooltip: 'Add new quality assessment',
                onPressed: addNewInputor,
            ),
          ),
      body: ListView(
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5), //apply padding to all four sides
            child: Text('Overall status: ${this.calculateOverallStatus()}',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5), //apply padding to all four sides
            child: Text('Overall risk: ${this.calculateOverallRisk() == -1 ? "UNKNOWN" :this.calculateOverallRisk().toStringAsFixed(3)}',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
          ),
          const SizedBox(height: 20),
          ...inputors.map(renderInputor).toList(),
        ],
      ),
    );
  }

  Widget renderInputor(Inputor inputor) {
    return Card(
      child: ListTile(
        title: Padding(
            padding: EdgeInsets.symmetric(vertical: 10), //apply padding to all four sides
            child: Text("Status: ${this.calculateStatus(inputor.voteMinRisk, inputor.voteLowRisk, inputor.voteReasonableRisk, inputor.voteHighRisk)}"),
          ),
        subtitle: Column(children: [
          Row(
            children: [
             Flexible(
              flex: 6,
              child: TextField(
                controller: inputor.metricController,
                decoration: const InputDecoration(labelText: 'Metric'),
              ),
              ),
              const SizedBox(width: 20),
            ]
          ),
          Row(
            children: [
             Flexible(
              flex: 6,
              child: TextField(
                key: Key('minDescription'),
                controller: inputor.minRiskController,
                decoration: const InputDecoration(labelText: 'Minimum Risk', hintText: "Minimum risk description"),
              ),
              ),
              const SizedBox(width: 20),
              Flexible(
              flex: 6,
              child: TextField(
                key: Key('minVote'),
                controller: inputor.voteMinRiskController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Votes'),
                onChanged: (value) { 
                  if (double.tryParse(value) == null) {
                    inputor.voteMinRiskController.clear();
                  } 
                  setState(() {});
                },
              ),

              ),
            ]
          ),
          
          Row(
            children: [
             Flexible(
              flex: 6,
              child: TextField(
                controller: inputor.lowRiskController,
                decoration: const InputDecoration(labelText: 'Low Risk', hintText: "Low risk description"),
              ),
              ),
              const SizedBox(width: 20),
              Flexible(
              flex: 6,
              child: TextField(
                key: Key('lowVote'),
                controller: inputor.voteLowRiskController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Votes'),
                onChanged: (value) { 
                  if (double.tryParse(value) == null) {
                    inputor.voteLowRiskController.clear();
                  } 
                  setState(() {});
                },
              ),
              ),
            ]
          ),
          Row(
            children: [
             Flexible(
              flex: 6,
              child: TextField(
                controller: inputor.reasonableRiskController,
                decoration: const InputDecoration(labelText: 'Reasonable Risk', hintText: "Reasonable risk description"),
              ),
              ),
              const SizedBox(width: 20),
              Flexible(
              flex: 6,
              child: TextField(
                key: Key('reasonableVote'),
                controller: inputor.voteReasonableRiskController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Votes'),
                onChanged: (value) { 
                  if (double.tryParse(value) == null) {
                    inputor.voteReasonableRiskController.clear();
                  } 
                  setState(() {});
                },
              ),
              ),
            ]
          ),
          Row(
            children: [
             Flexible(
              flex: 6,
              child: TextField(
                controller: inputor.highRiskController,
                decoration: const InputDecoration(labelText: 'High Risk', hintText: "High risk description"),
              ),
              ),
              const SizedBox(width: 20),
              Flexible(
              flex: 6,
              child: TextField(
                key: Key('highVote'),
                controller: inputor.voteHighRiskController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Votes'),
                onChanged: (value) { 
                  if (double.tryParse(value) == null) {
                    inputor.voteHighRiskController.clear();
                  } 
                  setState(() {});
                },
              ),
              ),
            ]
          ),
          const SizedBox(height: 20),
          Row(
            children: [
             Text(
                'Low score: ${this.calculateLowScore(inputor.voteLowRisk).toStringAsFixed(2)}',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 20),
            ]
          ),
          const SizedBox(height: 20),
          Row(
            children: [
             Text(
                'Med score: ${this.calculateMedScore(inputor.voteReasonableRisk).toStringAsFixed(2)}',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 20),
            ]
          ),
          const SizedBox(height: 20),
          Row(
            children: [
             Text(
                'High score: ${inputor.voteHighRisk.toStringAsFixed(2)}',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 20),
            ]
          ),
          const SizedBox(height: 20),
          Row(
            children: [
             Text(
                'Total Votes: ${this.calculateTotalVotes(inputor.voteMinRisk, inputor.voteLowRisk, inputor.voteReasonableRisk, inputor.voteHighRisk)}',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 20),
            ]
          ),
          const SizedBox(height: 20),
          Row(
            children: [
             Text(
                'Risk: ${this.calculateRisk(inputor.voteMinRisk, inputor.voteLowRisk, inputor.voteReasonableRisk, inputor.voteHighRisk) == -1 ? 'Please add values to all vote inputs' : this.calculateRisk(inputor.voteMinRisk, inputor.voteLowRisk, inputor.voteReasonableRisk, inputor.voteHighRisk).toStringAsFixed(3)}',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 20),
            ]
          ),
          const SizedBox(height: 30),
        ])
     ));
  }
}

class Inputor {
  int id;
  TextEditingController metricController;
  TextEditingController minRiskController;
  TextEditingController lowRiskController;
  TextEditingController reasonableRiskController;
  TextEditingController highRiskController;
  TextEditingController voteMinRiskController;
  TextEditingController voteLowRiskController;
  TextEditingController voteReasonableRiskController;
  TextEditingController voteHighRiskController;
  Inputor(this.id, {String initialMetric = '', String initialMinRisk = '', 
  String initialLowRisk = '',
  String initialReasonableRisk = '',
  String initialHighRisk = '',
  String initialVoteMinRisk = '',
  String initialVoteLowRisk = '',
  String initialVoteReasonableRisk = '',
  String initialVoteHighRisk = ''})
      : metricController = TextEditingController(text: initialMetric),
        minRiskController = TextEditingController(text: initialMinRisk),
        lowRiskController = TextEditingController(text: initialLowRisk),
        reasonableRiskController = TextEditingController(text: initialReasonableRisk),
        highRiskController = TextEditingController(text: initialHighRisk),
        voteMinRiskController = TextEditingController(text: initialVoteMinRisk),
        voteLowRiskController = TextEditingController(text: initialVoteLowRisk),
        voteReasonableRiskController = TextEditingController(text: initialVoteReasonableRisk),
        voteHighRiskController = TextEditingController(text: initialVoteHighRisk);
  String get metric => metricController.text;
  String get minRisk => minRiskController.text;
  String get lowRisk => lowRiskController.text;
  String get reasonableRisk => reasonableRiskController.text;
  String get highRisk => highRiskController.text;
  int get voteMinRisk => voteMinRiskController.text != '' ? int.parse(voteMinRiskController.text) : 0;
  int get voteLowRisk => voteLowRiskController.text != '' ? int.parse(voteLowRiskController.text) : 0;
  int get voteReasonableRisk => voteReasonableRiskController.text != '' ? int.parse(voteReasonableRiskController.text) : 0;
  int get voteHighRisk => voteHighRiskController.text != '' ? int.parse(voteHighRiskController.text) : 0;
}