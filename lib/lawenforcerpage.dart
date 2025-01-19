import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;


class LawEnforcerPage extends StatefulWidget {
  const LawEnforcerPage({super.key});

  @override
  State<LawEnforcerPage> createState() => _LawEnforcerPageState();
}

class _LawEnforcerPageState extends State<LawEnforcerPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const LawEnforcerDashboard(),
    const IncidentManagementPage(),
    const HotspotMapPage(),
    const LawEnforcerProfile(),
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
          NavigationDestination(icon: Icon(Icons.list), label: 'Incidents'),
          NavigationDestination(icon: Icon(Icons.map), label: 'Heatmap'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// Dashboard Page
class LawEnforcerDashboard extends StatelessWidget {
  const LawEnforcerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Law Enforcement Dashboard'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSummaryCard(),
          const SizedBox(height: 16),
          _buildIncidentTrendsGraph(),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Summary Statistics',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(Icons.report, 'Reports', '120'),
                _buildStatItem(Icons.trending_up, 'Active Cases', '45'),
                _buildStatItem(Icons.gavel, 'Resolved', '75'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, size: 32, color: Colors.blue),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(label),
      ],
    );
  }

  Widget _buildIncidentTrendsGraph() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Incident Trends',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Placeholder(
              fallbackHeight: 200,
              child: Center(
                child: Text(
                  'Graph: Incident Trends (Placeholder)',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Incident Management Page
class IncidentManagementPage extends StatelessWidget {
  const IncidentManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Incident Management'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16.0),
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.report),
              ),
              title: Text('Incident ${index + 1}'),
              subtitle: Text('Reported on Jan ${index + 15}, 2025\nStatus: Pending'),
              trailing: IconButton(
                icon: const Icon(Icons.check),
                onPressed: () {
                  // Mark as resolved logic
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

// ... (keep all other classes the same until HotspotMapPage)

class HotspotMapPage extends StatelessWidget {
  const HotspotMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotspot Map'),
      ),
      body: Center(
        child: InteractiveViewer(
          maxScale: 4.0,
          minScale: 0.5,
          child: Image.asset(
            'assets/hotspot_map.png', // Make sure to add your PNG file to assets
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}



class LawEnforcerProfile extends StatelessWidget {
  const LawEnforcerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
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
              'Officer Jane Smith',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text('Law Enforcer since Jan 2020',
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
        title: const Text('Officer Statistics'),
        subtitle: const Text(
            'Reports Investigated: 300\nCases Resolved: 250\nYears of Service: 5'),
      ),
    );
  }
}
