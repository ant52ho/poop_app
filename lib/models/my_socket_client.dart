// import 'package:socket_io_client/socket_io_client.dart' as IO;

// class MySocketClient {
//   late String username;
//   late List<String> subscribed;
//   int port = 5000;
//   String ip = "0.0.0.0";
//   late IO.Socket socket;

//   // constructor
//   MySocketClient(this.username) {
//     subscribed = [];
//     String url = 'http://$ip:$port';

//     socket = IO.io(url, <String, dynamic>{
//       'transports': ['websocket'],
//       'autoConnect': false,
//     });

//     print("Running socket program");
//     print('Connecting to $url');

//     // handle connection event
//     socket.on('connect', (_) {
//       print('Connected to the server');
//     });

//     // handle disconnection event
//     socket.on('disconnect', (_) {
//       print('Disconnected from the server');
//     });

//     // connect the socket
//     socket.connect();
//   }

//   // handle subscribe
//   void subscribe(String toSubscribe) {
//     socket.emit('subscribe', toSubscribe);
//   }

//   // handle unsubscribe
//   void unsubscribe(String toUnsubscribe) {
//     socket.emit('unsubscribe', toUnsubscribe);
//   }

//   // handle publish
//   void publish(String command) {
//     socket.emit('publish', command);
//   }
// }
