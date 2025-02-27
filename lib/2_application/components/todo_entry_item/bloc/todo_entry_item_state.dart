part of 'todo_entry_item_cubit.dart';

abstract class TodoEntryItemState extends Equatable {
  const TodoEntryItemState();

  @override
  List<Object> get props => [];
}

class TodoEntryItemLoadedState extends TodoEntryItemState {
  const TodoEntryItemLoadedState({required this.toDoEntry});

  final ToDoEntry toDoEntry;

  @override
  List<Object> get props => [toDoEntry];
}

class TodoEntryItemLoadingState extends TodoEntryItemState {
  @override
  List<Object> get props => [];
}

class TodoEntryItemErrorState extends TodoEntryItemState {
  @override
  List<Object> get props => [];
}

