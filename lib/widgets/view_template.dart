import 'package:flutter/material.dart';
import 'citizen_scaffold.dart';
import 'representative_scaffold.dart';

enum ScaffoldType { citizen, representative }

class ViewTemplate extends StatelessWidget {
  final String title;
  final Widget content;
  final ScaffoldType scaffoldType;

  const ViewTemplate({
    super.key,
    required this.title,
    required this.content,
    required this.scaffoldType,
  });

  @override
  Widget build(BuildContext context) {
    final scaffold = scaffoldType == ScaffoldType.citizen
        ? CitizenScaffold(body: _buildContent())
        : RepresentativeScaffold(body: _buildContent());

    return scaffold;
  }

  Widget _buildContent() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: content,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
