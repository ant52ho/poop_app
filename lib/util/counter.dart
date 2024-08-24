import 'package:flutter/material.dart';
import 'socket_service.dart';
import 'package:provider/provider.dart';
import 'package:poop_app/globals.dart' as globals;

class CounterScreen extends StatefulWidget {
  final String user;
  const CounterScreen({super.key, required this.user});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  // late Function(dynamic) _handleData;
  int _counter = 0;
  late String user;
  late String subscribed;
  late SocketService socketManager;
  Color color = Color.fromARGB(255, 150, 141, 144);

  void _handleData(dynamic data) {
    print(data);
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

    // determine what events to subscribe to
    // Anthony: poop/clare
    // Clare: poop/anthony
    subscribed = 'poop/${widget.user}';
    socketManager.subscribe(subscribed, _handleData);

    // Get current poop state
    socketManager.subscribe('poop/$user/getData', _handleData);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      socketManager.emit('publish', 'poop/$user/getData');
    });

    _setColour(widget.user);
  }

  void _setColour(user) {
    if (user == 'clare') {
      color = Color.fromARGB(255, 229, 82, 131);
    } else if (user == 'anthony') {
      color = Color.fromARGB(215, 33, 177, 243);
    }
  }

  @override
  void dispose() {
    socketManager.unsubscribe(subscribed, _handleData);
    super.dispose();
  }

  void _increment() {
    String cmd = 'poop/$user/increment';
    socketManager.emit('publish', cmd);
  }

  void _decrement() {
    String cmd = 'poop/$user/decrement';
    socketManager.emit('publish', cmd);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Background color
                  padding: EdgeInsets.all(10), // Size of the button
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: _decrement,
                child: Container(
                  alignment: Alignment.center,
                  width: 100,
                  child: Icon(
                    Icons.remove,
                    color: Colors.red,
                    size: 50,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Background color
                  padding: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: _increment,
                child: Container(
                  alignment: Alignment.center,
                  width: 100,
                  child: Icon(
                    Icons.add,
                    color: Colors.green,
                    size: 50,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Flexible(
          flex: 3,
          child: Container(
            alignment: Alignment.center,
            // padding: EdgeInsets.all(15),
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
                  '${globals.users[user]?['name']} has pooped',
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
          ),
        )
      ],
    );
  }
}
