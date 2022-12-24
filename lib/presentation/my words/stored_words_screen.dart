import 'package:backend_testing/bloc/stored%20words/stored_words_bloc.dart';
import 'package:backend_testing/globals/Constants.dart';
import 'package:backend_testing/globals/extension_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Models/Word.dart';
import '../ui elements/colors.dart';
import '../widgets/icon_button.dart';

class StoredWordsScreen extends StatefulWidget {
  const StoredWordsScreen({super.key});

  @override
  State<StoredWordsScreen> createState() => _StoredWordsScreenState();
}

class _StoredWordsScreenState extends State<StoredWordsScreen> {
  @override
  void didChangeDependencies() {
    BlocProvider.of<StoredWordsBloc>(context).add(
      GetAllWords(),
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: background,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MIconButton(
                      onPressed: () => _onPressedBackBButton(context),
                      icon: Icons.arrow_back,
                    ),
                    const Text(
                      'My Words',
                      style: TextStyle(
                        color: primaryDark,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    spaceh(47),
                  ],
                ),
              ),
              BlocBuilder<StoredWordsBloc, StoredWordsState>(
                builder: (context, state) {
                  if (state is StoredWordsLoaded) {
                    return _LoadedStateWidget(words: state.words);
                  }
                  return _loadingStateWidget;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onPressedBackBButton(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  Widget get _loadingStateWidget => const Padding(
        padding: EdgeInsets.only(top: 80.0),
        child: LinearProgressIndicator(
          backgroundColor: Colors.transparent,
        ),
      );
}

class _LoadedStateWidget extends StatelessWidget {
  const _LoadedStateWidget({
    super.key,
    required this.words,
  });

  final List<Word> words;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Column(
        children: [
          ...words
              .map(
                (word) => _StoredWordTile(word: word),
              )
              .toList(),
          space40v,
        ],
      ),
    );
  }
}

class _StoredWordTile extends StatefulWidget {
  const _StoredWordTile({
    super.key,
    required this.word,
  });

  final Word word;

  @override
  State<_StoredWordTile> createState() => _StoredWordTileState();
}

class _StoredWordTileState extends State<_StoredWordTile> {
  final pressedScale = 0.925;
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => _pushWordScreen(context, widget.word.id),
      onTapCancel: () => _setIsPressed(false),
      onTapUp: (_) => _setIsPressed(false),
      onTapDown: (_) => _setIsPressed(true),
      onLongPress: _onLongPress,
      child: AnimatedScale(
        scale: isPressed ? pressedScale : 1.0,
        duration: d200,
        curve: Curves.easeOutQuad,
        child: AnimatedContainer(
          duration: d200,
          curve: Curves.easeOutQuad,
          width: w,
          margin: const EdgeInsets.symmetric(vertical: 1.0),
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
          decoration: BoxDecoration(
            color: isPressed
                ? primary.withOpacity(0.5)
                : primary.withOpacity(0.25),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.word.id.capitalize(),
                style: const TextStyle(
                  fontSize: 18,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w600,
                  color: primaryDark,
                ),
              ),
              space10v,
              Text(
                widget.word.lexicalEntries[0].entries[0].senses[0]
                        .definitions?[0] ??
                    '',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pushWordScreen(BuildContext context, String wordId) async {
    Navigator.of(context).pushNamed(
      '/word',
      arguments: wordId,
    );
  }

  void _setIsPressed(bool val) {
    setState(() {
      isPressed = val;
    });
  }

  Future<void> _onLongPress() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: background,
          title: Center(
            child: Text(
              widget.word.id.capitalize(),
            ),
          ),
          content: Text(
            'Are you sure you want to delete this word?',
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
