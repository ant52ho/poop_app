// import 'my_socket_client.dart';
// import 'package:socket_io_client/socket_io_client.dart';

// class PoopClient extends MySocketClient {
//   PoopClient(String username) : super(username) {
//     onInit();
//   }

//   @override
//   void subscribe(List<String> toSubscribe) {
//     socket.emit('subscribe', toSubscribe);

//     // handle subscriptions
//     for (String channel in toSubscribe) {
//       socket.on(channel, (data) {
//         print('$username received data from channel $channel: $data');
//       });
//     }
//   }
// }