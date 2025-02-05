import 'package:home_widget/home_widget.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'socket_service.dart';

class HomescreenWidget {
  static String? appGroupId;
  static String? iOSWidgetName;
  static bool isInitialized = false;
  late SocketService socketManager;

  HomescreenWidget({
    String? appGroupIdRef,
    String? widgetName,
  }) {
    // init: set widget app group id
    if (!isInitialized) {
      iOSWidgetName = widgetName;
      appGroupId = appGroupIdRef;
      print(appGroupIdRef);
      HomeWidget.setAppGroupId(appGroupId ?? '');
      isInitialized = true;
    }
  }

  // store data to shared preferences (stores in userdefaults under the hood)
  HomescreenWidget.updateData(dynamic data) {
    String res = jsonEncode(data);
    HomeWidget.saveWidgetData<String>('poopdb', res);
    HomeWidget.updateWidget(
      iOSName: iOSWidgetName,
    );
  }
}
