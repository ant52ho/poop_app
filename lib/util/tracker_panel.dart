import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'socket_service.dart';
import 'package:poop_app/globals.dart' as globals;

class TrackerPanel extends StatefulWidget {
  final String user;
  const TrackerPanel({super.key, required this.user});

  @override
  State<TrackerPanel> createState() => _TrackerPanelState();
}

class _TrackerPanelState extends State<TrackerPanel> {
  late int _counter = 0;
  late String user;
  late SocketService socketManager;
  late String subscribed;
  Color color = Color.fromARGB(255, 150, 141, 144);

  void _handleData(dynamic data) {
    if (mounted) {
      setState(() {
        _counter = data;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    socketManager = Provider.of<SocketService>(context, listen: false);
    user = widget.user;

    String targetUser = widget.user == 'anthony' ? 'clare' : 'anthony';
    subscribed = 'poop/$targetUser';
    socketManager.subscribe(subscribed, _handleData);

    // Get current poop state
    socketManager.subscribe('poop/$targetUser/getData', _handleData);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      socketManager.emit('publish', 'poop/$targetUser/getData');
    });

    _setColour(widget.user);
  }

  void _setColour(user) {
    if (user == 'clare') {
      color = Color.fromARGB(215, 33, 177, 243);
    } else if (user == 'anthony') {
      color = Color.fromARGB(255, 229, 82, 131);
    }
  }

  @override
  void dispose() {
    socketManager.unsubscribe(subscribed, _handleData);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: color, // Background color of the rectangle
        borderRadius: BorderRadius.circular(40.0), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // Shadow position
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${globals.users[user == 'anthony' ? 'clare' : 'anthony']?['name']} has pooped',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 5, bottom: 5)),
          Text(
            '$_counter', // Highlighted number
            style: TextStyle(
              fontSize: 40.0, // Larger font size for the number
              color: Colors.yellow, // Different color for the number
              fontWeight: FontWeight.bold, // Bold text for the number
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 5, bottom: 5)),
          Text(
            'times',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
