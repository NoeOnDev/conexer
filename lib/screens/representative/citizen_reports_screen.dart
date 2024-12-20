import 'package:flutter/material.dart';
import '../../widgets/report_card.dart';
import '../../widgets/view_template.dart';
import '../../services/report_service.dart';
import '../../models/report_response.dart';

class CitizenReportsScreen extends StatefulWidget {
  final String token;
  final ReportService reportService;

  const CitizenReportsScreen({
    super.key,
    required this.token,
    required this.reportService,
  });

  @override
  CitizenReportsScreenState createState() => CitizenReportsScreenState();
}

class CitizenReportsScreenState extends State<CitizenReportsScreen> {
  late Future<List<ReportResponse>> _reportsFuture;

  @override
  void initState() {
    super.initState();
    _reportsFuture = widget.reportService.getAllReports(widget.token);
  }

  void _markAsResolved(String reportId) async {
    try {
      await widget.reportService.updateReportStatus(
        widget.token,
        reportId,
        'RESOLVED',
      );
      setState(() {
        _reportsFuture = widget.reportService.getAllReports(widget.token);
      });
    } catch (e) {
      if (mounted) {}
    }
  }

  void _markAsUnresolved(String reportId) async {
    try {
      await widget.reportService.updateReportStatus(
        widget.token,
        reportId,
        'UNRESOLVED',
      );
      setState(() {
        _reportsFuture = widget.reportService.getAllReports(widget.token);
      });
    } catch (e) {
      if (mounted) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewTemplate(
      title: 'Reportes de Ciudadanos',
      scaffoldType: ScaffoldType.representative,
      content: FutureBuilder<List<ReportResponse>>(
        future: _reportsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            final errorMessage = snapshot.error.toString();
            if (errorMessage.contains('No reports found for locality')) {
              return const Center(
                child: Text('No se encontraron reportes para su localidad.'),
              );
            } else {
              return Center(child: Text('Error: $errorMessage'));
            }
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No se encontraron reportes.'));
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
                    locality: report.locality,
                    street: report.street,
                    image: Image.asset(
                      'assets/img/img_cases.png',
                      fit: BoxFit.cover,
                    ),
                    onResolved: () => _markAsResolved(report.id),
                    onUnresolved: () => _markAsUnresolved(report.id),
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
