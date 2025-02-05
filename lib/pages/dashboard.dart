import 'package:flutter/material.dart';
import 'package:poop_app/util/counter.dart';
import 'package:poop_app/util/tracker_panel.dart';
import 'package:poop_app/util/coming_soon.dart';
import 'package:home_widget/home_widget.dart';

class Dashboard extends StatefulWidget {
  // const Dashboard({super.key});

  final String user;

  Dashboard({
    super.key,
    required this.user,
  });

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    _initializeWidgetData();
  }

  Future<void> _initializeWidgetData() async {
    await HomeWidget.saveWidgetData<String>('username', widget.user);
    // String? hello = await HomeWidget.getWidgetData<String>('username');
    // print("Current user is $hello");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.user}\'s poop tracker'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 40, top: 10, left: 30, right: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // incrementers
                  Flexible(
                      child: CounterScreen(user: this.widget.user), flex: 4),
                  SizedBox(height: 20),

                  // other tracker
                  Flexible(
                      flex: 3, child: TrackerPanel(user: this.widget.user)),
                  // Flexible(flex: 3, child: Container(color: Colors.yellow)),
                  SizedBox(height: 20),

                  // calendar (just box for now)
                  // Flexible(flex: 3, child: ComingSoon()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Center(
        // child: ElevatedButton(
          // onPressed: () {
            // Navigator.pop(context);
          // },
          // child: Text('Go back to Home Page'),
        // ),
      // ),
