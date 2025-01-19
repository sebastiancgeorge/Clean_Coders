import 'package:flutter/material.dart';

class VolunteerPage extends StatefulWidget {
  const VolunteerPage({super.key});

  @override
  State<VolunteerPage> createState() => _VolunteerPageState();
}

class _VolunteerPageState extends State<VolunteerPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const VolunteerDashboard(),
    const VolunteerSupportPage(),
    const VolunteerJournalPage(),
    const VolunteerProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          NavigationDestination(icon: Icon(Icons.people), label: 'Support'),
          NavigationDestination(icon: Icon(Icons.book), label: 'Journal'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// Dashboard Page
class VolunteerDashboard extends StatelessWidget {
  const VolunteerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Volunteer Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Add notification logic
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildProgressCard(),
          const SizedBox(height: 16),
          _buildUpcomingEvents(),
          const SizedBox(height: 16),
          _buildRecentReports(),
        ],
      ),
    );
  }

  Widget _buildProgressCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Volunteer Progress',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildProgressItem(Icons.report, 'Reports', '15'),
                _buildProgressItem(Icons.access_time, 'Hours', '25'),
                _buildProgressItem(Icons.people, 'Events', '8'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressItem(IconData icon, String title, String value) {
    return Column(
      children: [
        Icon(icon, size: 32, color: Colors.blue),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(title),
      ],
    );
  }

  Widget _buildUpcomingEvents() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Upcoming Events',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.event),
                ),
                title: Text('Event ${index + 1}'),
                subtitle: Text('Location: City Park\nDate: Jan ${index + 20}, 2025'),
                trailing: FilledButton(
                  onPressed: () {},
                  child: const Text('Join'),
                ),
                isThreeLine: true,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRecentReports() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Recent Reports',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.report),
            ),
            title: const Text('Incident Report: Noise Complaint'),
            subtitle: const Text('Submitted 2 days ago\nStatus: Resolved'),
          ),
          ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.report),
            ),
            title: const Text('Incident Report: Suspicious Activity'),
            subtitle: const Text('Submitted 1 week ago\nStatus: In Progress'),
          ),
        ],
      ),
    );
  }
}

// Support Page
class VolunteerSupportPage extends StatelessWidget {
  const VolunteerSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support Network'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildContactSection(),
          const SizedBox(height: 16),
          _buildResourcesSection(),
        ],
      ),
    );
  }

  Widget _buildContactSection() {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.person, color: Colors.blue),
        title: const Text('Community Liaison'),
        subtitle: const Text('Contact: John Doe\nPhone: +1 123 456 7890'),
        trailing: IconButton(
          icon: const Icon(Icons.phone),
          onPressed: () {
            // Add call action
          },
        ),
      ),
    );
  }

  Widget _buildResourcesSection() {
    return Card(
      child: Column(
        children: [
          const ListTile(
            title: Text('Volunteer Resources'),
            subtitle: Text('Find helpful guides and training materials.'),
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Volunteer Handbook'),
            trailing: IconButton(
              icon: const Icon(Icons.download),
              onPressed: () {
                // Add download logic
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.play_circle_fill),
            title: const Text('Training Videos'),
            trailing: IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                // Add navigation to video page
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Journal Page
class VolunteerJournalPage extends StatelessWidget {
  const VolunteerJournalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Volunteer Journal'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16.0),
            child: ListTile(
              title: Text('Journal Entry ${index + 1}'),
              subtitle: const Text(
                  'Reflect on today’s experience helping the community.'),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // Add edit logic
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

// Profile Page
class VolunteerProfile extends StatelessWidget {
  const VolunteerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Volunteer Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            const SizedBox(height: 16),
            const Text(
              'Jane Smith',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text('Volunteer since Jan 2025',
                style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),
            _buildStatsCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCard() {
    return Card(
      child: ListTile(
        title: const Text('Volunteer Statistics'),
        subtitle: const Text('Reports Submitted: 15\nHours Contributed: 40'),
      ),
    );
  }
}
