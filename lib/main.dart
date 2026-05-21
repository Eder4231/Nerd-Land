import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'theme/nerdland_theme.dart';
import 'pages/login_page.dart';
import 'pages/start_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyByQ5ukws6ixSpoZr5QO3v1LMQ5fc_L3HA',
      appId: '1:195464626906:android:907ae0495f232cb6085be3',
      messagingSenderId: '195464626906',
      projectId: 'nerdland-2b431',
      storageBucket: 'nerdland-2b431.firebasestorage.app',
    ),
  );

  runApp(const NerdlandApp());
}

class NerdlandApp extends StatelessWidget {
  const NerdlandApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nerdland',
      debugShowCheckedModeBanner: false,
      theme: NerdLandTheme.theme,
      home: FirebaseAuth.instance.currentUser != null
          ? const StartPage()
          : const LoginPage(),
    );
  }
}