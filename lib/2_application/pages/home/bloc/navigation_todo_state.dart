part of 'navigation_todo_cubit.dart';

class NavigationTodoState extends Equatable {
  final CollectionId? selectedCollectionId;
  final bool? isSecondBodyDisplayed;

  const NavigationTodoState({
    this.isSecondBodyDisplayed,
    this.selectedCollectionId,
  });

  @override
  List<Object?> get props => [isSecondBodyDisplayed, selectedCollectionId];
}

