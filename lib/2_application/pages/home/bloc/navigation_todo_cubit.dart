import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';

part 'navigation_todo_state.dart';

class NavigationTodoCubit extends Cubit<NavigationTodoState> {
  NavigationTodoCubit() : super(const NavigationTodoState());

  void selectedTodoCollectionChanged(CollectionId collectionId){
    emit(NavigationTodoState(selectedCollectionId: collectionId));
  }

  void secondBodyHasChanged({required bool isSecondBodyDisplayed}){
    emit(NavigationTodoState(isSecondBodyDisplayed: isSecondBodyDisplayed,
      selectedCollectionId: state.selectedCollectionId,
    ));
  }
}
