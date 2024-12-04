import 'package:flutter/material.dart';
import '../../widgets/form_template.dart';
import '../../widgets/labeled_text_field.dart';
import '../../widgets/custom_button.dart';
import '../../models/news.dart';
import '../../services/news_service.dart';
import '../../utils/validators.dart';

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
  bool isLoading = false;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void _createNews() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

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
      } finally {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }
    }
  }

  void _cancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return FormTemplate(
      title: 'Crear Noticias',
      scaffoldType: ScaffoldType.representative,
      formKey: formKey,
      fields: [
        LabeledTextField(
          label: 'Título:',
          controller: titleController,
          labelColor: Colors.white,
          validator: (value) =>
              Validators.validateTextWithAccents(value, 'Título', 5, 40),
        ),
        const SizedBox(height: 16),
        LabeledTextField(
          label: 'Descripción:',
          controller: descriptionController,
          maxLines: 8,
          labelColor: Colors.white,
          validator: (value) =>
              Validators.validateDescription(value, 'Descripción', 10, 300),
        ),
      ],
      buttons: [
        CustomButton(
          text: 'Crear Noticias',
          backgroundColor: const Color(0x8077A1DD),
          onPressed: _createNews,
          enabled: !isLoading,
        ),
        const SizedBox(height: 10),
        CustomButton(
          text: 'Cancelar',
          backgroundColor: const Color(0xFFC1121F),
          onPressed: _cancel,
          enabled: !isLoading,
        ),
      ],
    );
  }
}
