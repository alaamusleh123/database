import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v12_database/database/db_controller.dart';
import 'package:v12_database/providers/note_provider.dart';
import 'package:v12_database/providers/user_provider.dart';
import 'package:v12_database/screens/app/note_screen.dart';
import 'package:v12_database/screens/app/notes_screen.dart';
import 'package:v12_database/screens/auth/login_screen.dart';
import 'package:v12_database/screens/auth/register_screen.dart';
import 'package:v12_database/screens/launch_screen.dart';
import 'package:v12_database/storage/pref_controller.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await PrefController().initPref();
  await DbController().initDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (context)=>UserProvider()),
        ChangeNotifierProvider<NoteProvider>(create: (context)=>NoteProvider(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/launch_screen',
        routes: {
          '/launch_screen': (context) =>LaunchScreen(),
          '/login_screen': (context) =>LoginScreen(),
          '/register_screen': (context) =>RegisterScreen(),
          '/notes_screen': (context) =>NotesScreen(),
          '/note_screen': (context) =>NoteScreen(),
        },
      ),
    );
  }
}
