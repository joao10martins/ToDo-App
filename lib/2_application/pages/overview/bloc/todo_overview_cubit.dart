import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/1_domain/use_cases/load_todo_collections.dart';
import 'package:todo_app/2_application/pages/overview/view_states/todo_overview_loading.dart';
import 'package:todo_app/core/use_case.dart';

part 'todo_overview_state.dart';

class TodoOverviewCubit extends Cubit<TodoOverviewState> {
  TodoOverviewCubit({
    required this.loadToDoCollections,
    TodoOverviewState? initialState,
  }) : super(initialState ?? TodoOverviewLoading());

  final LoadToDoCollections loadToDoCollections;

  Future<void> readToDoCollections() async {
    emit(TodoOverviewLoading());
    try {
      final collectionsFuture = loadToDoCollections.call(NoParams());
      final collections = await collectionsFuture;
    }
  }
}
