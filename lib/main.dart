import 'package:flutter/material.dart';

import 'bloc/stored words/stored_words_bloc.dart';
import 'bloc/word/word_bloc.dart';
import 'presentation/home/home_screen.dart';
import 'presentation/ui elements/colors.dart';
import 'presentation/route_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WordBloc(),
        ),
        BlocProvider(
          create: (context) => StoredWordsBloc(),
        ),
      ],
      child: MaterialApp(
        initialRoute: '/home',
        onGenerateRoute: RouteController.onGenerateRoSute,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: primaryDark),
          appBarTheme: const AppBarTheme(
            color: primaryLight,
          ),
          chipTheme: const ChipThemeData(
            backgroundColor: background,
            shadowColor: Colors.black,
            elevation: 4.0,
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
