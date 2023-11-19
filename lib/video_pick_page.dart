import 'dart:io';
import 'dart:typed_data';

import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/session_state.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';
class VideoPickerPage extends StatefulWidget {
  @override
  _VideoPickerPageState createState() => _VideoPickerPageState();
}

class _VideoPickerPageState extends State<VideoPickerPage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _video;
  String _ffmpegOutput = '';
  late Interpreter tfliteInterpreter;
  List _results = [];
  // @override
  // void initState()
  // {
  //   loadTFLiteModel();
  // }
  Future<void> _pickVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    setState(() {
      _video = video;
      _runFFmpegCommand(video!.path);
    });

  }
  // Load the TFLite model
  void loadTFLiteModel() async {

  }
  void _runFFmpegCommand(String videoPath) async {
    print("videoPath: " + videoPath);

    // 예시: 동영상을 MP4 형식으로 변환하는 명령어
    // 'inputPath'는 동영상 파일의 경로, 'outputPath'는 출력 파일의 경로
    String outputPath = "/storage/emulated/0/Download";
    String command = "-i $videoPath -vf scale=64:64 -q:v 1 -r 50/10 $outputPath/frame_%03d.jpg";

    await FFmpegKit.execute(command).then((session) async {
      final state = await session.getState();
      final returnCode = await session.getReturnCode();

      if (state == SessionState.completed && returnCode?.isValueSuccess() == true) {
        setState(() {

          _ffmpegOutput = '변환 성공: $outputPath';

        });
        predictImage();
      } else {
        setState(() {
          _ffmpegOutput = '변환 실패';
        });
      }
    });

  }
  void predictImage() async
  {
    final tfliteInterpreter = await Interpreter.fromAsset('assets/model.tflite');
    print("Tensorflow is Running-----------------");
    print("${tfliteInterpreter.getInputTensor(0).shape}");
    List<String> imagePaths = List.generate(50, (i) => "/storage/emulated/0/Download/frame_${(i+1).toString().padLeft(3, '0')}.jpg");
    List<Uint32List> imgList = [];
    for (String path in imagePaths) {
      var image = img.decodeImage(File(path).readAsBytesSync());

      if (image != null) {// 모델에 맞는 크기로 조정하세요
        image = img.copyResize(image, width: 64, height: 64);

        // 이미지를 모델의 입력 형태에 맞게 변환
        var input = _transformImageForModel(image);
        // var input = _imageToByteListFloat32(image, 64,64 ,255); // 입력 형식에 맞추어 조정하세요
        // var input = tfliteInterpreter.getInputTensors(0);
        // var output = List.filled(64*64, 0).reshape([64,64]); // 출력 형식에 맞추어 조정하세요
        imgList.add(input);
      }
    }
    var output = List.filled(1 * 50 * 64 * 64 * 3, 0).reshape([1, 50, 64, 64, 3]);
    tfliteInterpreter.run(imgList, output);
    print("@@------${output}--------");
    setState(() {
      _results = output;
    });

    print("Predict: Result : ${_results}");
  }
  Uint32List _transformImageForModel(img.Image image) {
    // 이미지를 Float32List로 변환
    var convertedBytes = Float32List(1 * 50 * 64 * 64 * 3);
    var buffer = Float32List.view(convertedBytes.buffer);

    int pixelIndex = 0;
    for (int i = 0; i < 50; i++) { // 50개의 이미지 시퀀스를 생성합니다.
      for (int y = 0; y < 64; y++) {
        for (int x = 0; x < 64; x++) {
          var pixel = image.getPixel(x, y);
          buffer[pixelIndex++] = img.getRed(pixel) / 255.0;
          buffer[pixelIndex++] = img.getGreen(pixel) / 255.0;
          buffer[pixelIndex++] = img.getBlue(pixel) / 255.0;
        }
      }
    }
    return convertedBytes.buffer.asUint32List();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Picker'),
      ),
      body: Center(
        child: _video == null
            ? Text('갤러리에서 동영상을 선택하세요')
            : FittedBox(
            fit: BoxFit.cover,
            child: Column(
              children: [
                Text("Result : ${_ffmpegOutput}"),
                Text("Predict: ${_results}%"),
              ],
            )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickVideo,
        child: Icon(Icons.video_library),
      ),
    );
  }
}