import 'dart:async';
import 'dart:ffi';
import 'dart:ui';

import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/models/ar_anchor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/datatypes/hittest_result_types.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:ar_flutter_plugin/models/ar_hittest_result.dart';
import 'package:sqflite/utils/utils.dart';
import 'package:vector_math/vector_math_64.dart' as a;
import 'package:sensors_plus/sensors_plus.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:vibration/vibration.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';


class ObjectGesturesWidget extends StatefulWidget {
  ObjectGesturesWidget({Key? key}) : super(key: key);
  @override
  _ObjectGesturesWidgetState createState() => _ObjectGesturesWidgetState();
}

class _ObjectGesturesWidgetState extends State<ObjectGesturesWidget> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARAnchorManager? arAnchorManager;

  List<ARNode> nodes = [];
  List<ARAnchor> anchors = [];

  double? x = 3;
  double? y = 3;
  double? z = 3;
  var scale = 1;
  List<StreamSubscription<dynamic>> _streamSubscriptions =
  <StreamSubscription<dynamic>>[];

  @override
  void dispose() {
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
    super.dispose();
    arSessionManager!.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 5, color: (x!>-3 && x!<3 && y!>-3 && y!<3 && z!>5) ? Color(0xFF32DE8A) : Colors.red)
            ),
            child: Stack(children: [
              ARView(
                onARViewCreated: onARViewCreated,
                planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
              ),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: onTakeScreenshot,
                          child: const Icon(Icons.camera, color: Colors.white),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: (x!>-3 && x!<3 && y!>-3 && y!<3 && z!>5) ? Color(0xFF32DE8A) : Colors.red),
                    )
                    ]),

              ),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: onScale,
                        child: (scale == 1) ? Text("1m\u00b2") : Text("2m\u00b2"),
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: (x!>-3 && x!<3 && y!>-3 && y!<3 && z!>5) ? Color(0xFF32DE8A) : Colors.red),
                      )
                    ]),

              )
            ])));
  }

  void onARViewCreated(
      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      ARLocationManager arLocationManager) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;
    this.arAnchorManager = arAnchorManager;

    this.arSessionManager!.onInitialize(
      showAnimatedGuide: false,
      showFeaturePoints: false,
      showPlanes: false,
      //customPlaneTexturePath: "Images/triangle.png",
      showWorldOrigin: false,
      handlePans: true,
      handleRotation: true,

    );
    this.arObjectManager!.onInitialize();

    this.arSessionManager!.onPlaneOrPointTap = onPlaneOrPointTapped;
    this.arObjectManager!.onPanStart = onPanStarted;
    this.arObjectManager!.onPanChange = onPanChanged;
    this.arObjectManager!.onPanEnd = onPanEnded;
    this.arObjectManager!.onRotationStart = onRotationStarted;
    this.arObjectManager!.onRotationChange = onRotationChanged;
    this.arObjectManager!.onRotationEnd = onRotationEnded;


    _streamSubscriptions
        .add(accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        x = event.x;
        y = event.y;
        z = event.z;
        if(x!>-3 && x!<3 && y!>-3 && y!<3 && z!>5){
        }
        else{
          Vibration.vibrate(amplitude: 20);
        }
      });
    }));
  }

  Future<void> onRemoveEverything() async {
    /*nodes.forEach((node) {
      this.arObjectManager.removeNode(node);
    });*/
    anchors.forEach((anchor) {
      this.arAnchorManager!.removeAnchor(anchor);
    });
    anchors = [];
  }

  Future<void> onScale() async {
    /*nodes.forEach((node) {
      this.arObjectManager.removeNode(node);
    });*/
    anchors.forEach((anchor) {
      this.arAnchorManager!.removeAnchor(anchor);
    });
    anchors = [];

    setState(() {
      if (scale == 1){
        scale = 2;
      }
      else {
        scale = 1;
      }
    });
  }

  Future<void> onPlaneOrPointTapped(
      List<ARHitTestResult> hitTestResults) async {
    var singleHitTestResult = hitTestResults.firstWhere(
            (hitTestResult) => hitTestResult.type == ARHitTestResultType.plane);
    var newAnchor =
    ARPlaneAnchor(transformation: singleHitTestResult.worldTransform);
    bool? didAddAnchor = await this.arAnchorManager!.addAnchor(newAnchor);
    if (didAddAnchor!) {
      this.anchors.add(newAnchor);
      // Add note to anchor
      var newNode = ARNode(
          type: NodeType.webGLB,
          uri:
          "https://github.com/Mitagki/gltf/raw/main/border2.glb",
          scale: (scale == 1) ? a.Vector3(0.5, 0.5, 0.5) : a.Vector3(0.7, 0.7, 0.7),
          position: a.Vector3(0.0, 0.0, 0.0),
          rotation: a.Vector4(1.0, 0.0, 0.0, 0.0));
      bool? didAddNodeToAnchor =
      await this.arObjectManager!.addNode(newNode, planeAnchor: newAnchor);
      if (didAddNodeToAnchor!) {
        this.nodes.add(newNode);
        //double a = this.arSessionManager!.getDistanceFromAnchor(newAnchor) as double;

      } else {
        this.arSessionManager!.onError("Adding Node to Anchor failed");
      }
    } else {
      this.arSessionManager!.onError("Adding Anchor failed");
    }
  }

  onPanStarted(String nodeName) {
    print("Started panning node " + nodeName);
  }

  onPanChanged(String nodeName) {
    print("Continued panning node " + nodeName);
  }

  onPanEnded(String nodeName, Matrix4 newTransform) {
    print("Ended panning node " + nodeName);
    final pannedNode =
    this.nodes.firstWhere((element) => element.name == nodeName);

    /*
    * Uncomment the following command if you want to keep the transformations of the Flutter representations of the nodes up to date
    * (e.g. if you intend to share the nodes through the cloud)
    */
    //pannedNode.transform = newTransform;
  }

  onRotationStarted(String nodeName) {
    print("Started rotating node " + nodeName);
  }

  onRotationChanged(String nodeName) {
    print("Continued rotating node " + nodeName);
  }

  onRotationEnded(String nodeName, Matrix4 newTransform) {
    print("Ended rotating node " + nodeName);
    final rotatedNode =
    this.nodes.firstWhere((element) => element.name == nodeName);

    /*
    * Uncomment the following command if you want to keep the transformations of the Flutter representations of the nodes up to date
    * (e.g. if you intend to share the nodes through the cloud)
    */
    //rotatedNode.transform = newTransform;
  }
  Future<File> imageProviderToFile(ImageProvider imageProvider, String fileName) async {
    // Load the image from the ImageProvider
    final ImageStream stream = imageProvider.resolve(ImageConfiguration.empty);
    final Completer<File> completer = Completer<File>();

    // Listen for the completion of loading the image
    stream.addListener(ImageStreamListener((ImageInfo imageInfo, bool synchronousCall) async {
      // Get the raw image data as ByteData
      final ByteData? byteData = await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData != null) {
        // Convert ByteData to Uint8List
        final Uint8List uint8List = byteData.buffer.asUint8List();

        // Get the application directory for storing the file
        final directory = await getApplicationDocumentsDirectory();

        // Create a file with the given file name in the directory
        final File file = File('${directory.path}/$fileName');

        // Write the image data to the file
        await file.writeAsBytes(uint8List);
        completer.complete(file);
      }
    }));

    return completer.future;
  }
  Future<Uint8List?> imageProviderToUint8List(ImageProvider imageProvider) async {
    // Resolve the image using the ImageConfiguration
    ImageStream stream = imageProvider.resolve(ImageConfiguration.empty);
    Completer<Uint8List> completer = Completer<Uint8List>();

    // Listen to the image stream and convert it to Uint8List
    stream.addListener(ImageStreamListener((ImageInfo imageInfo, _) async {
      ByteData? byteData = await imageInfo.image.toByteData(format: ImageByteFormat.png);
      if (byteData != null) {
        Uint8List uint8List = byteData.buffer.asUint8List();
        completer.complete(uint8List);
      } else {
        completer.completeError('Failed to convert image to Uint8List');
      }
    }, onError: (dynamic error, StackTrace? stackTrace) {
      completer.completeError('Error loading image: $error');
    }));

    try {
      return await completer.future;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<void> onTakeScreenshot() async {
    var save = false;
    if(x!>-3 && x!<3 && y!>-3 && y!<3 && z!>5){
      var image = await arSessionManager!.snapshot();
      showDialog(
          context: context,
          builder: (_) => Dialog(
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(image: image, fit: BoxFit.cover)),
            ),
          ));
      String fileName = 'image.png';
      File imageFile = await imageProviderToFile(image, fileName);
      final inputImage = InputImage.fromFile(imageFile);
      ImageLabeler _imageLabeler;
      _imageLabeler = ImageLabeler(options: ImageLabelerOptions());
      final labels = await _imageLabeler.processImage(inputImage);
      String text = 'Labels found: ${labels.length}\n\n';
      for (final label in labels) {
        if(label.label == "Plant" && label.confidence > 0.5){
          save = true;
        }
        text += 'Label: ${label.label}, '
            'Confidence: ${label.confidence.toStringAsFixed(2)}\n\n';
      }
      String? _text;
      _text = text;





      showDialog(
          context: context,
          builder: (context) {
            return  AlertDialog(
              content: Text(
                  _text!),
            );
          });
      if (save == true){
      ImageGallerySaver.saveImage(imageFile.readAsBytesSync());}
    }
    else{
      //Vibration.vibrate();
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Invalid device position'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    'assets/images/istockphoto-1284272326-612x612.jpg', // Replace with your image path
                    width: 150, // Adjust image width as needed
                  ),
                  SizedBox(height: 16), // Adjust spacing as needed
                  Text('Keep device flat with camera facing towards the ground.'),
                ],
              ),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the AlertDialog
                  },
                  child: Text('Close'),
                ),
              ],
            ); AlertDialog(
              title: Text("Invalid device position"),
              content: Text(
                  "Keep device flat with camera facing towards the ground"),
            );
          });
    }
  }
}