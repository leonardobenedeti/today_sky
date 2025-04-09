import 'package:flutter/material.dart';

class LoadingSkyWidget extends StatelessWidget {
  const LoadingSkyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
