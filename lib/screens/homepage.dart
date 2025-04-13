import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'jobcard.dart';
import 'postjobpage.dart';
import 'account_details.dart'; // New

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Stream<List<Job>> streamJobs() {
    return FirebaseFirestore.instance.collection('jobs').snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => Job.fromFirestore(doc))
            .where((job) => job.id.isNotEmpty)
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF432E54),
      appBar: AppBar(
        backgroundColor: const Color(0xFF432E54),
        elevation: 0.0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logged out')),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                color: const Color(0xFF432E54),
                padding: const EdgeInsets.only(top: 20.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser?.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      String username = 'Anon';
                      if (snapshot.hasData && snapshot.data!.exists) {
                        username = snapshot.data!['username'] ?? 'Anon';
                      }
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const AccountDetailsPage(),
                            ),
                          );
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              radius: 30.0,
                              backgroundImage: AssetImage('assets/avatar.jpg'),
                              backgroundColor: Colors.white,
                            ),
                            const SizedBox(width: 16.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hi, $username",
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const Text(
                                  "Welcome back!",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                color: const Color(0xFF432E54),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: const Text(
                  "Recommended Jobs",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 200.0,
                child: StreamBuilder<List<Job>>(
                  stream: streamJobs(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      print(
                          'Stream error in Recommended Jobs: ${snapshot.error}');
                      return const Center(child: Text('Error loading jobs'));
                    }
                    final jobs = snapshot.data ?? [];
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        children: jobs
                            .map((job) => JobCard(
                                  id: job.id,
                                  title: job.title,
                                  description: job.description,
                                  days: job.days ?? '',
                                  hours: job.hours ?? '',
                                  pay: job.pay,
                                ))
                            .toList(),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFC8ACD6),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10.0,
                        offset: Offset(0, -5),
                      ),
                    ],
                  ),
                  child: StreamBuilder<List<Job>>(
                    stream: streamJobs(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        print('Stream error in Job List: ${snapshot.error}');
                        return const Center(child: Text('Error loading jobs'));
                      }
                      final jobs = snapshot.data ?? [];
                      return ListView(
                        padding: const EdgeInsets.all(10.0),
                        children: jobs
                            .map((job) => JobCard(
                                  id: job.id,
                                  title: job.title,
                                  description: job.description,
                                  days: job.days ?? '',
                                  hours: job.hours ?? '',
                                  pay: job.pay,
                                ))
                            .toList(),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const PostJobPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF675A8A),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_circle_outline),
                    SizedBox(width: 10),
                    Text(
                      "Post a New Job",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Job {
  final String id;
  final String title;
  final String description;
  final String? days;
  final String? hours;
  final String pay;

  Job({
    required this.id,
    required this.title,
    required this.description,
    this.days,
    this.hours,
    required this.pay,
  });

  factory Job.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Job(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      days: data['days'],
      hours: data['hours'],
      pay: data['pay'] ?? '',
    );
  }
}
