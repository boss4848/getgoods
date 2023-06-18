import 'package:flutter/material.dart';

class IssueTypeWidget extends StatefulWidget {
  const IssueTypeWidget({super.key});

  @override
  _IssueTypeWidgetState createState() => _IssueTypeWidgetState();
}

class _IssueTypeWidgetState extends State<IssueTypeWidget> {
  List<Widget> widgets = [
    Container(
      color: Colors.red,
      child: Center(child: Text('Widget 1')),
    ),
    Container(
      color: Colors.green,
      child: Center(child: Text('Widget 2w')),
    ),
    Container(
      color: Colors.blue,
      child: Center(child: Text('Widget 3')),
    ),
    Container(
      color: Colors.blue,
      child: Center(child: Text('Widget 4')),
    ),
    Container(
      color: Colors.blue,
      child: Center(child: Text('Widget 5')),
    ),
  ];

  int activeIndex = 0;

  void setActiveState(int index) {
    setState(() {
      activeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Row(
            children: [
              WidgetButton(
                onPressed: () => setActiveState(0),
                isActive: activeIndex == 0,
                buttonText: 'Hot\nIssues',
                icon: Icon(Icons.local_fire_department),
              ),
              SizedBox(width: 12,),
              WidgetButton(
                onPressed: () => setActiveState(2),
                isActive: activeIndex == 2,
                buttonText: 'Payment\nMethods',
                icon: Icon(Icons.account_balance_wallet),
              ),
              SizedBox(width: 12,),
              WidgetButton(
                onPressed: () => setActiveState(3),
                isActive: activeIndex == 3,
                buttonText: 'Store\nUsage',
                icon: Icon(Icons.store),
              ),
              SizedBox(width: 12,),
              WidgetButton(
                onPressed: () => setActiveState(4),
                isActive: activeIndex == 4,
                buttonText: 'Order\nTracking',
                icon: Icon(Icons.local_shipping),
              ),
              SizedBox(width: 12,),
              WidgetButton(
                onPressed: () => setActiveState(1),
                isActive: activeIndex == 1,
                buttonText: 'About\nGetGoods',
                icon: Icon(Icons.info_rounded),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            child: activeIndex >= 0 && activeIndex < widgets.length
                ? widgets[activeIndex]
                : Container(),
          ),
        ],
      );
  }
}

class WidgetButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isActive;
  final String buttonText;
  final Icon icon;
  final Color activeColor = Colors.green;
  final Color deactiveColor = Colors.grey;

  WidgetButton({required this.onPressed, required this.isActive, required this.buttonText, required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextButton(
          onPressed: onPressed,
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            side: MaterialStateProperty.all<BorderSide>(
              BorderSide(color: isActive ? activeColor : deactiveColor),
            ),
          ),
          child: SizedBox(
            // height: 80,
            width: 62,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8,),
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon.icon,
                    size: 22.0,
                    color: isActive ? activeColor : deactiveColor,
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    buttonText,
                    style: TextStyle(
                      color: isActive ? activeColor : deactiveColor,
                      fontSize: 12.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
  }
}