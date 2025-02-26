import 'package:flutter/material.dart';

class TodoDetailsError extends StatelessWidget {
  const TodoDetailsError({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Text('ERROR on Details Page, please try again'),
    );
  }
}
