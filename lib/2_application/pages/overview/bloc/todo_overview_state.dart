part of 'todo_overview_cubit.dart';


abstract class TodoOverviewState extends Equatable {
  const TodoOverviewState();

  @override
  List<Object> get props => [];
}

class TodoOverviewLoading extends TodoOverviewState {}

class TodoOverviewError extends TodoOverviewState {}

class TodoOverviewLoaded extends TodoOverviewState {
  const TodoOverviewLoaded({required this.collections});

  final List<ToDoCollection> collections;

  @override
  List<Object> get props => [collections];
}
