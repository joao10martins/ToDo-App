part of 'todo_overview_cubit.dart';


abstract class ToDoOverviewState extends Equatable {
  const ToDoOverviewState();

  @override
  List<Object> get props => [];
}

class ToDoOverviewLoadingState extends ToDoOverviewState {
  const ToDoOverviewLoadingState();
}

class ToDoOverviewErrorState extends ToDoOverviewState {
  const ToDoOverviewErrorState();
}

class ToDoOverviewLoadedState extends ToDoOverviewState {
  const ToDoOverviewLoadedState({required this.collections});

  final List<ToDoCollection> collections;

  @override
  List<Object> get props => [collections];
}
