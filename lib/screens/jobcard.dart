import 'package:flutter/material.dart';
import 'jobdetail.dart';

class JobCard extends StatelessWidget {
  final String id; // Firestore document ID
  final String title;
  final String description;
  final String days;
  final String hours;
  final String pay;

  const JobCard({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    this.days = "",
    this.hours = "",
    required this.pay,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => JobDetailsPage(
              jobId: id,
              title: '',
              description: '',
              pay: '',
            ),
          ),
        );
      },
      child: Card(
        elevation: 4.0,
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          width: 250.0,
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF675A8A),
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                description,
                style: TextStyle(color: Colors.grey[700]),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12.0),
              if (days.isNotEmpty)
                Text(
                  "Duration: $days",
                  style: TextStyle(color: Colors.grey[600]),
                ),
              if (hours.isNotEmpty)
                Text(
                  "Hours: $hours",
                  style: TextStyle(color: Colors.grey[600]),
                ),
              Text(
                "Pay: $pay",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF675A8A),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
