import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../web_app.imports.dart';

///==================================================== WebAppWidget ====================================================
abstract class WebAppWidgetRequireds {
  String displayName;

  WebAppModulo modulo;

  Widget buildView(BuildContext context);
}

abstract class WebAppWidget extends StatelessWidget implements WebAppWidgetRequireds {
  @override
  Widget build(BuildContext context) {
    return WebAppPage(
      displayName: displayName,
      children: buildView(context),
      modulo: modulo,
    );
  }
}

///==================================================== WebAppPage ====================================================

class WebAppPage extends StatefulWidget {
  Widget children;
  String displayName;
  WebAppModulo modulo;
  WebAppPage({
    @required this.displayName,
    @required this.children,
    @required this.modulo,
  });
  @override
  _WebAppPageState createState() => _WebAppPageState();
}

class _WebAppPageState extends State<WebAppPage> {
  double cabecHeight = 0;

  double h;
  double w;

  Widget pageHeaderWidget;

  Future futureMethod;

  _WebAppPageState() {
    var point;
  }

  Future<double> setPageAreaHeight() async {
    await Future.delayed(const Duration(milliseconds: 400), () {});

    double appBarHeight = AppBar().preferredSize.height;

    print("APP BAR SIZE " + appBarHeight.toString());

    double realHeight = (WebAppConfig.instance.appController.deviceInfo.screenInfo.height * 100) - appBarHeight;

    print("************ 22222222222 SIZE: " + cabecHeight.toString());

    double areaHeight;

    PageType pageType = widget.modulo.view.type;

    if (pageType == PageType.basic) areaHeight = (realHeight - cabecHeight) - 22;
    if (pageType == PageType.modal) {
      areaHeight = widget.modulo.view.height - cabecHeight;

      var widgetTest = WidgetSize(
        onChange: (Size size) async {
          print("************ 11111111 SIZE: " + size.toString());
        },
        child: Container(
          width: 10,
          height: 10,
        ),
      );

      var point = "";
    }

    return areaHeight;
  }

  @override
  void initState() {
    // TODO: implement initState
    futureMethod = setPageAreaHeight();
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height / 100;
    w = MediaQuery.of(context).size.width / 100;

    PageType pageType = widget.modulo.view.type;

    if (pageType == PageType.basic) pageHeaderWidget = basicPageHeader();
    if (pageType == PageType.modal) pageHeaderWidget = modalPageHeader();

    if (pageType == PageType.modal || pageType == PageType.basic) {
      return Container(
        width: w * 100,
        // height: h * 100,
        color: Colors.transparent,
        child: Column(
          children: [
            ///[============================================= CABEÇALHO =============================================]
            WidgetSize(
              onChange: (Size size) async {
                print("************ 11111111 SIZE: " + size.toString());
                setState(() {
                  cabecHeight = size.height;
                });
              },
              child: pageHeaderWidget,
            ),

            ///[================================================ PAGE ================================================]

            FutureBuilder(
              // future: setPageAreaHeight(w, h),
              future: futureMethod,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    margin: EdgeInsets.only(left: 25, right: 25),
                    // color: Colors.grey,
                    // color: Colors.green,
                    width: w * 100,
                    // height: snapshot.data,
                    // child: SingleChildScrollView(
                    //   child: Column(
                    //     children: [widget.children],
                    //   ),
                    // ),
                    child: ListView(
                      shrinkWrap: true,
                      children: [widget.children],
                    ),
                  );
                } else {
                  return Container();
                }
              },
            )
          ],
        ),
      );
    }
  }

  Widget basicPageHeader() {
    return Container(
      margin: EdgeInsets.only(top: 25, left: 25, right: 25),
      // width: w * 80,
      // color: Colors.grey[200],
      // padding: EdgeI,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //--------------------------- TITULO ------------------------------
          Text(
            widget.displayName,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 32,
            ),
          ),

          //-------------------------- BREADCUMB ----------------------------
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              width: w * 100,
              // height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[300].withOpacity(0.4),
                    spreadRadius: 0.6,
                    blurRadius: 4,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  "home / " + widget.displayName,
                  style: TextStyle(color: Colors.grey[500]),
                ),
              ),
            ),
          ),

          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget modalPageHeader() {
    return Container(
      margin: EdgeInsets.only(
        top: 5,
        // left: 15,
        // right: 15,
      ),
      // width: w * 80,
      // color: Colors.grey[200],
      // padding: EdgeI,
      width: w * 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          //--------------------------- TITULO ------------------------------
          Padding(
            padding: EdgeInsets.only(left: 25),
            child: Text(
              widget.displayName,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 22,
                fontFamily: WebAppConfig.instance.appController.style.fonts.op2,
              ),
            ),
          ),

          SizedBox(height: 6),

          Divider(),

          SizedBox(height: 8),
        ],
      ),
    );
  }
}

///==================================================== WIDGET SIZE ====================================================

class WidgetSize extends StatefulWidget {
  final Widget child;
  final Function onChange;

  const WidgetSize({
    Key key,
    @required this.onChange,
    @required this.child,
  }) : super(key: key);

  @override
  _WidgetSizeState createState() => _WidgetSizeState();
}

class _WidgetSizeState extends State<WidgetSize> {
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
    return Container(
      key: widgetKey,
      child: widget.child,
    );
  }

  var widgetKey = GlobalKey();
  var oldSize;

  void postFrameCallback(_) {
    var context = widgetKey.currentContext;
    if (context == null) return;

    var newSize = context.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    widget.onChange(newSize);
  }
}
