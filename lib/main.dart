import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
import 'package:front/models/bike.dart';
// import 'package:front/widgets/picture.dart';
import 'add_bike.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final cameras = await availableCameras();
  runApp(App());
}

class App extends StatelessWidget {
  const App({
    Key? key,
    // required this.camera,
  }) : super(key: key);

  // final CameraDescription camera;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
            minimumSize: const Size.fromHeight(45),
            padding: const EdgeInsets.all(12.0)
          ),
  )
      ),
      routes: {
        '/add': (context) => const AddBike()
      },
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key,
  // required this.camera
  }) : super(key: key);

  // final CameraDescription camera;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Bike> _bikes = [
    Bike.mock()
  ];

  void _addBike() async {
    Bike? newBike = await Navigator.pushNamed(context, '/add') as Bike;
    if (newBike == null)
      return;
    print(newBike.frameId);
    setState(() {
      _bikes.add(newBike);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BottomAppBar(
      //   color: Theme.of(context).primaryColor,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     children: [
            // IconButton(
            //   onPressed: () {},
            //   icon: const Icon(Icons.home)
            // ),
            // IconButton(
            //   onPressed: () {},
            //   icon: const Icon(Icons.home)
            // ),
            // IconButton(
            //   onPressed: () {},
            //   icon: const Icon(Icons.home)
            // )
      //     ]
      //   )
      // ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('My bikes',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _bikes.length,
                  itemBuilder: (context, i) => Container(
                    height: 200,
                    child: Card(
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _bikes[i].imgPath != 'assets/bike.jpg' ? Image.file(File(_bikes[i].imgPath),
                                fit: BoxFit.contain,
                              ): Image.asset('assets/bike.jpg'),
                            )
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text("${_bikes[i].name} ${i + 1}"),
                                  Text(_bikes[i].frameId),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(2),
                                      minimumSize: Size(100, 25)
                                    ),
                                    child: Text('Got stolen')
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(2),
                                      minimumSize: Size(100, 25)
                                    ),
                                    child: Text('Sell')
                                  )
                                ]
                              ),
                            ))
                        ],
                      )
                    ),
                  )

                )
              ),
            ],
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addBike,
        child: const Icon(Icons.add),
      )
    );
  }
}
