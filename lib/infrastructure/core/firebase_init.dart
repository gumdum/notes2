import 'package:firebase_core/firebase_core.dart';

FirebaseOptions get firebaseOptions => const FirebaseOptions(
      appId: '1:156230246084:ios:4f569c3b649cf16633339',
      apiKey: 'AIzaSyAgUhHU8wSJgO5MVNy95tMT07NEjzMOfz0',
      projectId: 'note-app-42459',
      messagingSenderId: '448618578101',
    );

Future<void> initializeDefault() async {
  final FirebaseApp app = await Firebase.initializeApp();
  // ignore: avoid_print
  print('Initialized default app $app');
}
