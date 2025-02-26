import 'package:flutter/material.dart';

class TodoDetailsLoading extends StatelessWidget {
  const TodoDetailsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
