part of 'todo_details_cubit.dart';

abstract class ToDoDetailsState extends Equatable {
  const ToDoDetailsState();

  @override
  List<Object> get props => [];
}


class ToDoDetailsLoadingState extends ToDoDetailsState {}

class ToDoDetailsErrorState extends ToDoDetailsState {}

class ToDoDetailsLoadedState extends ToDoDetailsState {
  const ToDoDetailsLoadedState({required this.entryIds});

  final List<EntryId> entryIds;

  @override
  List<Object> get props => [entryIds];
}
