import 'package:flutter/material.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';

class TodoDetailsLoaded extends StatelessWidget {
  const TodoDetailsLoaded({
    super.key,
    required this.entryIds,
    required this.collectionId,
  });

  final List<EntryId> entryIds;
  final CollectionId collectionId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: entryIds.length,
          itemBuilder: (context, index) => Text('$index'),
        ),
      ),
    );
  }
}
