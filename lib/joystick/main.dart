import 'package:flutter/material.dart';
import 'package:control_pad/control_pad.dart';
import 'package:smars_joystick/joystick/socket.dart';
import 'package:web_socket_channel/io.dart';

class Joystick extends StatelessWidget {
  Joystick({Key key}) : super(key: key);
  //!TODO This needs to be changed in the future to be filled by the user or something.
  WebSocket socket =
      WebSocket(channel: IOWebSocketChannel.connect('ws://192.168.1.20:81'));

  @override
  Widget build(BuildContext context) {
    JoystickDirectionCallback onDirectionChanged(
        double degrees, double distance) {
      String data =
          "Degree : ${degrees.toStringAsFixed(2)}, distance : ${distance.toStringAsFixed(2)}";
      print(data);
      if(degrees > 315 || degrees < 45) {
        // up
        this.socket.sendMessage("u");
      } else if(degrees > 45 && degrees < 135) {
        // right
        this.socket.sendMessage("r");
      } else if(degrees > 135 && degrees < 225) {
        // down
        this.socket.sendMessage("d");
      } else if(degrees > 225 && degrees < 315) {
        // left
        this.socket.sendMessage("l");
      }
      if (distance < 0.2) {
        // stop
        this.socket.sendMessage("s");
      }
      
    }

    return Container(
      child: JoystickView(
        onDirectionChanged: onDirectionChanged,
      ),
    );
  }
}
