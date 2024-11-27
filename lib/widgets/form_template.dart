import 'package:flutter/material.dart';
import 'citizen_scaffold.dart';
import 'representative_scaffold.dart';

enum ScaffoldType { citizen, representative }

class FormTemplate extends StatelessWidget {
  final String title;
  final List<Widget> fields;
  final List<Widget> buttons;
  final ScaffoldType scaffoldType;
  final GlobalKey<FormState> formKey;

  const FormTemplate({
    super.key,
    required this.title,
    required this.fields,
    required this.buttons,
    required this.scaffoldType,
    required this.formKey,
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
      color: const Color(0xFF324A5F),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
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
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: const BoxDecoration(
                          color: Color(0xFF324A5F),
                        ),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...fields,
                              const SizedBox(height: 20),
                              ...buttons,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
