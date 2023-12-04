import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class FotoPage extends StatefulWidget {
  const FotoPage({super.key});

  @override
  State<FotoPage> createState() => _FotoPageState();
}

class _FotoPageState extends State<FotoPage> {
  List<CameraDescription> cameras = [];
  CameraController? controller;
  XFile? imagem;
  Size? size;

  @override
  void initState() {
    super.initState();
    _loadCameras();
  }

  _loadCameras() async {
    try {
      cameras = await availableCameras();
      _startCamera();
    } on CameraException catch (e) {
      debugPrint(e.description);
    }
  }

  _startCamera() {
    if (cameras.isEmpty) {
      debugPrint('Camera não encontrada');
    } else {
      _previewCamera(cameras.first);
    }
  }

  _previewCamera(CameraDescription camera) async {
    final CameraController cameraController = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    controller = cameraController;
    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      debugPrint(e.description);
    }

    if (mounted) {
      setState(() {});
    }
  }

  _arquivoWidget() {
    return SizedBox(
      child: imagem == null
          ? _cameraPreviewWidget()
          : Image.file(File(imagem!.path), fit: BoxFit.contain),
    );
  }

  _cameraPreviewWidget() {
    final CameraController? cameraController = controller;
    if (cameraController == null) {
      return const Text(
        'Camera não disponível',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else if (!cameraController.value.isInitialized) {
      return const Text(
        'Camera disponível não inicializada',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          CameraPreview(controller!),
          _botaoCapturaWidget(),
        ],
      );
    }
  }

  _botaoCapturaWidget() {
    return Padding(
      padding: EdgeInsets.only(bottom: 24),
      child: CircleAvatar(
        backgroundColor: Colors.black.withOpacity(0.5),
        radius: 32,
        child: IconButton(
          icon: Icon(
            Icons.camera_alt,
            color: Colors.white,
            size: 30,
          ),
          onPressed: tirarFoto,
        ),
      ),
    );
  }

  tirarFoto() async {
    final CameraController? cameraController = controller;
    if (cameraController != null && cameraController.value.isInitialized) {
      try {
        XFile file = await cameraController.takePicture();
        if (mounted) setState(() => imagem = file);
      } on CameraException catch (e) {
        debugPrint(e.description);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Roupa'),
        backgroundColor: Colors.grey[900],
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        color: Colors.grey[900],
        child: Center(
          child: _arquivoWidget(),
        ),
      ),
      floatingActionButton: (imagem != null)
          ? FloatingActionButton.extended(
              onPressed: () => Navigator.pop(context), label: Text('Finalizar'))
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
