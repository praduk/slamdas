// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as imglib;
import 'src/data.pb.dart' as pb;
import 'package:fixnum/fixnum.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

// Get UNIX UTC Time in Milliseconds
int unix_utc_ms() {
  return DateTime.now().toUtc().millisecondsSinceEpoch;
}

// from https://gist.github.com/Alby-o/fe87e35bc21d534c8220aed7df028e03
imglib.Image convertYUV420ToImage(CameraImage cameraImage) {
  final imageWidth = cameraImage.width;
  final imageHeight = cameraImage.height;

  final yBuffer = cameraImage.planes[0].bytes;
  final uBuffer = cameraImage.planes[1].bytes;
  final vBuffer = cameraImage.planes[2].bytes;

  final int yRowStride = cameraImage.planes[0].bytesPerRow;
  final int yPixelStride = cameraImage.planes[0].bytesPerPixel!;

  final int uvRowStride = cameraImage.planes[1].bytesPerRow;
  final int uvPixelStride = cameraImage.planes[1].bytesPerPixel!;

  // Create the image with swapped width and height to account for rotation
  final image = imglib.Image(width: imageHeight, height: imageWidth);

  for (int h = 0; h < imageHeight; h++) {
    int uvh = (h / 2).floor();

    for (int w = 0; w < imageWidth; w++) {
      int uvw = (w / 2).floor();

      final yIndex = (h * yRowStride) + (w * yPixelStride);

      final int y = yBuffer[yIndex];

      final int uvIndex = (uvh * uvRowStride) + (uvw * uvPixelStride);

      final int u = uBuffer[uvIndex];
      final int v = vBuffer[uvIndex];

      int r = (y + v * 1436 / 1024 - 179).round();
      int g = (y - u * 46549 / 131072 + 44 - v * 93604 / 131072 + 91).round();
      int b = (y + u * 1814 / 1024 - 227).round();

      r = r.clamp(0, 255);
      g = g.clamp(0, 255);
      b = b.clamp(0, 255);

      // Set the pixel with rotated coordinates
      image.setPixelRgb(imageHeight - h - 1, w, r, g, b);
    }
  }

  return image;
}

late List<CameraDescription> cameras;

late String outputPath;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Data Acquisition App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      themeMode: ThemeMode
          .dark, // Can be set to ThemeMode.light, ThemeMode.dark, or ThemeMode.system

      home: const HomePage(title: 'PraduSLAM Data Acquisition App'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<CameraController> controllers;
  late CameraController controller;
  late bool recording;
  pb.Recording rec = pb.Recording();

  late StreamSubscription<GyroscopeEvent> gsub;
  late StreamSubscription<AccelerometerEvent> asub;
  late StreamSubscription<MagnetometerEvent> msub;

  @override
  void initState() {
    super.initState();
    setupCamera(0);
    recording = false;
  }

  void setupCamera(int select) {
    controller = CameraController(
      cameras[select],
      ResolutionPreset.medium,
      enableAudio: false,
    );
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void processImage(CameraImage image) {
    if (!recording) {
      return;
    }

    int timestamp = unix_utc_ms();
    imglib.Image img = convertYUV420ToImage(image);
    rec.camera.add(
      pb.Camera(t: Int64(timestamp), png: imglib.encodePng(img)),
    );

    //print('Processing Image $timestamp ${img.width}x${img.height}\n');
    //setState(() {
    //});
  }

  void processGyro(GyroscopeEvent e) {
    rec.gyro.add(pb.Cartesian(
        t: Int64(e.timestamp.toUtc().millisecondsSinceEpoch),
        x: e.x,
        y: e.y,
        z: e.z));
  }

  void processAccel(AccelerometerEvent e) {
    rec.accel.add(pb.Cartesian(
        t: Int64(e.timestamp.toUtc().millisecondsSinceEpoch),
        x: e.x,
        y: e.y,
        z: e.z));
  }

  void processMag(MagnetometerEvent e) {
    rec.mag.add(pb.Cartesian(
        t: Int64(e.timestamp.toUtc().millisecondsSinceEpoch),
        x: e.x,
        y: e.y,
        z: e.z));
  }

  void record() async {
    rec = pb.Recording();

    // mark recording
    setState(() {
      recording = true;
    });

    // start camera stream
    await controller.startImageStream(processImage);
    msub = SensorsPlatform.instance
        .magnetometerEventStream(samplingPeriod: SensorInterval.fastestInterval)
        .listen(processMag);
    asub = SensorsPlatform.instance
        .accelerometerEventStream(
            samplingPeriod: SensorInterval.fastestInterval)
        .listen(processAccel);
    gsub = SensorsPlatform.instance
        .gyroscopeEventStream(samplingPeriod: SensorInterval.fastestInterval)
        .listen(processGyro);
  }

  void stop() async {
    // stop camera stream
    await controller.stopImageStream();
    msub.cancel();
    asub.cancel();
    gsub.cancel();

    // mark not recording
    setState(() {
      recording = false;
    });

    //write to sd card
    // Request storage permission
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    // Get the external storage directory (public directory)
    Directory? externalDir = await getExternalStorageDirectory();

    if (externalDir != null) {
      // Construct the path to a public folder on the SD card
      //String path = '${externalDir.path}/daq';
      //String path = '/storage/emulated/0/Download/daq';
      String path = '/storage/3963-6363/Download/daq';
      Directory publicDir = Directory(path);

      if (!await publicDir.exists()) {
        await publicDir.create(recursive: true);
      }

      // Write a file to the directory
      File file = File('$path/${unix_utc_ms()}.bin');
      await file.writeAsBytes(rec.writeToBuffer());

      print('File written to ${file.path}');
    } else {
      print('External directory not found');
    }

    rec = pb.Recording();
  }

  Widget getCameraInfo() {
    return Container(
      alignment: Alignment.center,
      height: 50.0, // Adjust the height as needed
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: cameras.length, // Number of items in the list
        itemBuilder: (context, index) {
          return Center(
            child: FilledButton.tonal(
              onPressed: recording
                  ? null
                  : () {
                      setupCamera(index);
                    },
              child: Text(
                cameras[index].name,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getCameraPreview() {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return CameraPreview(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              !recording ? getCameraPreview() : Container(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  getCameraInfo(),
                  const IMUDisplay(),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (recording) {
            stop();
          } else {
            record();
          }
        },
        tooltip: 'Increment',
        child: Icon(
          recording ? Icons.square : Icons.circle,
          color: recording ? Colors.red : null,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class IMUDisplay extends StatefulWidget {
  const IMUDisplay({super.key});

  @override
  State<IMUDisplay> createState() => _IMUDisplayState();
}

class _IMUDisplayState extends State<IMUDisplay> {
  double gx = 0.0;
  double gy = 0.0;
  double gz = 0.0;
  double ax = 0.0;
  double ay = 0.0;
  double az = 0.0;
  double mx = 0.0;
  double my = 0.0;
  double mz = 0.0;

  late StreamSubscription<GyroscopeEvent> gsub;
  late StreamSubscription<AccelerometerEvent> asub;
  late StreamSubscription<MagnetometerEvent> msub;

  @override
  void initState() {
    super.initState();

    // Listen to accelerometer events
    asub = SensorsPlatform.instance
        .accelerometerEventStream(samplingPeriod: SensorInterval.uiInterval)
        .listen((e) {
      setState(() {
        ax = e.x;
        ay = e.y;
        az = e.z;
      });
    });
    gsub = SensorsPlatform.instance
        .gyroscopeEventStream(samplingPeriod: SensorInterval.uiInterval)
        .listen((e) {
      setState(() {
        gx = e.x;
        gy = e.y;
        gz = e.z;
      });
    });
    msub = SensorsPlatform.instance
        .magnetometerEventStream(samplingPeriod: SensorInterval.uiInterval)
        .listen((e) {
      setState(() {
        mx = e.x;
        my = e.y;
        mz = e.z;
      });
    });
  }

  @override
  void dispose() {
    asub.cancel();
    gsub.cancel();
    msub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var style = const TextStyle(
        color: Colors.black,
        backgroundColor: Color.fromARGB(122, 255, 255, 255));
    return Container(
      padding: const EdgeInsets.all(5.0),
      child: Table(
        columnWidths: const <int, TableColumnWidth>{
          0: IntrinsicColumnWidth(),
          1: FlexColumnWidth(1.0),
          2: FlexColumnWidth(1.0),
          3: FlexColumnWidth(1.0),
        },
        children: <TableRow>[
          TableRow(children: [
            Text('Axis', style: style, textAlign: TextAlign.right),
            Text('X', style: style, textAlign: TextAlign.right),
            Text('Y', style: style, textAlign: TextAlign.right),
            Text('Z', style: style, textAlign: TextAlign.right),
          ]),
          TableRow(children: [
            Text('Gyro (rad/s)', style: style, textAlign: TextAlign.right),
            Text(gx.toStringAsFixed(8),
                style: style, textAlign: TextAlign.right),
            Text(gy.toStringAsFixed(8),
                style: style, textAlign: TextAlign.right),
            Text(gz.toStringAsFixed(8),
                style: style, textAlign: TextAlign.right),
          ]),
          TableRow(children: [
            Text('Accel (m/s2)', style: style, textAlign: TextAlign.right),
            Text(ax.toStringAsFixed(8),
                style: style, textAlign: TextAlign.right),
            Text(ay.toStringAsFixed(8),
                style: style, textAlign: TextAlign.right),
            Text(az.toStringAsFixed(8),
                style: style, textAlign: TextAlign.right),
          ]),
          TableRow(children: [
            Text('Mag (uT)', style: style, textAlign: TextAlign.right),
            Text(mx.toStringAsFixed(8),
                style: style, textAlign: TextAlign.right),
            Text(my.toStringAsFixed(8),
                style: style, textAlign: TextAlign.right),
            Text(mz.toStringAsFixed(8),
                style: style, textAlign: TextAlign.right),
          ]),
        ],
      ),
    );
  }
}
