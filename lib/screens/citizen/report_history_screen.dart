import 'package:flutter/material.dart';
import '../../widgets/report_card.dart';
import '../../widgets/view_template.dart';
import '../../services/report_service.dart';
import '../../models/report_response.dart';

class ReportHistoryScreen extends StatefulWidget {
  final String token;
  final ReportService reportService;

  const ReportHistoryScreen({
    super.key,
    required this.token,
    required this.reportService,
  });

  @override
  ReportHistoryScreenState createState() => ReportHistoryScreenState();
}

class ReportHistoryScreenState extends State<ReportHistoryScreen> {
  late Future<List<ReportResponse>> _reportsFuture;

  @override
  void initState() {
    super.initState();
    _reportsFuture = widget.reportService.getUserReports(widget.token);
  }

  void _createReport(BuildContext context) {
    Navigator.pushNamed(context, '/create-report');
  }

  @override
  Widget build(BuildContext context) {
    return ViewTemplate(
      title: 'Report History',
      scaffoldType: ScaffoldType.citizen,
      content: FutureBuilder<List<ReportResponse>>(
        future: _reportsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            if (snapshot.error.toString().contains('No reports found')) {
              return const Center(
                  child: Text('You have not created any reports yet.'));
            } else {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No reports found.'));
          } else {
            final reports = snapshot.data!;
            return Column(
              children: reports.map((report) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ReportCard(
                    title: report.title,
                    category: report.category,
                    description: report.description,
                    date: report.createdAt,
                    status: report.status,
                    image: Image.asset(
                      'assets/img/img_report_image.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createReport(context),
        backgroundColor: const Color(0x8077A1DD),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
