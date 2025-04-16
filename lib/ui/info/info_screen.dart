import 'dart:io';

import 'package:flutter/material.dart';
import 'package:terox_ai/data/model/diagnosis_model.dart';
import 'package:terox_ai/utils/extensions/navigation.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({
    super.key,
    required this.diagnosisModel,
    required this.file,
  });

  final File file;
  final DiagnosisModel diagnosisModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Ma\'lumotlar')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text('Id: ${diagnosisModel.id}'),
              Text('Created: ${diagnosisModel.created}'),
              Text('Model: ${diagnosisModel.model}'),
              Text('Object: ${diagnosisModel.object}'),
              Text('Index: ${diagnosisModel.choicesModel[0].index}'),
              Text(
                'Finish Reason: ${diagnosisModel.choicesModel[0].finishReason}',
              ),
              Text(
                'Content: ${diagnosisModel.choicesModel[0].message.content}',
              ),
              Text('Role: ${diagnosisModel.choicesModel[0].message.role}'),
              Text(
                'Completion Tokens: ${diagnosisModel.usageModel.completionTokens}',
              ),
              Text('Prompt Tokens: ${diagnosisModel.usageModel.promptTokens}'),
              Text('Total Tokens: ${diagnosisModel.usageModel.totalTokens}'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.pop();
                },
                child: const Text('Ortga qaytish'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
