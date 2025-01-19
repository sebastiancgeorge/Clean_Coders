import 'package:flutter/material.dart';

class HealthExpertPage extends StatefulWidget {
  const HealthExpertPage({super.key});

  @override
  State<HealthExpertPage> createState() => _HealthExpertPageState();
}

class _HealthExpertPageState extends State<HealthExpertPage> {
  final TextEditingController _videoTitleController = TextEditingController();
  final TextEditingController _videoLinkController = TextEditingController();

  final List<Map<String, String>> _videos = [];
  final List<Map<String, String>> _contactRequests = [
    {"name": "John Doe", "reason": "Needs counseling for addiction recovery."},
    {"name": "Jane Smith", "reason": "Requested a follow-up consultation."},
  ];

  void _postVideo() {
    final title = _videoTitleController.text.trim();
    final link = _videoLinkController.text.trim();

    if (title.isNotEmpty && link.isNotEmpty) {
      setState(() {
        _videos.add({"title": title, "link": link});
      });
      _videoTitleController.clear();
      _videoLinkController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Video posted successfully!')),
      );
    }
  }

  void _contactPatient(String name) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Contacting $name...')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Health Expert Dashboard'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.video_library), text: 'Post Videos'),
              Tab(icon: Icon(Icons.people), text: 'Contact Patients'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Post Videos Tab
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Post a New Video',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _videoTitleController,
                    decoration: const InputDecoration(
                      labelText: 'Video Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _videoLinkController,
                    decoration: const InputDecoration(
                      labelText: 'Video Link (YouTube, etc.)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _postVideo,
                    child: const Text('Post Video'),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Posted Videos',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _videos.length,
                      itemBuilder: (context, index) {
                        final video = _videos[index];
                        return ListTile(
                          leading: const Icon(Icons.play_circle_fill),
                          title: Text(video['title']!),
                          subtitle: Text(video['link']!),
                          onTap: () {
                            // Open video link
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Contact Patients Tab
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Contact Requests',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _contactRequests.length,
                      itemBuilder: (context, index) {
                        final request = _contactRequests[index];
                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.person),
                            title: Text(request['name']!),
                            subtitle: Text(request['reason']!),
                            trailing: ElevatedButton(
                              onPressed: () => _contactPatient(request['name']!),
                              child: const Text('Contact'),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
