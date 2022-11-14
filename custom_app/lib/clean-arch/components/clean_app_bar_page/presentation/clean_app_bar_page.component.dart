import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:custom_app/lib.imports.dart';
import 'package:custom_components/app_bars/app_bars.imports.dart';

class CleanAppBarPage extends StatelessWidget {
  Widget body;

  CleanAppBarData cleanAppBarData;
  bool centerList = false;

  Future Function() onClickFloatButton;
  Future Function() onClickRightButton;

  bool showFloatButton = false;

  CleanAppBarPage({
    this.cleanAppBarData,
    this.body,
    this.centerList,
    this.onClickFloatButton,
    this.onClickRightButton,
    this.showFloatButton = false,
  });

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height / 100;
    var w = MediaQuery.of(context).size.width / 100;

    if (body == null) {
      body = SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Column(
              children: [],
            );
          },
          childCount: 1,
        ),
      );
    }

    return Scaffold(
      // backgroundColor: CustomAppConfig.instance.appController.style.colors.bg1,
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
        sized: false,
        child: CustomScrollView(
          // physics: NeverScrollableScrollPhysics(),
          slivers: <Widget>[
            ///[============================== APP BAR ===============================]
            ///

            CleanAppBar(
              cleanAppBarData: cleanAppBarData,
              onClickRightButton: onClickRightButton,
            ),

            ///[================================ BODY ================================]

            body,
          ],
        ),
      ),

      ///[================================ FLOAT BUTTON ================================]

      floatingActionButton: showFloatButton
          ? Container(
              margin: EdgeInsets.only(bottom: h * 10),
              child: FloatingActionButton(
                heroTag: "btn1",
                backgroundColor: Color(0xFF01579B),
                onPressed: onClickFloatButton,
                // onPressed: () {
                //   moduleController.startRegistrarPonto();
                // },
                child: Icon(
                  Icons.alarm_add,
                  color: Colors.white,
                ),
              ),
            )
          : null,
    );
  }
}
