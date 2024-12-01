// post_job.dart
import 'package:flutter/material.dart';

class PostJobPage extends StatelessWidget {
  const PostJobPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController daysController = TextEditingController();
    final TextEditingController hoursController = TextEditingController();
    final TextEditingController payController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Post a Job"),
        backgroundColor: const Color(0xFF432E54),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Job Title"),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: "Job Description"),
              maxLines: 3,
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: daysController,
              decoration: const InputDecoration(labelText: "Days"),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: hoursController,
              decoration: const InputDecoration(labelText: "Hours"),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: payController,
              decoration: const InputDecoration(labelText: "Pay"),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement Firebase logic to create job
                print("Job Posted: ${titleController.text}");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF675A8A),
              ),
              child: const Text("Post Job"),
            ),
          ],
        ),
      ),
    );
  }
}
