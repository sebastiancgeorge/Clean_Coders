import 'package:flutter/material.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSection(
            title: 'Helpful Videos',
            items: [
              _buildVideoCard(
                'Overcoming Addiction',
                'Learn tips to stay motivated in recovery.',
                'https://via.placeholder.com/150',
              ),
              _buildVideoCard(
                'Daily Meditation',
                'Relaxation techniques to reduce stress.',
                'https://via.placeholder.com/150',
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSection(
            title: 'Support Forums',
            items: [
              _buildForumCard('Recovery Stories', 'Share your journey and inspire others.'),
              _buildForumCard('Tips & Tricks', 'Practical advice for staying clean.'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required List<Widget> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...items,
      ],
    );
  }

  Widget _buildVideoCard(String title, String description, String thumbnailUrl) {
    return Card(
      child: ListTile(
        leading: Image.network(thumbnailUrl, width: 80, fit: BoxFit.cover),
        title: Text(title),
        subtitle: Text(description),
        trailing: IconButton(
          icon: const Icon(Icons.play_arrow),
          onPressed: () {
            // Implement video playback
          },
        ),
      ),
    );
  }

  Widget _buildForumCard(String title, String description) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.forum, size: 40, color: Colors.blue),
        title: Text(title),
        subtitle: Text(description),
        trailing: IconButton(
          icon: const Icon(Icons.open_in_new),
          onPressed: () {
            // Implement forum navigation
          },
        ),
      ),
    );
  }
}
