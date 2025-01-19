import 'package:bt/chatbot.dart';
import 'package:bt/community.dart';
import 'package:flutter/material.dart';

class RecoveryMember extends StatefulWidget {
  const RecoveryMember({super.key});

  @override
  State<RecoveryMember> createState() => _RecoveryMemberState();
}

class _RecoveryMemberState extends State<RecoveryMember> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const DashboardPage(),
    const SupportPage(),
    const ChatbotPage(),
    const JournalPage(),
    const ProfilePage(),
    const CommunityPage()
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
          NavigationDestination(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.people),
            label: 'Support',
          ),
          NavigationDestination(
          icon: Icon(Icons.chat),
          label: 'Chatbot',
          ),

          NavigationDestination(
            icon: Icon(Icons.book),
            label: 'Journal',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
            NavigationDestination(
              icon: Icon(Icons.group), 
              label: 'Community'),
        ],
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recovery Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Show notifications
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Implement refresh logic
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProgressCard(),
              const SizedBox(height: 16),
              _buildUpcomingActivities(),
              const SizedBox(height: 16),
              _buildDailyTasks(),
              const SizedBox(height: 16),
              _buildMoodTracker(),
            ],
          ),
        ),
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
              'Recovery Progress',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildProgressItem(
                  icon: Icons.calendar_today,
                  title: 'Days Clean',
                  value: '30',
                ),
                _buildProgressItem(
                  icon: Icons.emoji_events,
                  title: 'Milestones',
                  value: '5',
                ),
                _buildProgressItem(
                  icon: Icons.trending_up,
                  title: 'Streak',
                  value: '7',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, size: 32, color: Colors.blue),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(title),
      ],
    );
  }

  Widget _buildUpcomingActivities() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Upcoming Activities',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
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
                title: Text('Activity ${index + 1}'),
                subtitle: Text('Tomorrow at ${index + 9}:00 AM'),
                trailing: FilledButton(
                  onPressed: () {},
                  child: const Text('Join'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDailyTasks() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Daily Tasks',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CheckboxListTile(
            value: false,
            onChanged: (value) {},
            title: const Text('Morning Meditation'),
            subtitle: const Text('10 minutes'),
          ),
          CheckboxListTile(
            value: false,
            onChanged: (value) {},
            title: const Text('Journal Entry'),
            subtitle: const Text('Write about your day'),
          ),
          CheckboxListTile(
            value: false,
            onChanged: (value) {},
            title: const Text('Support Group Meeting'),
            subtitle: const Text('7:00 PM'),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodTracker() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'How are you feeling today?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMoodButton('😊', 'Great'),
                _buildMoodButton('🙂', 'Good'),
                _buildMoodButton('😐', 'Okay'),
                _buildMoodButton('😔', 'Bad'),
                _buildMoodButton('😣', 'Awful'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoodButton(String emoji, String mood) {
    return Column(
      children: [
        TextButton(
          onPressed: () {},
          child: Text(
            emoji,
            style: const TextStyle(fontSize: 32),
          ),
        ),
        Text(mood),
      ],
    );
  }
}

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support Network'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSupportSection(
            'Emergency Contacts',
            [
              _buildContactCard(
                'Crisis Helpline',
                '1-800-123-4567',
                Icons.emergency,
                Colors.red,
              ),
              _buildContactCard(
                'Sponsor',
                'John Doe',
                Icons.person,
                Colors.blue,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSupportSection(
            'Support Groups',
            [
              _buildGroupCard(
                'Daily Check-in Group',
                '10:00 AM Daily',
                '15 members',
              ),
              _buildGroupCard(
                'Weekend Warriors',
                'Saturdays 2:00 PM',
                '23 members',
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add new support contact
        },
        label: const Text('Add Contact'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSupportSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...children,
      ],
    );
  }

  Widget _buildContactCard(
    String name,
    String contact,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(name),
        subtitle: Text(contact),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.phone),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.message),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupCard(String name, String schedule, String members) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.group),
        ),
        title: Text(name),
        subtitle: Text('$schedule\n$members'),
        trailing: FilledButton(
          onPressed: () {},
          child: const Text('Join'),
        ),
        isThreeLine: true,
      ),
    );
  }
}

class JournalPage extends StatelessWidget {
  const JournalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recovery Journal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {
              // Show calendar
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'March 15, 2024',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Today was a challenging day...',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      Chip(
                        label: const Text('Mood: 😊'),
                        backgroundColor: Colors.blue.shade100,
                      ),
                      Chip(
                        label: const Text('Triggers: 0'),
                        backgroundColor: Colors.green.shade100,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new journal entry
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://placeholder.com/150'),
            ),
            const SizedBox(height: 16),
            const Text(
              'John Doe',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Recovery Member since March 2024',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            _buildProfileSection(
              'Recovery Progress',
              [
                _buildProfileItem(Icons.calendar_today, 'Sober Date', 'March 1, 2024'),
                _buildProfileItem(Icons.emoji_events, 'Achievements', '5 Milestones'),
                _buildProfileItem(Icons.trending_up, 'Current Streak', '15 days'),
              ],
            ),
            const SizedBox(height: 16),
            _buildProfileSection(
              'Support Network',
              [
                _buildProfileItem(Icons.person, 'Sponsor', 'Mike Johnson'),
                _buildProfileItem(Icons.group, 'Support Groups', '3 Active'),
                _buildProfileItem(Icons.medical_services, 'Counselor', 'Dr. Smith'),
              ],
            ),
            const SizedBox(height: 16),
            _buildProfileSection(
              'Account Settings',
              [
                _buildProfileItem(Icons.notifications, 'Notifications', 'Enabled'),
                _buildProfileItem(Icons.privacy_tip, 'Privacy', 'Friends Only'),
                _buildProfileItem(Icons.language, 'Language', 'English'),
              ],
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () {
                // Implement logout
                Navigator.of(context).pushReplacementNamed('/');
              },
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection(String title, List<Widget> items) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...items,
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.blue),
          const SizedBox(width: 8),
          Text(
            '$label:',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 8),
          Text(value),
        ],
      ),
    );
  }
}
