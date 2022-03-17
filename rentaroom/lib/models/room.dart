import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'config.dart';

class Room {
  String? roomid;
  String? contact;
  String? title;
  String? description;
  String? price;
  String? deposit;
  String? state;
  String? area;
  String? dateCreated;
  String? latitude;
  String? longitude;

  Room(
      {this.roomid,
      this.contact,
      this.title,
      this.description,
      this.price,
      this.deposit,
      this.state,
      this.area,
      this.dateCreated,
      this.latitude,
      this.longitude});

  Room.fromJson(Map<String, dynamic> json) {
    roomid = json['roomid'];
    contact = json['contact'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    deposit = json['deposit'];
    state = json['state'];
    area = json['area'];
    dateCreated = json['date_created'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['roomid'] = roomid;
    data['contact'] = contact;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['deposit'] = deposit;
    data['state'] = state;
    data['area'] = area;
    data['date_created'] = dateCreated;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}

class RoomProvider with ChangeNotifier {
  List<Room> roomList = [];

  getRooms() async {
    http.post(Uri.parse(Config.server + "/rentaroom/php/load_rooms.php"),
        body: {}).then((response) {
      var extractdata = json.decode(response.body);
      if (response.statusCode == 200 && extractdata['status'] == 'success') {
        extractdata = extractdata['data']['rooms'];
        roomList =
            extractdata.map<Room>((item) => Room.fromJson(item)).toList();
        notifyListeners();
      }
    });
  }

  Future<bool> addRoom(
      Room room, File imageFile1, File imageFile2, File imageFile3) async {
    String base64Image1 = base64Encode(imageFile1.readAsBytesSync());
    String base64Image2 = base64Encode(imageFile2.readAsBytesSync());
    String base64Image3 = base64Encode(imageFile3.readAsBytesSync());
    var url = Uri.parse(Config.server + '/rentaroom/php/new_room.php');
    var response = await http.post(url, body: {
      'title': room.title,
      'contact': room.contact,
      'description': room.description,
      'state': room.state,
      'price': room.price,
      'area': room.area,
      'deposit': room.deposit,
      'image1': base64Image1,
      'image2': base64Image2,
      'image3': base64Image3,
    });
    var extractdata = json.decode(response.body);
    if (response.statusCode == 200 && extractdata['status'] == 'success') {
      getRooms();
      return true;
    }
    return false;
  }

  Future<bool> updateRoom(Room room) async {
    var url = Uri.parse(Config.server + '/rentaroom/php/update_room.php');
    var response = await http.post(url, body: {
      'roomid': room.roomid,
      'title': room.title,
      'contact': room.contact,
      'description': room.description,
      'state': room.state,
      'price': room.price,
      'area': room.area,
      'deposit': room.deposit,
    });
    var extractdata = json.decode(response.body);
    if (response.statusCode == 200 && extractdata['status'] == 'success') {
      getRooms();
      return true;
    }
    return false;
  }

  Future<bool> deleteRoom(String roomid) async {
    var url = Uri.parse(Config.server + '/rentaroom/php/delete_room.php');
    var response = await http.post(url, body: {
      'roomid': roomid,
    });
    var extractdata = json.decode(response.body);
    if (response.statusCode == 200 && extractdata['status'] == 'success') {
      getRooms();
      return true;
    }
    return false;
  }
}
