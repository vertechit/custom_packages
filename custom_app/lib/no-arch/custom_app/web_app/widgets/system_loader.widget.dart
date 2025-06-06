import 'package:custom_app/lib.imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../custom_app.imports.dart';
import '../web_app.imports.dart';

///[ Descricao: Widget responsavel por carregar o sistema, realizando todas as medições de dimensões e salvando essas informações localmente ]

class SystemLoader extends StatefulWidget {
  Widget child;
  SystemLoader({
    required this.child,
  });
  @override
  _SystemLoaderState createState() => _SystemLoaderState();
}

class _SystemLoaderState extends State<SystemLoader> {
  double cabecHeight = 0;
  bool redirected = false;

  Future<double> setPageAreaHeight(w, h) async {
    double appBarHeight = AppBar().preferredSize.height;

    print("APP BAR SIZE " + appBarHeight.toString());

    double realHeight = (h * 100) - appBarHeight;

    print("************ 22222222222 SIZE: " + cabecHeight.toString());

    double areaHeight = (realHeight - cabecHeight) - 22;

    WebAppConfig.instance.appController.pagesHeight = areaHeight;

    return areaHeight;
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / 100;
    double w = MediaQuery.of(context).size.width / 100;

    return Scaffold(
      body: Container(
        width: w * 100,
        height: h * 100,
        child: Stack(
          children: [
            SingleChildScrollView(
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
                    child: Container(
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
                            "------",
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
                              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[300]!.withOpacity(0.4),
                                  spreadRadius: 0.6,
                                  blurRadius: 4,
                                  offset: Offset(0, 0), // changes position of shadow
                                ),
                              ]),
                              child: Padding(
                                padding: EdgeInsets.all(12),
                                child: Text(
                                  "-----",
                                  style: TextStyle(color: Colors.grey[500]),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  ///[============================================= PAGE =============================================]

                  FutureBuilder(
                    future: setPageAreaHeight(w, h),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (redirected == false) {
                          redirected = true;
                          Future.delayed(const Duration(milliseconds: 3000), () async {
                            print("************ REDIRECIONAR !!!!!!!!!!!!!!!!!!!!!!!!!!!!! ");
                            AppNavigation.instance.toRouteReplacement("/system");
                          });
                        }

                        return Container(
                          margin: EdgeInsets.only(top: 10, left: 25, right: 25),
                          color: Colors.white,
                          width: w * 100,
                          height: snapshot.data,
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ),
            Container(
              width: w * 100,
              height: h * 100,
              color: Colors.white,
              child: Center(
                child: Container(
                  width: w * 4.5,
                  height: w * 4.5,
                  child: CircularProgressIndicator(
                      // color: Colors.red,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class WidgetSize extends StatefulWidget {
//   final Widget child;
//   final Function onChange;

//   const WidgetSize({
//     Key key,
//     required this.onChange,
//     required this.child,
//   }) : super(key: key);

//   @override
//   _WidgetSizeState createState() => _WidgetSizeState();
// }

// class _WidgetSizeState extends State<WidgetSize> {
//   @override
//   Widget build(BuildContext context) {
//     SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
//     return Container(
//       key: widgetKey,
//       child: widget.child,
//     );
//   }

//   var widgetKey = GlobalKey();
//   var oldSize;

//   void postFrameCallback(_) {
//     var context = widgetKey.currentContext;
//     if (context == null) return;

//     var newSize = context.size;
//     if (oldSize == newSize) return;

//     oldSize = newSize;
//     widget.onChange(newSize);
//   }
// }
