import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rentaroom/models/room.dart';

class NewRoomScreen extends StatefulWidget {
  const NewRoomScreen({Key? key}) : super(key: key);

  @override
  State<NewRoomScreen> createState() => _NewRoomScreenState();
}

class _NewRoomScreenState extends State<NewRoomScreen> {
  late double screenHeight, screenWidth;
  File? _image1, _image2, _image3;
  var pathAsset = "assets/images/camera.png";
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _contactEditingController =
      TextEditingController();
  final TextEditingController _descEditingController = TextEditingController();
  final TextEditingController _stateEditingController = TextEditingController();
  final TextEditingController _priceEditingController = TextEditingController();
  final TextEditingController _areaEditingController = TextEditingController();
  final TextEditingController _depoEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Room'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              flex: 4,
              child: imagesContainer(context),
            ),
            Flexible(
              flex: 6,
              child: newRoomForm(context),
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(),
    );
  }

  void _selectImage(int pic) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            title: const Text(
              "Select from",
              style: TextStyle(),
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(screenWidth / 4, screenWidth / 4)),
                  child: const Text('Gallery'),
                  onPressed: () => {
                    Navigator.of(context).pop(),
                    _selectfromGallery(pic),
                  },
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(screenWidth / 4, screenWidth / 4)),
                  child: const Text('Camera'),
                  onPressed: () => {
                    Navigator.of(context).pop(),
                    _selectFromCamera(pic),
                  },
                ),
              ],
            ));
      },
    );
  }

  Future<void> _selectFromCamera(int pic) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 800,
      maxWidth: 800,
    );
    switch (pic) {
      case 1:
        _image1 = File(pickedFile!.path);
        _cropImage(1, _image1!);
        break;
      case 2:
        _image2 = File(pickedFile!.path);
        _cropImage(2, _image2!);
        break;
      case 3:
        _image3 = File(pickedFile!.path);
        _cropImage(3, _image3!);
        break;
    }
  }

  Future<void> _selectfromGallery(int pic) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 800,
      maxWidth: 800,
    );
    switch (pic) {
      case 1:
        _image1 = File(pickedFile!.path);
        _cropImage(1, _image1!);
        break;
      case 2:
        _image2 = File(pickedFile!.path);
        _cropImage(2, _image2!);
        break;
      case 3:
        _image3 = File(pickedFile!.path);
        _cropImage(3, _image3!);
        break;
    }
  }

  Future<void> _cropImage(int pic, File _img) async {
    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: _img.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
              ]
            : [
                CropAspectRatioPreset.square,
              ],
        androidUiSettings: const AndroidUiSettings(
            toolbarTitle: 'Crop',
            //toolbarColor: Colors.deepOrange,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false),
        iosUiSettings: const IOSUiSettings(
          title: 'Crop Image',
        ));

    switch (pic) {
      case 1:
        _image1 = croppedFile;
        setState(() {});
        break;
      case 2:
        _image2 = croppedFile;
        setState(() {});
        break;
      case 3:
        _image3 = croppedFile;
        setState(() {});
        break;
    }
  }

  Widget imagesContainer(BuildContext context) {
    return Container(
      decoration: myBoxDecoration(),
      padding: const EdgeInsets.all(2),
      margin: const EdgeInsets.all(5),
      // height: screenHeight,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Container(
                decoration: myBoxDecoration(),
                margin: const EdgeInsets.all(2),
                //height: screenHeight / 4,
                width: screenWidth / 1.5,
                child: GestureDetector(
                  onTap: () => {_selectImage(1)},
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Container(
                        decoration: BoxDecoration(
                      image: DecorationImage(
                        image: _image1 == null
                            ? AssetImage(pathAsset)
                            : FileImage(_image1!) as ImageProvider,
                        fit: BoxFit.fill,
                      ),
                    )),
                  ),
                )),
            Container(
                decoration: myBoxDecoration(),
                margin: const EdgeInsets.all(2),
                //height: screenHeight / 4,
                width: screenWidth / 1.5,
                child: GestureDetector(
                  onTap: () => {_selectImage(2)},
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Container(
                        decoration: BoxDecoration(
                      image: DecorationImage(
                        image: _image2 == null
                            ? AssetImage(pathAsset)
                            : FileImage(_image2!) as ImageProvider,
                        fit: BoxFit.fill,
                      ),
                    )),
                  ),
                )),
            Container(
                margin: const EdgeInsets.all(2),
                decoration: myBoxDecoration(),
                //height: screenHeight / 4,
                width: screenWidth / 1.5,
                child: GestureDetector(
                  onTap: () => {_selectImage(3)},
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Container(
                        decoration: BoxDecoration(
                      image: DecorationImage(
                        image: _image3 == null
                            ? AssetImage(pathAsset)
                            : FileImage(_image3!) as ImageProvider,
                        fit: BoxFit.fill,
                      ),
                    )),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget newRoomForm(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
          decoration: myBoxDecoration(),
          //height: screenHeight,
          width: screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "New Room Form",
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _titleEditingController,
                          validator: (val) =>
                              val!.isEmpty ? "Fill in title" : null,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            labelText: 'Title',
                            labelStyle: TextStyle(
                              fontSize: screenWidth * 0.04,
                            ),
                            hintText: 'Title',
                            prefixIcon: const Icon(Icons.title),
                            contentPadding: const EdgeInsets.all(5.0),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: _contactEditingController,
                          validator: (val) =>
                              val!.isEmpty ? "Fill in contact number" : null,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            labelText: 'Phone',
                            labelStyle: TextStyle(
                              fontSize: screenWidth * 0.04,
                            ),
                            hintText: 'Contact Number',
                            prefixIcon: const Icon(Icons.phone),
                            contentPadding: const EdgeInsets.all(5.0),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: _descEditingController,
                          minLines: 4,
                          maxLines: 4,
                          validator: (val) =>
                              val!.isEmpty ? "Fill in description" : null,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            labelText: 'Description',
                            labelStyle: TextStyle(
                              fontSize: screenWidth * 0.04,
                            ),
                            hintText: 'Describe your room',
                            prefixIcon: const Icon(Icons.notes),
                            contentPadding: const EdgeInsets.all(5.0),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 5,
                              child: TextFormField(
                                validator: (val) => val!.isEmpty
                                    ? "Fill in montly payment"
                                    : null,
                                controller: _priceEditingController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  labelText: 'Monthly',
                                  labelStyle: TextStyle(
                                    fontSize: screenWidth * 0.04,
                                  ),
                                  hintText: 'Montly Payment (RM)',
                                  prefixIcon: const Icon(Icons.money),
                                  contentPadding: const EdgeInsets.all(5.0),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Flexible(
                              flex: 5,
                              child: TextFormField(
                                validator: (val) =>
                                    val!.isEmpty ? "Fill in deposit" : null,
                                controller: _depoEditingController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  labelText: 'Deposit',
                                  labelStyle: TextStyle(
                                    fontSize: screenWidth * 0.04,
                                  ),
                                  hintText: 'Deposit',
                                  prefixIcon: const Icon(Icons.money_off),
                                  contentPadding: const EdgeInsets.all(5.0),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 5,
                              child: TextFormField(
                                validator: (val) =>
                                    val!.isEmpty ? "Fill in state" : null,
                                controller: _stateEditingController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  labelText: 'State',
                                  labelStyle: TextStyle(
                                    fontSize: screenWidth * 0.04,
                                  ),
                                  hintText: 'State',
                                  prefixIcon: const Icon(Icons.flag),
                                  contentPadding: const EdgeInsets.all(5.0),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Flexible(
                              flex: 5,
                              child: TextFormField(
                                controller: _areaEditingController,
                                validator: (val) =>
                                    val!.isEmpty ? "Fill in area" : null,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  labelText: 'Area',
                                  labelStyle: TextStyle(
                                    fontSize: screenWidth * 0.04,
                                  ),
                                  hintText: 'Area',
                                  prefixIcon: const Icon(Icons.map_rounded),
                                  contentPadding: const EdgeInsets.all(5.0),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(screenWidth, screenWidth * 0.1)),
                          child: const Text('Add Room'),
                          onPressed: () => {
                            _newRoomDialog(),
                          },
                        ),
                      ],
                    )),
              )
            ],
          )),
    );
  }

  _newRoomDialog() {
    if (!_formKey.currentState!.validate()) {
      Fluttertoast.showToast(
          msg: "Please fill in all the required fields",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      return;
    }
    if (_image1 == null && _image2 == null && _image3 == null) {
      Fluttertoast.showToast(
          msg: "Please take the room picture",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Add this room",
            style: TextStyle(),
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _addNewRoom();
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _addNewRoom() async {
    Room room = Room(
      title: _titleEditingController.text,
      description: _descEditingController.text,
      area: _areaEditingController.text,
      price: _priceEditingController.text,
      contact: _contactEditingController.text,
      deposit: _depoEditingController.text,
      state: _stateEditingController.text,
    );
    bool isSuccess = await Provider.of<RoomProvider>(context, listen: false)
        .addRoom(room, _image1!, _image2!, _image3!);
    if (isSuccess) {
      Fluttertoast.showToast(
          msg: "Add Success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      Navigator.of(context).pop();
    } else {
      Fluttertoast.showToast(
          msg: "Add Failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      return;
    }
  }
}
