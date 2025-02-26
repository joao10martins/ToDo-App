import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';
import 'package:todo_app/1_domain/use_cases/load_todo_entry_ids_for_collection.dart';
import 'package:todo_app/2_application/core/page_config.dart';
import 'package:todo_app/2_application/pages/details/bloc/todo_details_cubit.dart';
import 'package:todo_app/2_application/pages/details/view_states/todo_details_error.dart';
import 'package:todo_app/2_application/pages/details/view_states/todo_details_loaded.dart';
import 'package:todo_app/2_application/pages/details/view_states/todo_details_loading.dart';
import 'package:todo_app/2_application/pages/overview/view_states/todo_overview_loading.dart';

class ToDoDetailsPageProvider extends StatelessWidget {
  const ToDoDetailsPageProvider({super.key, required this.collectionId});

  final CollectionId collectionId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ToDoDetailsCubit>(
      create: (context) => ToDoDetailsCubit(
        collectionId: collectionId,
        loadToDoEntryIdsForCollection: LoadToDoEntryIdsForCollection(
          toDoRepository: RepositoryProvider.of<ToDoRepository>(context),
        ),
      )..fetch(),
      child: ToDoDetailsPage(collectionId: collectionId),
    );
  }
}


class ToDoDetailsPage extends StatelessWidget {
  const ToDoDetailsPage({super.key, required this.collectionId});

  final CollectionId collectionId;

  static const pageConfig = PageConfig(
      icon: Icons.details_rounded,
      name: 'details',
      child: Placeholder(),
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToDoDetailsCubit, ToDoDetailsState>(
      builder: (context, state) {
        if(state is ToDoDetailsLoadingState){
          return const TodoDetailsLoading();
        } else if(state is ToDoDetailsLoadedState) {
          return TodoDetailsLoaded(entryIds: state.entryIds, collectionId: collectionId);
        } else {
          return const TodoDetailsError();
        }
      },
    );
  }
}
