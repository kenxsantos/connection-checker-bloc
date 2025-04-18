import 'package:check_connectivity/bloc/connection_bloc.dart';
import 'package:check_connectivity/ui/connection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConnectivityBloc(),
      child: MaterialApp(
        title: 'Connection Check',
        theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme()),
        home: ConnectivityScreen(),
      ),
    );
  }
}
