import 'package:flutter/material.dart';

class CleanBody extends StatelessWidget {
  final Widget child;
  const CleanBody({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return child;
        },
        childCount: 1,
      ),
    );
  }
}
