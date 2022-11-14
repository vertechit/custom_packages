import 'package:flutter/material.dart';

class CleanBody extends StatelessWidget {
  Widget child;
  CleanBody({
    this.child,
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
