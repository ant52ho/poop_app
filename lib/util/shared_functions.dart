// shared functions file.
// includes increment, decrement, etc
// should be imported by interactive callbacks file

import 'package:poop_app/util/socket_service.dart';
import 'package:provider/provider.dart';

class SharedFunctions {
  // you will have to specify the socket every time you call a function

  static void increment(context, String user) {
    SocketService socketManager =
        Provider.of<SocketService>(context, listen: false);
    String cmd = 'poop/$user/increment';
    socketManager.emit('publish', cmd);
  }

  static void decrement(context, String user) {
    SocketService socketManager =
        Provider.of<SocketService>(context, listen: false);
    String cmd = 'poop/$user/decrement';
    socketManager.emit('publish', cmd);
  }
}
