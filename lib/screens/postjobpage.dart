import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PostJobPage extends StatefulWidget {
  const PostJobPage({super.key});

  @override
  _PostJobPageState createState() => _PostJobPageState();
}

class _PostJobPageState extends State<PostJobPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _daysController = TextEditingController();
  final TextEditingController _hoursController = TextEditingController();
  final TextEditingController _payController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    _titleController.dispose();
    _descriptionController.dispose();
    _daysController.dispose();
    _hoursController.dispose();
    _payController.dispose();
    super.dispose();
  }

  void _submitJob() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement Firebase or backend job posting logic
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Job Posted: ${_titleController.text}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Post a Job",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF432E54),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: "Job Title",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a job title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: "Job Description",
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a job description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _daysController,
                  decoration: const InputDecoration(
                    labelText: "Days",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter number of days';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _hoursController,
                  decoration: const InputDecoration(
                    labelText: "Hours",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter number of hours';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _payController,
                  decoration: const InputDecoration(
                    labelText: "Pay",
                    border: OutlineInputBorder(),
                    prefixText: '\$',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter pay rate';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: _submitJob,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF675A8A),
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: const Text(
                    "Post Job",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
