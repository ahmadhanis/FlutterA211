import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentaroom/views/widgets/roomcard.dart';
import 'models/room.dart';
import 'views/screens/newroom.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => RoomProvider(),
      child: MaterialApp(
        title: 'RentaRoom',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<RoomProvider>(context, listen: false).getRooms();
    double screenHeight, screenWidth;
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('RentaRoom'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Consumer<RoomProvider>(builder: (context, room, _) {
          List<Room> roomList = room.roomList;
          //roomList.forEach((element) => print(element.title));
          return GridView.builder(
            itemCount: room.roomList.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemBuilder: (BuildContext context, int index) {
              return RoomCard(
                room: roomList[index],
                screenHeight: screenHeight,
                screenWidth: screenWidth,
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
        onPressed: () {
          _newRoom(context);
        },
      ),
    );
  }

  _newRoom(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: const Text(
            "Add new room",
            style: TextStyle(),
          ),
          content: const Text(
            "Are you sure?",
            style: TextStyle(),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const NewRoomScreen()));
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
