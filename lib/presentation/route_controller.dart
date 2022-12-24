import 'package:backend_testing/globals/Constants.dart';
import 'package:backend_testing/presentation/home/home_screen.dart';
import 'package:backend_testing/presentation/my%20words/stored_words_screen.dart';
import 'package:backend_testing/presentation/word/word_screen.dart';
import 'package:flutter/material.dart';

class RouteController {
  static Route onGenerateRoSute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/home':
        return _buildReplacementRoute(const HomeScreen());
      case '/my_words':
        return _buildReplacementRoute(const StoredWordsScreen());
      case '/word':
        if (args is String) {
          return _buildPushRoute(WordScreen(wordId: args));
        }
        return _errorRoute('Error: Invalid arguments.');
      default:
        return _errorRoute('Error: Invalid Route.');
    }
  }

  static Route _buildPushRoute(Widget screen) => PageRouteBuilder(
        pageBuilder: (conetxt, animation, _) => screen,
        transitionDuration: d300,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const curve = Curves.easeOutQuad;
          final tween = Tween(begin: 0.5, end: 1.0);
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: curve,
          );

          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: tween.animate(curvedAnimation),
              child: child,
            ),
          );
        },
      );

  static Route _buildReplacementRoute(Widget screen) => PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          Offset begin;
          if (screen is HomeScreen) {
            begin = const Offset(-1.0, 0.0);
          } else {
            begin = const Offset(1.0, 0.0);
          }
          const end = Offset.zero;
          const curve = Curves.easeOutQuad;

          final tween = Tween(begin: begin, end: end);
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: curve,
          );
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: tween.animate(curvedAnimation),
              child: child,
            ),
          );
        },
      );

  static MaterialPageRoute _errorRoute(String message) => MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: Text('Error!'),),
          body: Center(
            child: Text(
              message,
              style: const TextStyle(fontSize: 32),
            ),
          ),
        ),
      );
}
