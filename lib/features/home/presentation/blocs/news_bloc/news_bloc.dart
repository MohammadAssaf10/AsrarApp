import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/app/di.dart';
import '../../../domain/entities/news_entities.dart';
import '../../../domain/repository/home_repository.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final HomeRepository homeRepository =instance<HomeRepository>();
  NewsBloc() : super(NewsInitial()) {
    on<GetNewsListEvent>((event, emit) async {
      emit(NewsLoadingState());
      (await homeRepository.getNews()).fold((failure) {
        emit(NewsErrorState(errorMessage: failure.message));
      }, (newsList) {
        emit(NewsLoadedState(newsList: newsList));
      });
    });
  }
}
