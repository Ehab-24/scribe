import 'package:backend_testing/Models/Word.dart';
import 'package:backend_testing/repository/oxford_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'word_event.dart';
part 'word_state.dart';

class WordBloc extends Bloc<WordEvent, WordState> {
  WordBloc() : super(WordInitial()) {
    on<WordEvent>((event, emit) async {
      if (event is GetWordData) {
        emit(
          WordLoading(),
        );
        try {
          final Word word = await OxfordRepository.getData(event.wordId);
          emit(
            WordLoaded(word),
          );
        } catch (e) {
          emit(
            WordError(e.toString()),
          );
        }
      }
    });
  }
}
