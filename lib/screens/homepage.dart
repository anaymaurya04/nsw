import 'package:flutter/material.dart';
import 'jobcard.dart';
import 'postjobpage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF432E54),
      appBar: AppBar(
        backgroundColor: const Color(0xFF432E54),
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          // Main content of the page
          Column(
            children: [
              // User profile section
              Container(
                color: const Color(0xFF432E54),
                padding: const EdgeInsets.only(bottom: 20.0),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30.0,
                        backgroundImage: AssetImage('assets/avatar.jpg'),
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(width: 16.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi, Anon",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
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
                ),
              ),

              // Recommended Jobs Text
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

              // Horizontally scrollable job cards
              const SizedBox(
                height: 200.0,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: [
                      JobCard(
                        title: "Pet sitting",
                        description:
                            "Need a female nanny for my 2 yr old labrador retriever",
                        days: "2 days",
                        pay: "₹700",
                      ),
                      JobCard(
                        title: "Waitering Job",
                        description: "Waitering job at local restaurant",
                        hours: "6 hours",
                        pay: "₹500",
                      ),
                      JobCard(
                        title: "Hospital Visit Assistance",
                        description: "Assistance needed for hospital visit",
                        hours: "6 hours",
                        pay: "₹600",
                      ),
                    ],
                  ),
                ),
              ),

              // Vertically scrollable job list
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
                  child: ListView(
                    padding: const EdgeInsets.all(10.0),
                    children: const [
                      JobCard(
                        title: "Pet sitting",
                        description:
                            "Need a female nanny for my 2 yr old labrador retriever. Dog Food provided",
                        days: "2 days",
                        pay: "₹700",
                      ),
                      JobCard(
                        title: "Waitering Job",
                        description: "Waitering job at local restaurant",
                        hours: "6 hours",
                        pay: "₹500",
                      ),
                      JobCard(
                        title: "Hospital Visit Assistance",
                        description: "Assistance needed for hospital visit",
                        hours: "6 hours",
                        pay: "₹600",
                      ),
                      JobCard(title: "Sample", description: "any", pay: "21")
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Positioned Post a Job Button at the bottom
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
