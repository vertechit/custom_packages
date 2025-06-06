import 'package:custom_app/no-arch/no-arch.imports.dart';
import 'package:flutter/material.dart';

class CleanAppBarData {
  String? title;
  CleanAppBarLayout? layout;
  CleanAppBarData({
    this.title,
    this.layout,
  }) {
    if (layout == null) layout = CleanAppBarLayout();
  }
}

/* [--------------------------------------------------  */
class CleanAppBarLayout {
  bool? activeRightButtonCollapsed;
  Widget? rightButtonColapsed;
  bool activeBackButton;

  CleanAppBarLayout({
    this.activeRightButtonCollapsed = false,
    this.rightButtonColapsed,
    this.activeBackButton = false,
  }) {
    if (activeRightButtonCollapsed == null) activeRightButtonCollapsed = false;
    if (activeBackButton == null) activeBackButton = false;
  }
}

/* [- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  */
/* [- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  */
/* [- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  */

class CleanAppBar extends StatelessWidget {
  String title = "Title";
  var bgColor = Colors.white;
  double heightBar = 80;

  double btnSizeProp = 8.5;

  CleanAppBarData cleanAppBarData;

  Future Function() onClickRightButton;

  ///[Botão exibido quando o appbar estiver minimizado, localizado na esquerda]
  late Widget rightButtonSmall;

  CleanAppBar({
    required this.cleanAppBarData,
    required this.onClickRightButton,
  }) {
    if (cleanAppBarData.title != null) title = cleanAppBarData.title!;
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height / 100;
    var w = MediaQuery.of(context).size.width / 100;

    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: h * 16.5,
      // expandedHeight: 100,
      // floating: true,
      primary: true,
      pinned: true,
      backgroundColor: Colors.white,
      shadowColor: Colors.white,
      centerTitle: true,

      /* [-------------------------------------------------------------- SMALL APPBAR --------------------------------------------------------------  */

      //---------------------------------- TITULO ----------------------------------

      title: SABT(
        child: Container(
          child: Text(
            title,
            style: TextStyle(color: Colors.black, fontFamily: CustomAppConfig.instance.appController.style.fonts!.op3, fontWeight: FontWeight.w800),
          ),
        ),
      ),

      //---------------------------------- BOTOES ----------------------------------

      actions: [
        cleanAppBarData.layout!.activeRightButtonCollapsed!
            ? SABT(
                child: Center(
                  child: GestureDetector(
                    onTap: onClickRightButton,
                    child: Container(
                      width: w * 8,
                      height: w * 8,
                      // color: Colors.grey,
                      child: Center(
                        child: Icon(
                          Icons.qr_code_scanner,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : Container(),
        SizedBox(width: w * 5),
      ],

      /* [--------------------------------------------------------------- LARGE APPBAR --------------------------------------------------------------  */

      flexibleSpace: FlexibleSpaceBar(
        // title:
        centerTitle: true,
        // collapseMode: ,
        background: Container(
          margin: EdgeInsets.only(bottom: h * 0, left: w * 4.8, top: h * 7.2),
          // color: Colors.red,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //------------------------------- BACK BUTTON -------------------------------

              cleanAppBarData.layout!.activeBackButton
                  ? Padding(
                      padding: EdgeInsets.only(bottom: 8, left: 4),
                      child: Icon(
                        Icons.arrow_back,
                        size: 30,
                      ),
                    )
                  : Container(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //

                  Padding(
                    padding: EdgeInsets.only(left: w * 2.2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //------------------------------- TITULO -------------------------------
                        Text(
                          title,
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontWeight: FontWeight.w900,
                            fontSize: w * 7.8,
                            fontFamily: CustomAppConfig.instance.appController.style.fonts!.op1,
                          ),
                        ),
                        //------------------------------ Sub Titulo ------------------------------
                        SizedBox(height: h * 1.1),
                        Text(
                          "Batidas registradas hoje",
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontWeight: FontWeight.w500,
                            fontSize: w * 4.7,
                            fontFamily: CustomAppConfig.instance.appController.style.fonts!.op1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: w * 5.5,
                  ),

                  //------------------------------- BOTOES -------------------------------

                  GestureDetector(
                    onTap: onClickRightButton,
                    child: Container(
                      width: w * 10,
                      height: w * 10,
                      margin: EdgeInsets.only(right: w * 5.8, top: h * 0.5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5.2)),
                        border: Border.all(
                          color: Colors.grey[200]!,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[200]!,
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(1.4, 1.4), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(Icons.qr_code, color: Colors.grey[400], size: w * 7),
                      ),
                    ),
                  ),
                  //

                  //
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SABT extends StatefulWidget {
  final Widget child;
  const SABT({
    Key? key,
    required this.child,
  }) : super(key: key);
  @override
  _SABTState createState() {
    return new _SABTState();
  }
}

class _SABTState extends State<SABT> {
  ScrollPosition? _position;
  bool? _visible;
  @override
  void dispose() {
    _removeListener();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _removeListener();
    _addListener();
  }

  void _addListener() {
    _position = Scrollable.of(context)?.position;
    _position?.addListener(_positionListener);
    _positionListener();
  }

  void _removeListener() {
    _position?.removeListener(_positionListener);
  }

  void _positionListener() {
    final FlexibleSpaceBarSettings settings = context.dependOnInheritedWidgetOfExactType()!;
    bool visible = settings == null || settings.currentExtent <= settings.minExtent;
    if (_visible != visible) {
      setState(() {
        _visible = visible;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _visible!,
      child: widget.child,
    );
  }
}
