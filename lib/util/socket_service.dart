import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../util/homescreen_widget.dart';

class SocketService with ChangeNotifier {
  final Map<String, List<Function(dynamic)>> _eventSubscribers = {};
  late IO.Socket _socket;

  // connects to a socket, then stores data into appgroup
  SocketService(String uri) {
    print('Connecting to $uri');
    _socket = IO.io(uri, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    _socket.onConnect((_) {
      print('Connected to socket server');
    });

    _socket.onDisconnect((_) {
      print('Disconnected from socket server');
    });

    _socket.onAny((event, data) {
      _handleWidgetRefresh(event, data);
    });

    _widgetRefreshInit();
  }

  // signals widget to refresh when any message is received
  void _handleWidgetRefresh(event, data) {
    // ignore if event is a getData (no net change + we will call getdata later)
    if (event.contains('getData') || event.contains('getAllData')) return;

    // stores info into defaults using initted sublist & publish
    emit("publish", "poop/null/getAllData");
  }

  // determines which eps to subscribe to to setup widget refresh
  void _widgetRefreshInit() {
    subscribe('poop/getAllData', _getAllDataCallback);
  }

  void _getAllDataCallback(dynamic data) async {
    HomescreenWidget.updateData(data);
    print("updated");
  }

  // Subscribes to event by adding to event sub list
  void subscribe(String event, Function(dynamic) callback) {
    if (_eventSubscribers.containsKey(event)) {
      _eventSubscribers[event]?.add(callback);
    } else {
      _eventSubscribers[event] = [callback];
    }

    // add a "onlisten" event if it's the first member
    if (_eventSubscribers[event]?.length == 1) {
      _socket.on(event, (data) {
        _notifySubscribers(event, data);
      });
    }
  }

  // unsub from event by removing it from event sub list
  void unsubscribe(String event, Function(dynamic) callback) {
    _eventSubscribers[event]?.remove(callback);

    // stop listening if there aren't any more subscribers
    // the ?? op: if lvalue is null, returns true.
    if (_eventSubscribers[event]?.isEmpty ?? true) {
      _eventSubscribers.remove(event);
      _socket.off(event);
    }
  }

  // Runs the callback function for each subscriber
  void _notifySubscribers(String event, dynamic data) {
    final subscribers = _eventSubscribers[event];
    if (subscribers != null) {
      for (var callback in subscribers) {
        callback(data);
      }
    }
  }

  // sending data
  void emit(String event, dynamic data) {
    _socket.emit(event, data);
  }

  // override destructor
  @override
  void dispose() {
    _socket.disconnect();
    super.dispose();
  }
}
