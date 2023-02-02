import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/news_entities.dart';
import '../../../domain/use_cases/get_news.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNewsUseCase getNewsUseCase = GetNewsUseCase();
  NewsBloc() : super(NewsInitial()) {
    on<GetNewsListEvent>((event, emit) async {
      emit(NewsLoadingState());
      (await getNewsUseCase()).fold((failure) {
        emit(NewsErrorState(errorMessage: failure.message));
      }, (newsList) {
        emit(NewsLoadedState(newsList: newsList));
      });
    });
  }
}
