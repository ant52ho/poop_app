import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_kit_plugin/widget_kit_plugin.dart';

class AppStateNotifier extends StatefulWidget {
  const AppStateNotifier({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  State<AppStateNotifier> createState() => _AppStateNotifierState();
}

class _AppStateNotifierState extends State<AppStateNotifier>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // we want to reload the widget whenver it goes to hidden
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    // reload widget
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.resumed) {
      await WidgetKit.reloadTimelines("poopWidget");
      // await WidgetKit.reloadAllTimelines();
      print('reloaded timelines');
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
