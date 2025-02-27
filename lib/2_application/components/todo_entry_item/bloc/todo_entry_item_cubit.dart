import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/1_domain/entities/todo_entry.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/use_cases/load_todo_entry.dart';
import 'package:todo_app/1_domain/use_cases/update_todo_entry.dart';
import 'package:todo_app/core/use_case.dart';

part 'todo_entry_item_state.dart';

class TodoEntryItemCubit extends Cubit<TodoEntryItemState> {
  TodoEntryItemCubit(
      {required this.entryId,
      required this.collectionId,
      required this.loadToDoEntry,
      required this.uploadTodoEntry})
      : super(TodoEntryItemLoadingState());

  final EntryId entryId;
  final CollectionId collectionId;
  final LoadToDoEntry loadToDoEntry;
  final UpdateTodoEntry uploadTodoEntry;

  Future<void> fetch() async {
    try {
      final entry = await loadToDoEntry.call(
        ToDoEntryIdsParam(
          collectionId: collectionId,
          entryId: entryId,
        ),
      );
      return entry.fold(
        (left) => emit(TodoEntryItemErrorState()),
        (right) => emit(
          TodoEntryItemLoadedState(toDoEntry: right),
        ),
      );
    } on Exception {
      emit(TodoEntryItemErrorState());
    }
  }

  Future<void> update() async {
    try {
      final updatedEntry = await uploadTodoEntry.call(
        ToDoEntryIdsParam(collectionId: collectionId, entryId: entryId),
      );

      return updatedEntry.fold(
        (left) => emit(TodoEntryItemErrorState()),
        (right) => emit(
          TodoEntryItemLoadedState(toDoEntry: right),
        ),
      );
    } on Exception {
      emit(TodoEntryItemErrorState());
    }
  }
}
