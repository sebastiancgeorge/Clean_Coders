import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _messageController = TextEditingController();
  final String _apiKey = 'AIzaSyCakH9RmPVmIOM4xpnO4FD-0WvFQcvtvgM'; // Replace with your actual API key
  List<Map<String, String>> _messages = [];

  void _sendMessage() async {
    final userMessage = _messageController.text;
    if (userMessage.isEmpty) return;

    setState(() {
      _messages.add({'role': 'user', 'message': userMessage});
    });

    _messageController.clear();

    try {
      // Make the POST request
      final response = await http.post(
        Uri.parse(
            'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$_apiKey'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {"text": userMessage}
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        // Parse the response and update messages
        final data = jsonDecode(response.body);
        final botMessage = data['contents'][0]['parts'][0]['text'] ?? 'No response';

        setState(() {
          _messages.add({'role': 'bot', 'message': botMessage});
        });
      } else {
        // Handle server errors
        setState(() {
          _messages.add({
            'role': 'bot',
            'message': 'Error: ${response.statusCode}. Could not fetch a response.'
          });
        });
      }
    } catch (e) {
      // Handle connection errors
      setState(() {
        _messages.add({
          'role': 'bot',
          'message': 'Error: Unable to connect to the server. Please try again later.'
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat Support')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message['role'] == 'user';
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue[200] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(message['message']!),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: _sendMessage,
                  child: const Text('Send'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
