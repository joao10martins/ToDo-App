import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/use_cases/load_todo_entry_ids_for_collection.dart';
import 'package:todo_app/core/use_case.dart';

part 'todo_details_state.dart';

class ToDoDetailsCubit extends Cubit<ToDoDetailsState> {
  ToDoDetailsCubit({
    required this.collectionId,
    required this.loadToDoEntryIdsForCollection,
  }) : super(ToDoDetailsLoadingState());

  final CollectionId collectionId;
  final LoadToDoEntryIdsForCollection loadToDoEntryIdsForCollection;

  Future<void> fetch() async {
    emit(ToDoDetailsLoadingState());
    try {
      final entryIds = await loadToDoEntryIdsForCollection.call(CollectionIdParam(collectionId: collectionId));
      if(entryIds.isLeft){
        emit(ToDoDetailsErrorState());
      } else {
        emit(ToDoDetailsLoadedState(entryIds: entryIds.right));
      }
    } on Exception {
      emit(ToDoDetailsErrorState());
    }
  }
}
