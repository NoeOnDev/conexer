import 'package:flutter/material.dart';
import 'citizen_scaffold.dart';

class FormTemplate extends StatelessWidget {
  final String title;
  final List<Widget> fields;
  final List<Widget> buttons;

  const FormTemplate({
    super.key,
    required this.title,
    required this.fields,
    required this.buttons,
  });

  @override
  Widget build(BuildContext context) {
    return CitizenScaffold(
      body: Container(
        color: const Color(0xFF324A5F),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints
                      .maxHeight,
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
      ),
    );
  }
}
