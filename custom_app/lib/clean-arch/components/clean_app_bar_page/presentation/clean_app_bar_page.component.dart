import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:custom_components/app_bars/app_bars.imports.dart';
import 'dart:async';

class CleanAppBarPage extends StatelessWidget {
  final Widget? body;
  final CleanAppBarData cleanAppBarData;
  final bool centerList;
  final Future<dynamic> Function() onClickFloatButton;
  final Future<dynamic> Function() onClickRightButton;
  final bool showFloatButton;

  const CleanAppBarPage({
    required this.cleanAppBarData,
    this.body,
    this.centerList = false,
    required this.onClickFloatButton,
    required this.onClickRightButton,
    this.showFloatButton = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height / 100;

    final Widget resolvedBody = body ??
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Column(children: []);
            },
            childCount: 1,
          ),
        );

    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
        sized: false,
        child: CustomScrollView(
          slivers: <Widget>[
            CleanAppBar(
              cleanAppBarData: cleanAppBarData,
              onClickRightButton: onClickRightButton,
            ),
            resolvedBody,
          ],
        ),
      ),
      floatingActionButton: showFloatButton && onClickFloatButton != null
          ? Container(
              margin: EdgeInsets.only(bottom: h * 10),
              child: FloatingActionButton(
                heroTag: "btn1",
                backgroundColor: const Color(0xFF01579B),
                onPressed: onClickFloatButton,
                child: const Icon(
                  Icons.alarm_add,
                  color: Colors.white,
                ),
              ),
            )
          : null,
    );
  }
}
