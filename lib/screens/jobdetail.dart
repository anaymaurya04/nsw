import 'package:flutter/material.dart';

class JobDetailsPage extends StatelessWidget {
  // Job details parameters
  final String title;
  final String description;
  final String days;
  final String hours;
  final String pay;

  const JobDetailsPage({
    super.key,
    required this.title,
    required this.description,
    this.days = "",
    this.hours = "",
    required this.pay,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF432E54),
      appBar: AppBar(
        backgroundColor: const Color(0xFF432E54),
        elevation: 0.0,
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          // Job Details Container
          Expanded(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: const Color(0xFFC8ACD6),
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10.0,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Job Title
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF675A8A),
                      ),
                    ),
                    const SizedBox(height: 16.0),

                    // Job Details Section
                    _buildDetailRow(
                        Icons.description, "Description", description),
                    const SizedBox(height: 12.0),

                    if (days.isNotEmpty)
                      _buildDetailRow(Icons.calendar_today, "Duration", days),

                    if (hours.isNotEmpty)
                      _buildDetailRow(Icons.access_time, "Hours", hours),

                    _buildDetailRow(Icons.monetization_on, "Pay", pay),

                    const SizedBox(height: 20.0),

                    // Additional Job Information
                    const Text(
                      "Job Requirements:",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF675A8A),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      "• Reliable and punctual\n• Good communication skills\n• Ability to follow instructions",
                      style: TextStyle(color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Apply Now Button
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // TODO: Implement application logic
                _showApplicationDialog(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF675A8A),
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              child: const Text(
                "Apply Now",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build detail rows
  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF675A8A), size: 24.0),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF675A8A),
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Method to show application dialog
  void _showApplicationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFC8ACD6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: const Text(
            "Application Submitted",
            style: TextStyle(
              color: Color(0xFF675A8A),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            "Your application has been successfully submitted. We will contact you soon!",
            style: TextStyle(color: Colors.black87),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Go back to previous screen
              },
              child: const Text(
                "OK",
                style: TextStyle(color: Color(0xFF675A8A)),
              ),
            ),
          ],
        );
      },
    );
  }
}
