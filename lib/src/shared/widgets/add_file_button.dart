import 'dart:io';

import 'package:flutter/material.dart';

class AddFileButton extends StatelessWidget {
  const AddFileButton({
    super.key,
    required this.onTapAdd,
  });
  final VoidCallback onTapAdd;
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return const SizedBox.shrink();
    }
    return FloatingActionButton(
      onPressed: onTapAdd,
      child: const Icon(Icons.add),
    );
  }
}
