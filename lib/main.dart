import 'package:final_project/auth/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{
  //supabase set up
  await Supabase.initialize(
    anonKey:"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB3aXBseXFicXNtdHN0ZnJoeXhjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzY2MTM0NTAsImV4cCI6MjA1MjE4OTQ1MH0.hGOp14osunzQuRDBaAbB3cmJ-bk98kFf3ubOOXd5LeA" ,
    url:"https://pwiplyqbqsmtstfrhyxc.supabase.co" ,
    );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AuthGate(),
    );
  }
}
