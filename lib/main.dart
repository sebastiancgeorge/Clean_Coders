import 'package:bt/chatbot.dart';
import 'package:bt/community.dart';
import 'package:flutter/material.dart';
import 'recoverymember.dart'; // Import RecoveryMember page
import 'volunteer.dart'; // Import Volunteer page
import 'lawenforcerpage.dart'; // Import LawEnforcer page
import 'healthexpert.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Back Together',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const AuthPage(),
      routes: {
        '/chatbot': (context) => const ChatbotPage(), // Add this line
        '/recoveryMember': (context) => const RecoveryMember(),
        '/volunteer': (context) => const VolunteerPage(),
        '/lawEnforcer': (context) => const LawEnforcerPage(),
        '/community': (context) => const CommunityPage(),
        '/health_expert': (context) => const HealthExpertPage(),

      },
    );
  }
}


enum UserType {
  recoveryMember,
  healthExpert,
  volunteer,
  lawEnforcer,
}

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  UserType _selectedUserType = UserType.recoveryMember;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      print('Login as: $_selectedUserType'); // Debug log
      switch (_selectedUserType) {
        case UserType.recoveryMember:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const RecoveryMember()),
          );
          break;
        case UserType.volunteer:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const VolunteerPage()),
          );
          break;
        case UserType.lawEnforcer:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LawEnforcerPage()),
          );
          break;
        case UserType.healthExpert:
           Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HealthExpertPage()),
          );
          break;
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out all fields.')),
      );
    }
  }

  void _handleSignUp() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty &&
        _nameController.text.isNotEmpty) {
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passwords do not match.')),
        );
        return;
      }

      print('Sign up as: $_selectedUserType'); // Debug log
      switch (_selectedUserType) {
        case UserType.recoveryMember:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const RecoveryMember()),
          );
          break;
        case UserType.volunteer:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const VolunteerPage()),
          );
          break;
        case UserType.lawEnforcer:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LawEnforcerPage()),
          );
          break;
        case UserType.healthExpert:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Health Expert page is under development.'),
            ),
          );
          break;
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out all fields.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Back Together',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                SegmentedButton<bool>(
                  segments: const [
                    ButtonSegment(value: true, label: Text('Login')),
                    ButtonSegment(value: false, label: Text('Sign Up')),
                  ],
                  selected: {isLogin},
                  onSelectionChanged: (Set<bool> newSelection) {
                    setState(() {
                      isLogin = newSelection.first;
                    });
                  },
                ),
                const SizedBox(height: 24),
                if (!isLogin)
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Full Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                if (!isLogin) const SizedBox(height: 16),
                DropdownButtonFormField<UserType>(
                  value: _selectedUserType,
                  decoration: const InputDecoration(
                    labelText: 'Select User Type',
                    border: OutlineInputBorder(),
                  ),
                  items: UserType.values.map((UserType type) {
                    return DropdownMenuItem<UserType>(
                      value: type,
                      child: Text(type.toString().split('.').last),
                    );
                  }).toList(),
                  onChanged: (UserType? newValue) {
                    setState(() {
                      _selectedUserType = newValue!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                if (!isLogin) const SizedBox(height: 16),
                if (!isLogin)
                  TextField(
                    controller: _confirmPasswordController,
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: isLogin ? _handleLogin : _handleSignUp,
                  child: Text(isLogin ? 'Login' : 'Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
