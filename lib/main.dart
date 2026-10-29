import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sumadhura/features/homepage/screen/homepage_screen.dart';
import 'package:sumadhura/features/register_visitor/register_visitor_bloc/register_visitor_bloc.dart';
import 'package:sumadhura/features/visitor/visitor_bloc/visitor_bloc.dart';
import 'package:sumadhura/features/visitor/repo/visitor_repo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final visitorsRepo = VisitorsRepo();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => VisitorBloc(visitorsRepo: visitorsRepo),
        ),
        BlocProvider(
          create: (context) => RegisterVisitorBloc(visitorsRepo: visitorsRepo),
        ),
      ],
      child: MaterialApp(
        title: 'Sumadhura',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
        home: const HomePageScreen(),
      ),
    );
  }
}
