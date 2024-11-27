import 'package:flutter/material.dart';
import '../../widgets/form_template.dart';
import '../../widgets/labeled_text_field.dart';
import '../../widgets/custom_button.dart';
import '../../models/news.dart';
import '../../services/news_service.dart';

class CreateNewsScreen extends StatefulWidget {
  final String token;
  final NewsService newsService;

  const CreateNewsScreen({
    super.key,
    required this.token,
    required this.newsService,
  });

  @override
  CreateNewsScreenState createState() => CreateNewsScreenState();
}

class CreateNewsScreenState extends State<CreateNewsScreen> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void _createNews() async {
    if (formKey.currentState!.validate()) {
      final now = DateTime.now().toIso8601String();
      final news = News(
        title: titleController.text,
        description: descriptionController.text,
        createdAt: now,
      );

      try {
        await widget.newsService.createNews(widget.token, news);
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, '/news-history');
      } catch (e) {
        // Handle error
      }
    }
  }

  void _cancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return FormTemplate(
      title: 'Create News',
      scaffoldType: ScaffoldType.representative,
      formKey: formKey,
      fields: [
        LabeledTextField(
          label: 'Title:',
          controller: titleController,
          labelColor: Colors.white,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Title is required';
            }
            if (value.length < 5 || value.length > 30) {
              return 'Title must be between 5 and 30 characters';
            }
            if (!RegExp(r'^[a-zA-Z0-9\s]+$').hasMatch(value)) {
              return 'Title can only contain letters and numbers';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        LabeledTextField(
          label: 'Description:',
          controller: descriptionController,
          maxLines: 8,
          labelColor: Colors.white,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Description is required';
            }
            if (value.length < 10 || value.length > 200) {
              return 'Description must be between 10 and 200 characters';
            }
            return null;
          },
        ),
      ],
      buttons: [
        CustomButton(
          text: 'Create News',
          backgroundColor: const Color(0x8077A1DD),
          onPressed: _createNews,
        ),
        const SizedBox(height: 10),
        CustomButton(
          text: 'Cancel',
          backgroundColor: const Color(0xFFC1121F),
          onPressed: _cancel,
        ),
      ],
    );
  }
}
