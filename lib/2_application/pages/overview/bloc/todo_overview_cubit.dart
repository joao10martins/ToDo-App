import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/1_domain/use_cases/load_todo_collections.dart';
import 'package:todo_app/core/use_case.dart';

part 'todo_overview_state.dart';

class ToDoOverviewCubit extends Cubit<ToDoOverviewState> {
  ToDoOverviewCubit({
    required this.loadToDoCollections,
    ToDoOverviewState? initialState,
  }) : super(initialState ?? const ToDoOverviewLoadingState());

  final LoadToDoCollections loadToDoCollections;

  Future<void> readToDoCollections() async {
    emit(const ToDoOverviewLoadingState());
    try {
      final collectionsFuture = loadToDoCollections.call(NoParams());
      final collections = await collectionsFuture;

      if(collections.isLeft) {
        emit(const ToDoOverviewErrorState());
      } else {
        emit(ToDoOverviewLoadedState(collections: collections.right));
      }
    } on Exception {
      emit(const ToDoOverviewErrorState());
    }
  }
}
