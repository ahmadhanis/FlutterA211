import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rentaroom/models/config.dart';
import 'package:rentaroom/models/room.dart';

class RoomDetailsScreen extends StatefulWidget {
  final Room room;

  const RoomDetailsScreen({Key? key, required this.room}) : super(key: key);

  @override
  State<RoomDetailsScreen> createState() => _RoomDetailsScreenState();
}

class _RoomDetailsScreenState extends State<RoomDetailsScreen> {
  late double screenHeight, screenWidth;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _contactEditingController =
      TextEditingController();
  final TextEditingController _descEditingController = TextEditingController();
  final TextEditingController _stateEditingController = TextEditingController();
  final TextEditingController _priceEditingController = TextEditingController();
  final TextEditingController _areaEditingController = TextEditingController();
  final TextEditingController _depoEditingController = TextEditingController();
  bool editForm = false;

  @override
  void initState() {
    super.initState();
    _titleEditingController.text = widget.room.title.toString();
    _contactEditingController.text = widget.room.contact.toString();
    _descEditingController.text = widget.room.description.toString();
    _stateEditingController.text = widget.room.state.toString();
    _priceEditingController.text = widget.room.price.toString();
    _areaEditingController.text = widget.room.area.toString();
    _depoEditingController.text = widget.room.deposit.toString();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Room Details'),
          actions: [
            IconButton(onPressed: _onEditForm, icon: const Icon(Icons.edit))
          ],
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
              child: roomDetails(context),
            )
          ],
        )));
  }

  Widget imagesContainer(BuildContext context) {
    return Container(
      //height: screenHeight / 2.5,
      padding: const EdgeInsets.all(2),
      margin: const EdgeInsets.all(5),
      decoration: myBoxDecoration(),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: GestureDetector(
                onTap: () => {_displayImage(1, context)},
                child: SizedBox(
                    child: Image.network(Config.server +
                        "/rentaroom/images/" +
                        widget.room.roomid.toString() +
                        '_1.jpg')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: GestureDetector(
                onTap: () => {_displayImage(2, context)},
                child: SizedBox(
                    child: Image.network(Config.server +
                        "/rentaroom/images/" +
                        widget.room.roomid.toString() +
                        '_2.jpg')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: GestureDetector(
                onTap: () => {_displayImage(3, context)},
                child: SizedBox(
                    child: Image.network(Config.server +
                        "/rentaroom/images/" +
                        widget.room.roomid.toString() +
                        '_3.jpg')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget roomDetails(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
        decoration: myBoxDecoration(),
        //height: screenHeight / 1.6,
        width: screenWidth,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Room Details",
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
                          enabled: editForm,
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
                          enabled: editForm,
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
                            enabled: editForm,
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
                                enabled: editForm,
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
                                enabled: editForm,
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
                                  enabled: editForm,
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
                                  enabled: editForm,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Visibility(
                          visible: editForm,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize:
                                    Size(screenWidth, screenWidth * 0.1)),
                            child: const Text('Update Room'),
                            onPressed: () => {
                              _editRoomDialog(),
                            },
                          ),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ));
  }

  void _onEditForm() {
    if (!editForm) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Text(
              "Edit this room",
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
                  setState(() {
                    editForm = true;
                  });
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
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(),
    );
  }

  _editRoomDialog() {
    if (!_formKey.currentState!.validate()) {
      Fluttertoast.showToast(
          msg: "Please fill in all the required fields",
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
            "Update this room",
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
                _updateRoom();
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

  _displayImage(int i, context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                //width: screenWidth,
                child: Image.network(Config.server +
                    "/rentaroom/images/" +
                    widget.room.roomid.toString() +
                    '_' +
                    i.toString() +
                    '.jpg'),
              ),
              TextButton(
                child: const Text(
                  "Close",
                  style: TextStyle(),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _updateRoom() async {
    Room updateRoom = Room(
      roomid: widget.room.roomid,
      title: _titleEditingController.text,
      description: _descEditingController.text,
      area: _areaEditingController.text,
      price: _priceEditingController.text,
      contact: _contactEditingController.text,
      deposit: _depoEditingController.text,
      state: _stateEditingController.text,
    );
    bool isSuccess = await Provider.of<RoomProvider>(context, listen: false)
        .updateRoom(updateRoom);
    if (isSuccess) {
      Fluttertoast.showToast(
          msg: "Update Success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      Navigator.of(context).pop();
    } else {
      Fluttertoast.showToast(
          msg: "Update Failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      return;
    }
  }
}
