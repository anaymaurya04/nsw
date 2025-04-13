import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JobDetailsPage extends StatelessWidget {
  final String jobId;

  const JobDetailsPage(
      {super.key,
      required this.jobId,
      required String description,
      required String title,
      required String pay});

  Stream<Map<String, dynamic>?> streamJobDetails() {
    return FirebaseFirestore.instance
        .collection('jobs')
        .doc(jobId)
        .snapshots()
        .map((doc) {
      if (!doc.exists) {
        print('No document found for jobId: $jobId');
        return null;
      }
      print('Streamed job data: ${doc.data()}');
      return doc.data() as Map<String, dynamic>;
    });
  }

  Future<void> _applyForJob(BuildContext context) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You must be logged in to apply')),
        );
        return;
      }
      await FirebaseFirestore.instance.collection('applications').add({
        'jobId': jobId,
        'userId': user.uid,
        'timestamp': FieldValue.serverTimestamp(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Applied successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to apply: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Rendering JobDetailsPage with jobId: "$jobId"');
    if (jobId.isEmpty) {
      return Scaffold(
        backgroundColor: const Color(0xFF432E54),
        appBar: AppBar(
          backgroundColor: const Color(0xFF432E54),
          elevation: 0.0,
          title:
              const Text('Job Details', style: TextStyle(color: Colors.white)),
        ),
        body: const Center(
          child: Text(
            'Invalid job ID',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF432E54),
      appBar: AppBar(
        backgroundColor: const Color(0xFF432E54),
        elevation: 0.0,
        title: const Text('Job Details', style: TextStyle(color: Colors.white)),
      ),
      body: StreamBuilder<Map<String, dynamic>?>(
        stream: streamJobDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            print('Stream error in JobDetailsPage: ${snapshot.error}');
            return Center(
              child: Text(
                'Error loading job details: ${snapshot.error}',
                style: const TextStyle(color: Colors.white),
              ),
            );
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Text(
                'Job not found',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final job = snapshot.data!;
          return Container(
            decoration: const BoxDecoration(
              color: Color(0xFFC8ACD6),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  job['title'] ?? 'No title',
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF675A8A),
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  job['description'] ?? 'No description',
                  style: TextStyle(color: Colors.grey[700], fontSize: 16.0),
                ),
                const SizedBox(height: 16.0),
                if (job['days'] != null && job['days'].isNotEmpty)
                  Text(
                    'Duration: ${job['days']}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14.0),
                  ),
                if (job['hours'] != null && job['hours'].isNotEmpty)
                  Text(
                    'Hours: ${job['hours']}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14.0),
                  ),
                Text(
                  'Pay: ${job['pay'] ?? 'N/A'}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF675A8A),
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _applyForJob(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF675A8A),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text('Apply'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
