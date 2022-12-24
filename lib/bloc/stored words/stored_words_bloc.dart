import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../Models/Word.dart';
import '../../repository/local_repository.dart';

part 'stored_words_event.dart';
part 'stored_words_state.dart';

class StoredWordsBloc extends Bloc<StoredWordsEvent, StoredWordsState> {
  StoredWordsBloc() : super(StoredWordsLoading()) {
    on<StoredWordsEvent>((event, emit) async {
      if (event is GetAllWords) {
        emit(
          StoredWordsLoading(),
        );
        final List<Word> words = await LocalRepository.instance.readAllWords();
        emit(
          StoredWordsLoaded(words),
        );
      }
    });
  }
}
