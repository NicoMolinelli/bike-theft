import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:front/models/bike.dart';

import 'widgets/picture.dart';

class AddBike extends StatefulWidget {
  const AddBike({ Key? key }) : super(key: key);

  @override
  State<AddBike> createState() => _AddBikeState();
}

class _AddBikeState extends State<AddBike> {

  late CameraDescription camera;

  late TextEditingController _frameController;

  String path = "";

  Bike? bike;

  @override
  void initState() {
    _initCamera();
    _frameController = TextEditingController();
    super.initState();
  }

  void _initCamera() async {
    final cameras = await availableCameras();
    camera = cameras.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Claim your bike ownership'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Spacer(),
              Container(
                height: 200,
                child: Row(
                  children: [
                    Expanded(
                      child: path.isEmpty ?
                        Placeholder(strokeWidth: 0.5) : Image.file(File(path))),
                    Expanded(
                      child: Center(
                        child: FloatingActionButton(
                          onPressed: () async {
                            String res = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TakePictureScreen(
                                  camera: camera
                                )
                              )
                            );
                            print("RES:${res}");
                            setState(() {
                              path = res;
                            });
                        }, child: Icon(Icons.camera_alt_rounded),)
                      )
                    )
                  ],
                ),
              ),
              Divider(),
              Spacer(),
              Padding(padding: 
                EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text(
                      'Insert or scan your bike frame number',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Icon(Icons.help_outline, size: 22,)
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _frameController,
                      decoration: InputDecoration(
                        hintText: 'C025542KB4322',
                        isDense: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 50.0),
                          borderRadius: BorderRadius.circular(20)
                        )
                      ),
                    ),
                  ),
                  IconButton(onPressed: () {},
                    icon: Icon(Icons.document_scanner))
                ],
              ),
              Spacer(flex: 2,),
              ElevatedButton(
                onPressed: _onClaim,
                child: Text("Claim")
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onClaim() {
    if (_frameController.text.isEmpty || path.isEmpty)
      return;
    bike = Bike(
      path,
      "Bike",
      _frameController.text,
      false
    );
    Navigator.pop(context, bike);
  }
}
