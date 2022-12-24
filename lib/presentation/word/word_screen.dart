import 'package:backend_testing/repository/local_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/word/word_bloc.dart';
import '../../globals/Utils.dart';
import '../ui elements/colors.dart';
import '../widgets/icon_button.dart';

class WordScreen extends StatefulWidget {
  const WordScreen({
    super.key,
    required this.wordId,
  });

  final String wordId;

  @override
  State<WordScreen> createState() => _WordScreenState();
}

class _WordScreenState extends State<WordScreen> {
  bool isSaved = true;

  @override
  void didChangeDependencies() {
    BlocProvider.of<WordBloc>(context).add(
      GetWordData(widget.wordId),
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MIconButton(
                icon: Icons.arrow_back,
                onPressed: _onPressedBackBButton,
              ),
              BlocBuilder<WordBloc, WordState>(
                builder: (context, state) {
                  if (state is WordLoading) {
                    return _loadingStateWidget;
                  }
                  if (state is WordInitial) {
                    return _initialStateWidget;
                  }
                  if (state is WordLoaded) {
                    return _loadedStateWidget(state);
                  }
                  if (state is WordError) {
                    return _errorStateWidget(
                        'Error Occurred!\nCheck your internet connection.');
                  }
                  return _errorStateWidget(
                    'Unknown word state: ${state.toString()}',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onPressedBackBButton() {
    Navigator.of(context).pop();
  }

  Widget get _loadingStateWidget => const Center(
          child: Padding(
        padding: EdgeInsets.only(top: 80.0),
        child: LinearProgressIndicator(
          backgroundColor: Colors.transparent,
        ),
      ));

  Widget get _initialStateWidget => Text(
        'No word',
        style: Theme.of(context).textTheme.headlineLarge,
      );

  Widget _loadedStateWidget(WordLoaded state) => state.word.widget;

  Widget _errorStateWidget(final String message) => Padding(
        padding: const EdgeInsets.only(top: 60.0),
        child: Card(
          color: primaryDark,
          elevation: 6.0,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
}
