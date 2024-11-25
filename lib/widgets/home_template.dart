import 'package:flutter/material.dart';
import 'citizen_scaffold.dart';
import 'representative_scaffold.dart';

enum ScaffoldType { citizen, representative }

class HomeTemplate extends StatelessWidget {
  final String title;
  final String imagePath;
  final List<String> texts;
  final List<Widget> buttons;
  final ScaffoldType scaffoldType;

  const HomeTemplate({
    super.key,
    required this.title,
    required this.imagePath,
    required this.texts,
    required this.buttons,
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                    Center(
                      child: Image.asset(
                        imagePath,
                        width: 370,
                        height: 260,
                      ),
                    ),
                    for (int i = 0; i < texts.length; i++) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          texts[i],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: buttons[i],
                      ),
                    ],
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
