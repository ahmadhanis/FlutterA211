import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentaroom/models/config.dart';
import 'package:rentaroom/models/room.dart';

import '../screens/roomdetails.dart';

class RoomCard extends StatelessWidget {
  final Room room;
  final double screenHeight, screenWidth;
  const RoomCard(
      {Key? key,
      required this.room,
      required this.screenHeight,
      required this.screenWidth})
      : super(key: key);

  // BuildContext? get context => null;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onLongPress: () => {_deleteRoom(context)},
        onTap: () => {_displayRoom(context)},
        child: Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  Config.server +
                      "/rentaroom/images/" +
                      room.roomid.toString() +
                      "_1.jpg",
                  height: screenHeight / 8,
                  width: screenWidth / 2,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                room.area.toString(),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text('Montly: RM ${double.parse(room.price.toString()).toStringAsFixed(2)}'),
              Text(
                'Deposit: RM ${double.parse(room.deposit.toString()).toStringAsFixed(2)}',
              ),
            ],
          ),
          decoration: BoxDecoration(
              color: Colors.blueGrey, borderRadius: BorderRadius.circular(16)),
        ));
  }

  _deleteRoom(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: const Text(
            "Delete this room",
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
                Provider.of<RoomProvider>(context, listen: false)
                    .deleteRoom(room.roomid.toString());
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

  _displayRoom(BuildContext context) {
    Room detailroom = Room(
      roomid: room.roomid,
      title: room.title,
      description: room.description,
      area: room.area,
      price: room.price,
      contact: room.contact,
      deposit: room.deposit,
      state: room.state,
    );
    print(detailroom.title);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => RoomDetailsScreen(room: detailroom)));
  }
}
