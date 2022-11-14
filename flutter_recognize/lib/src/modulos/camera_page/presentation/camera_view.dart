import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
// import 'package:image_picker/image_picker.dart';

import '../../../src.imports.dart';

// import '../main.dart';

enum ScreenMode { liveFeed, gallery }

class CameraView extends StatefulWidget {
  CameraView({
    Key key,
    @required this.title,
    @required this.customPaint,
    this.text,
    @required this.onImage,
    this.initialDirection = CameraLensDirection.back,
    @required this.controlWidget,
    this.header,
    this.cameraFrame,
    this.showDefaultAppBar = false,
    this.defaultAppbarText = "",
  }) : super(key: key);

  final String title;

  // final CustomPaint customPaint;
  RxList<CustomPaint> customPaint;

  final String text;
  final Function({InputImage inputImage, CameraImage image}) onImage;
  final CameraLensDirection initialDirection;
  Widget controlWidget;
  CameraController cameraController;
  AppBar header;
  Widget Function(Widget child) cameraFrame;
  bool showDefaultAppBar = false;
  String defaultAppbarText = "";

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  ScreenMode _mode = ScreenMode.liveFeed;
  CameraController _controller;

  File _image;
  String _path;
  // ImagePicker _imagePicker;
  int _cameraIndex = 0;
  double zoomLevel = 0.0, minZoomLevel = 0.0, maxZoomLevel = 0.0;
  final bool _allowPicker = true;
  bool _changingCameraLens = false;
  CameraImage cameraImage;

  @override
  void initState() {
    super.initState();

    // _imagePicker = ImagePicker();

    if (cameras.any(
      (element) => element.lensDirection == widget.initialDirection && element.sensorOrientation == 90,
    )) {
      _cameraIndex = cameras.indexOf(
        cameras.firstWhere((element) => element.lensDirection == widget.initialDirection && element.sensorOrientation == 90),
      );
    } else {
      _cameraIndex = cameras.indexOf(
        cameras.firstWhere(
          (element) => element.lensDirection == widget.initialDirection,
        ),
      );
    }

    _startLiveFeed();
  }

  @override
  void dispose() {
    _stopLiveFeed();
    super.dispose();
  }

  Widget defaultCameraFrame(Widget child) {
    final w = MediaQuery.of(Get.context).size.width / 100;
    final h = MediaQuery.of(Get.context).size.height / 100;
    return Container(
      width: w * 100,
      height: h * 100,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width / 100;
    final h = MediaQuery.of(context).size.height / 100;

    return WillPopScope(
      onWillPop: () async {
        print("FlutterRecognize - CameraView - Back buttom pressionado!!!! ");
        return false;
      },
      child: Scaffold(
        appBar: widget.showDefaultAppBar
            ? AppBar(
                backgroundColor: Color(0xFF01579B),
                title: Text(
                  widget.defaultAppbarText,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                leading: Container(
                  margin: EdgeInsets.only(left: w * 5.2),
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
                actions: [
                  //-------------- TROCAR RESOLUCAO -------------
                  // GestureDetector(
                  //   onTap: () {
                  //     changeResolution();
                  //   },
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(right: 18, top: 8, bottom: 8),
                  //     child: Container(
                  //       color: Colors.blue[600],
                  //       padding: EdgeInsets.all(6),
                  //       child: Column(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         children: [
                  //           SizedBox(height: 1.3),
                  //           Text(
                  //             "Resolução: " + atualResolution,
                  //             style: TextStyle(color: Colors.white, fontSize: 12),
                  //           ),
                  //           Text(
                  //             "Clique pra trocar",
                  //             style: TextStyle(color: Colors.grey[300], fontSize: 10),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  //-------------- INVERTER CAMERA -------------
                  GestureDetector(
                    onTap: () {
                      _switchLiveCamera();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Platform.isIOS ? Icons.flip_camera_ios_outlined : Icons.flip_camera_android_outlined,
                            size: 27,
                            color: Colors.white,
                          ),
                          const Text(
                            "Inverter",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : null,
        body: Stack(
          children: [
            widget.cameraFrame != null ? widget.cameraFrame(_body()) : defaultCameraFrame(_body()),

            //--- CONTROL WIDGET ---
            widget.controlWidget,
            // Container(
            //   width: w * 100,
            //   height: h * 100,
            //   child: _body(),
            // ),
            // Container(
            //   width: w * 100,
            //   height: h * 8,
            //   child: widget.header,
            // ),
          ],
        ),
      ),
      // floatingActionButton: _floatingActionButton(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _floatingActionButton() {
    if (_mode == ScreenMode.gallery) return null;
    if (cameras.length == 1) return null;
    return SizedBox(
        height: 70.0,
        width: 70.0,
        child: FloatingActionButton(
          child: Icon(
            Platform.isIOS ? Icons.flip_camera_ios_outlined : Icons.flip_camera_android_outlined,
            size: 40,
          ),
          onPressed: _switchLiveCamera,
        ));
  }

  Widget _body() {
    Widget body;
    if (_mode == ScreenMode.liveFeed) {
      body = _liveFeedBody();
    } else {
      // body = _galleryBody();
      body = Container();
    }
    return body;
  }

  Widget _liveFeedBody() {
    if (_controller?.value.isInitialized == false) {
      return Container();
    }

    final size = MediaQuery.of(context).size;
    // calculate scale depending on screen and camera ratios
    // this is actually size.aspectRatio / (1 / camera.aspectRatio)
    // because camera preview size is received as landscape
    // but we're calculating for portrait orientation
    var scale = size.aspectRatio * _controller.value.aspectRatio;

    // to prevent scaling down, invert the value
    if (scale < 1) scale = 1 / scale;

    return Container(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Transform.scale(
            scale: scale,
            child: Center(
              child: _changingCameraLens
                  ? const Center(
                      child: const Text('Changing camera lens'),
                    )
                  : CameraPreview(_controller),
            ),
          ),

          //---- CUSTOM PAINT ----

          Obx(() {
            if (widget.customPaint.isNotEmpty) {
              return widget.customPaint.last;
            }
            return Container();
          }),

          // Positioned(
          //   bottom: 100,
          //   left: 50,
          //   right: 50,
          //   child: Slider(
          //     value: zoomLevel,
          //     min: minZoomLevel,
          //     max: maxZoomLevel,
          //     onChanged: (newSliderValue) {
          //       setState(() {
          //         zoomLevel = newSliderValue;
          //         _controller!.setZoomLevel(zoomLevel);
          //       });
          //     },
          //     divisions: (maxZoomLevel - 1).toInt() < 1 ? null : (maxZoomLevel - 1).toInt(),
          //   ),
          // )
        ],
      ),
    );
  }

  // Widget _galleryBody() {
  //   return ListView(shrinkWrap: true, children: [
  //     _image != null
  //         ? SizedBox(
  //             height: 400,
  //             width: 400,
  //             child: Stack(
  //               fit: StackFit.expand,
  //               children: <Widget>[
  //                 Image.file(_image),
  //                 if (widget.customPaint != null) widget.customPaint,
  //               ],
  //             ),
  //           )
  //         : Icon(
  //             Icons.image,
  //             size: 200,
  //           ),
  //     Padding(
  //       padding: EdgeInsets.symmetric(horizontal: 16),
  //       child: ElevatedButton(
  //         child: Text('From Gallery'),
  //         onPressed: () => _getImage(ImageSource.gallery),
  //       ),
  //     ),
  //     Padding(
  //       padding: EdgeInsets.symmetric(horizontal: 16),
  //       child: ElevatedButton(
  //         child: Text('Take a picture'),
  //         onPressed: () => _getImage(ImageSource.camera),
  //       ),
  //     ),
  //     if (_image != null)
  //       Padding(
  //         padding: const EdgeInsets.all(16.0),
  //         child: Text('${_path == null ? '' : 'Image path: $_path'}\n\n${widget.text ?? ''}'),
  //       ),
  //   ]);
  // }

  // Future _getImage(ImageSource source) async {
  Future _getImage(source) async {
    // setState(() {
    //   _image = null;
    //   _path = null;
    // });
    // final pickedFile = await _imagePicker?.pickImage(source: source);
    // if (pickedFile != null) {
    //   _processPickedFile(pickedFile);
    // }
    // setState(() {});
  }

  void _switchScreenMode() {
    _image = null;
    if (_mode == ScreenMode.liveFeed) {
      _mode = ScreenMode.gallery;
      _stopLiveFeed();
    } else {
      _mode = ScreenMode.liveFeed;
      _startLiveFeed();
    }
    setState(() {});
  }

  ResolutionPreset finalResolution;

  Future _startLiveFeed({ResolutionPreset resolution}) async {
    final camera = cameras[_cameraIndex];

    if (resolution == null) {
      finalResolution = ResolutionPreset.low;
    } else {
      finalResolution = resolution;
    }

    _controller = CameraController(
      camera,
      // ResolutionPreset.high,
      // ResolutionPreset.low,
      // ResolutionPreset.medium,
      finalResolution,
      enableAudio: false,
    );
    widget.cameraController = _controller;
    _controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      _controller?.getMinZoomLevel().then((value) {
        zoomLevel = value;
        minZoomLevel = value;
      });
      _controller?.getMaxZoomLevel().then((value) {
        maxZoomLevel = value;
      });
      _controller?.startImageStream(_processCameraImage);
      setState(() {});
    });
  }

  String atualResolution = "low";

  Future changeResolution() async {
    setState(() => _changingCameraLens = true);
    ResolutionPreset newResolution;
    if (finalResolution == ResolutionPreset.low) {
      newResolution = ResolutionPreset.medium;
      setState(() {
        atualResolution = "medium";
      });
    } else if (finalResolution == ResolutionPreset.medium) {
      newResolution = ResolutionPreset.high;
      setState(() {
        atualResolution = "high";
      });
    } else if (finalResolution == ResolutionPreset.high) {
      newResolution = ResolutionPreset.ultraHigh;
      setState(() {
        atualResolution = "ultraHigh";
      });
    } else if (finalResolution == ResolutionPreset.ultraHigh) {
      newResolution = ResolutionPreset.low;
      setState(() {
        atualResolution = "low";
      });
    }
    await _stopLiveFeed();
    await _startLiveFeed(resolution: newResolution);
    setState(() => _changingCameraLens = false);
  }

  Future _stopLiveFeed() async {
    await _controller?.stopImageStream();
    await _controller?.dispose();
    _controller = null;
  }

  Future _switchLiveCamera() async {
    setState(() => _changingCameraLens = true);
    _cameraIndex = (_cameraIndex + 1) % cameras.length;

    await _stopLiveFeed();
    await _startLiveFeed();
    setState(() => _changingCameraLens = false);
  }

  Future _processPickedFile(XFile pickedFile) async {
    final path = pickedFile?.path;
    if (path == null) {
      return;
    }
    setState(() {
      _image = File(path);
    });
    _path = path;
    final inputImage = InputImage.fromFilePath(path);
    widget.onImage(inputImage: inputImage, image: cameraImage);
  }

  Future _processCameraImage(CameraImage image) async {
    // print("#################  _processCameraImage()");
    this.cameraImage = image;
    final WriteBuffer allBytes = WriteBuffer();
    for (final Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize = Size(image.width.toDouble(), image.height.toDouble());

    final camera = cameras[_cameraIndex];
    final imageRotation = InputImageRotationValue.fromRawValue(camera.sensorOrientation) ?? InputImageRotation.rotation0deg;

    final inputImageFormat = InputImageFormatValue.fromRawValue(image.format.raw) ?? InputImageFormat.nv21;

    final planeData = image.planes.map(
      (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );

    final inputImage = InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);

    widget.onImage(image: cameraImage, inputImage: inputImage);
  }
}
