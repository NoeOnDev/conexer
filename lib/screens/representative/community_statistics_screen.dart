import 'package:flutter/material.dart';
import '../../widgets/view_template.dart';
import '../../services/statistics_service.dart';

class CommunityStatisticsScreen extends StatefulWidget {
  const CommunityStatisticsScreen({super.key});

  @override
  CommunityStatisticsScreenState createState() => CommunityStatisticsScreenState();
}

class CommunityStatisticsScreenState extends State<CommunityStatisticsScreen> {
  late Future<Map<String, dynamic>> _predictionsFuture;
  final StatisticsService statisticsService = StatisticsService();

  @override
  void initState() {
    super.initState();
    _predictionsFuture = statisticsService.getPredictions();
  }

  @override
  Widget build(BuildContext context) {
    return ViewTemplate(
      title: 'Estadísticas de la Comunidad',
      scaffoldType: ScaffoldType.representative,
      content: FutureBuilder<Map<String, dynamic>>(
        future: _predictionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!['status'] != 'success') {
            return const Center(child: Text('No se pudieron cargar las predicciones.'));
          } else {
            final predictions = snapshot.data!['predictions'];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'assets/img/img_statistics.png',
                    width: 250,
                    height: 200,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Predicciones de los reportes para el próximo mes:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                _buildPredictionRow(Icons.construction, 'Infraestructura', predictions['Infrastructure']),
                _buildPredictionRow(Icons.lightbulb, 'Luz', predictions['Light']),
                _buildPredictionRow(Icons.delete, 'Basura', predictions['Trash']),
                _buildPredictionRow(Icons.water, 'Agua', predictions['Water']),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildPredictionRow(IconData icon, String label, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.black),
          const SizedBox(width: 8),
          Text(
            '$label: $value',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}